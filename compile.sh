cd unpack/BOOT-INF/classes
export LIBPATH=`find ../../BOOT-INF/lib | tr '\n' ':'`
export CP=.:$LIBPATH
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

