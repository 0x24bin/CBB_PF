@echo off
::设置kettle根目录
set KETTLE_HOME=.\data-integration
cd %KETTLE_HOME%
::设置jdk环境
set JAVA_HOME=..\jdk
set PATH=%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem
set CLASSPATH=.;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar
::调用job任务
kitchen /file D:\CBB_PF\importDataFormExcelTool\job.kjb
