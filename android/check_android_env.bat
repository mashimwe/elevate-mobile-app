@echo off
set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
set "ANDROID_SDK_ROOT=C:\Users\USER\AppData\Local\Android\sdk"
set "ANDROID_HOME=%ANDROID_SDK_ROOT%"
echo JAVA_HOME=%JAVA_HOME%
echo ANDROID_SDK_ROOT=%ANDROID_SDK_ROOT%
echo ANDROID_HOME=%ANDROID_HOME%
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\sdkmanager.bat" --version
"%ANDROID_SDK_ROOT%\cmdline-tools\latest\bin\avdmanager.bat" list avd
