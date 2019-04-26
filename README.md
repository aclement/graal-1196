# graal-1196

Run `compile.sh` to see the graal error:
```
[clr:21526]     analysis:  15,370.92 ms
Fatal error: java.lang.NoClassDefFoundError
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
	at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
	at java.util.concurrent.ForkJoinTask.getThrowableException(ForkJoinTask.java:598)
	at java.util.concurrent.ForkJoinTask.get(ForkJoinTask.java:1005)
	at com.oracle.svm.hosted.NativeImageGenerator.run(NativeImageGenerator.java:459)
	at com.oracle.svm.hosted.NativeImageGeneratorRunner.buildImage(NativeImageGeneratorRunner.java:289)
	at com.oracle.svm.hosted.NativeImageGeneratorRunner.build(NativeImageGeneratorRunner.java:427)
	at com.oracle.svm.hosted.NativeImageGeneratorRunner.main(NativeImageGeneratorRunner.java:109)
Caused by: java.lang.NoClassDefFoundError: org/springframework/dao/DataAccessException
	at java.lang.Class.getDeclaredMethods0(Native Method)
	at java.lang.Class.privateGetDeclaredMethods(Class.java:2701)
	at java.lang.Class.privateGetMethodRecursive(Class.java:3048)
	at java.lang.Class.getMethod0(Class.java:3018)
	at java.lang.Class.getMethod(Class.java:1784)
	at com.oracle.svm.core.hub.DynamicHub.initEnumConstantsAtRuntime(DynamicHub.java:390)
	at com.oracle.svm.hosted.analysis.Inflation.checkType(Inflation.java:194)
	at java.lang.Iterable.forEach(Iterable.java:75)
	at java.util.Collections$UnmodifiableCollection.forEach(Collections.java:1080)
	at com.oracle.svm.hosted.analysis.Inflation.checkObjectGraph(Inflation.java:136)
	at com.oracle.graal.pointsto.BigBang.checkObjectGraph(BigBang.java:599)
	at com.oracle.graal.pointsto.BigBang.finish(BigBang.java:557)
	at com.oracle.svm.hosted.NativeImageGenerator.runPointsToAnalysis(NativeImageGenerator.java:685)
	at com.oracle.svm.hosted.NativeImageGenerator.doRun(NativeImageGenerator.java:524)
	at com.oracle.svm.hosted.NativeImageGenerator.lambda$run$0(NativeImageGenerator.java:442)
	at java.util.concurrent.ForkJoinTask$AdaptedRunnableAction.exec(ForkJoinTask.java:1386)
	at java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:289)
	at java.util.concurrent.ForkJoinPool$WorkQueue.runTask(ForkJoinPool.java:1056)
	at java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1692)
	at java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:157)
Caused by: java.lang.ClassNotFoundException: org.springframework.dao.DataAccessException
	at java.net.URLClassLoader.findClass(URLClassLoader.java:382)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
	... 20 more
```

the compilation is done against the contents of the `unpack` folder. To create the `unpack` folder you need to run `compileAndCompare.sh`
