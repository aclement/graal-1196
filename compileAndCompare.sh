#!/usr/bin/env bash

./mvnw clean package

export JAR="commandlinerunner-0.0.1-SNAPSHOT.jar"

rm clr
printf "Unpacking $JAR"
rm -rf unpack
mkdir unpack
cd unpack
jar -xvf ../target/$JAR >/dev/null 2>&1
cp -R META-INF BOOT-INF/classes


printf "\n\nPatch spring"
../adjustConfiguration.sh  org.springframework.boot.autoconfigure.data.mongo.MongoDataAutoConfiguration org.springframework.boot.autoconfigure.jooq.JooqAutoConfiguration \
 org.springframework.boot.actuate.autoconfigure.endpoint.jmx.JmxEndpointAutoConfiguration 


cd BOOT-INF/classes
export LIBPATH=`find ../../BOOT-INF/lib | tr '\n' ':'`
export CP=.:$LIBPATH

#echo "Running..."
java -classpath $CP com.example.commandlinerunner.CommandlinerunnerApplication

printf "\n\nCompile\n"
cp ../../../logging.properties .
cp ../../../proxy.json .
native-image \
  -Dorg.springframework.boot.logging.LoggingSystem=none \
  -Dio.netty.noUnsafe=true \
  --no-server -H:Name=clr -H:ReflectionConfigurationFiles=../../../reflect.json \
  -H:IncludeResources='META-INF/spring.components|META-INF/spring.factories|application.properties|logging.properties|org/springframework/boot/context/properties/EnableConfigurationPropertiesImportSelector.class|org/springframework/boot/context/properties/EnableConfigurationPropertiesImportSelector\$ConfigurationPropertiesBeanRegistrar.class|org/springframework/boot/context/properties/ConfigurationPropertiesBindingPostProcessorRegistrar.class|org/springframework/boot/autoconfigure/.*/.*Configuration.class|com/example/commandlinerunner/CLR.class|com/example/commandlinerunner/CommandlinerunnerApplication.class|org/springframework/boot/CommandLineRunner.class|org/springframework/boot/autoconfigure/condition/SearchStrategy.class|org/springframework/context/EnvironmentAware.class|org/springframework/beans/factory/BeanFactoryAware.class|org/springframework/beans/factory/Aware.class' \
  -H:+ReportExceptionStackTraces \
  --allow-incomplete-classpath \
  --report-unsupported-elements-at-runtime \
  --delay-class-initialization-to-runtime=org.springframework.boot.liquibase.LiquibaseServiceLocatorApplicationListener\$LiquibasePresent,\
org.springframework.boot.json.JacksonJsonParser,\
org.springframework.boot.autoconfigure.jdbc.HikariDriverConfigurationFailureAnalyzer,\
org.springframework.boot.diagnostics.analyzer.ValidationExceptionFailureAnalyzer,\
org.springframework.core.type.filter.AspectJTypeFilter,\
org.springframework.boot.autoconfigure.cache.JCacheCacheConfiguration,\
org.springframework.boot.autoconfigure.cache.RedisCacheConfiguration,\
org.springframework.boot.autoconfigure.cache.InfinispanCacheConfiguration,\
org.springframework.boot.json.GsonJsonParser,\
org.springframework.core.io.VfsUtils \
-H:DynamicProxyConfigurationFiles=proxy.json \
  -cp $CP com.example.commandlinerunner.CommandlinerunnerApplication

mv clr ../../..

printf "\n\nExisting app: (java -cp . com.example.commandlinerunner.CommandlinerunnerApplication)\n"
time java -classpath $CP com.example.commandlinerunner.CommandlinerunnerApplication

printf "\n\nCompiled app (clr)\n"
cd ../../..
time ./clr

