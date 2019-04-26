export SBA=`find . -name "spring-boot-autoconfigure*"`
rm -rf repackSBA
mkdir repackSBA
cd repackSBA
jar -xf ../$SBA 
echo "Entries: "
wc -l META-INF/spring.factories

for i in "$@"
do
  cat META-INF/spring.factories | grep -v $i > foo
  mv foo META-INF/spring.factories
  rm `echo $i | sed 's/\./\//g'`*.class
done

echo "Slimming spring.factories"
cp ../../META-INF/spring.factories.slim    META-INF/spring.factories

echo "Entries now:"
wc -l META-INF/spring.factories

rm ../$SBA
jar -cMf ../$SBA .
cd ..
rm -rf repackSBA
