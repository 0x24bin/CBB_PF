@echo off
::����kettle��Ŀ¼
set KETTLE_HOME=.\data-integration
cd %KETTLE_HOME%
::����jdk����
set JAVA_HOME=..\jdk
set PATH=%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem
set CLASSPATH=.;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar
::����job����
kitchen /file D:\CBB_PF\importDataFormExcelTool\job.kjb
