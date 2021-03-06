@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat
:target
set INTERPRETER=-interpreter

::goto desktop
::goto android-debug
::goto android-test

::goto ios-debug
goto ios-test

:desktop
set SCREEN_SIZE=NexusOne
echo.
echo. What kind of size do you wish to create?
echo.
echo.  [0] ***  Deploy Android  Device ***
echo.  [1] Nexus One (480x800)
echo.  [2] iPhone3 (320x480)
echo.  [3] iPhone4 (640x960)
echo.  [4] iPad1, iPad2 (768x1024)
echo.  [5] new iPad (1536x2048)
echo.  [6] Samsung GalaxyTab7 (600x1024)
echo.  [7] Asus Eee Pad Transformers (800x1280)
echo.  [9] ***  ios-test  ***
echo.
:choice
set /P C=[Option]:
if "%C%"=="0" goto android-test 
if "%C%"=="1" set SCREEN_SIZE=NexusOne
if "%C%"=="2" set SCREEN_SIZE=iPhone
if "%C%"=="3" set SCREEN_SIZE=iPhoneRetina
if "%C%"=="4" set SCREEN_SIZE=iPad
if "%C%"=="5" set SCREEN_SIZE=1536x2048:2048x1536
if "%C%"=="6" set SCREEN_SIZE=SamsungGalaxyTab
if "%C%"=="7" set SCREEN_SIZE=1280x800:800x1280
if "%C%"=="9" goto ios-test
echo. You have chosen '%SCREEN_SIZE%'.
echo. 

:desktop-run
echo.
echo Starting AIR Debug Launcher with screen size '%SCREEN_SIZE%'
echo.
echo (hint: edit 'Run.bat' to test on device or change screen size)
echo.
adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%"
if errorlevel 1 goto end
goto end


:ios-debug
echo.
echo Packaging application for debugging on iOS %INTERPRETER%
if "%INTERPRETER%" == "" echo (this will take a while)
echo.
set TARGET=-debug%INTERPRETER%
set OPTIONS=-connect %DEBUG_IP%
goto ios-package

:ios-test
echo.
echo Packaging application for testing on iOS %INTERPRETER%
if "%INTERPRETER%" == "" echo (this will take a while)
echo.
set TARGET=-test%INTERPRETER%
set OPTIONS=
goto ios-package

:ios-package
set PLATFORM=ios
set APP_XML=application_ios.xml
call bat\Packager.bat

if "%AUTO_INSTALL_IOS%" == "yes" goto ios-install
echo Now manually install and start application on device
echo.
goto end

:ios-install
echo Installing application for testing on iOS (%DEBUG_IP%)
echo.
call adt -installApp -platform ios -package "%OUTPUT%"
if errorlevel 1 goto installfail

echo Now manually start application on device
echo.
goto end

:android-debug
echo.
echo Packaging and installing application for debugging on Android (%DEBUG_IP%)
echo.
set TARGET=-debug
set OPTIONS=-connect %DEBUG_IP%
goto android-package

:android-test
echo.
echo Packaging and Installing application for testing on Android (%DEBUG_IP%)
echo.
set APP_XML=application_android.xml
set TARGET=
set OPTIONS=
goto android-package

:android-package
set PLATFORM=android
call bat\Packager.bat

adb devices
echo.
echo Installing %OUTPUT% on the device...
echo.
adb -d install -r "%OUTPUT%"
if errorlevel 1 goto installfail

echo.
echo Starting application on the device for debugging...
echo.
adb shell am start -n air.%APP_ID%/.AppEntry
exit

:installfail
echo.
echo Installing the app on the device failed

:end
::pause
