:user_configuration

:: About AIR application packaging
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959
:: http://livedocs.adobe.com/flex/3/html/distributing_apps_4.html#1037515

:: NOTICE: all paths are relative to project root

:: Android packaging
set AND_CERT_NAME="milkmidiAIR"
set AND_CERT_PASS=1234
set AND_CERT_FILE=../../_Android_Certificate/milkmidiAIR.p12
set AND_ICONS=icons/android

set AND_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%AND_CERT_FILE%" -storepass %AND_CERT_PASS%

:: iOS packaging
set IOS_DIST_CERT_FILE=../../_iOS_fakeCertificate/mycert.p12
set IOS_DEV_CERT_FILE=../../_iOS_fakeCertificate/mycert.p12
set IOS_DEV_CERT_PASS=pass
set IOS_PROVISION=../../_iOS_fakeCertificate/Fake.mobileprovision
set IOS_ICONS=icons/ios

set IOS_DEV_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DEV_CERT_FILE%" -storepass %IOS_DEV_CERT_PASS% -provisioning-profile %IOS_PROVISION%
set IOS_DIST_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DIST_CERT_FILE%" -provisioning-profile %IOS_PROVISION%

:: 應用程式說明文件 Application descriptor
set APP_XML=application.xml

:: 要打包的資夾 Files to package
set APP_DIR=bin
set FILE_OR_DIR=-C %APP_DIR% .

:: 應用程式的唯一 id 值, 需要和 應用程式說明文件 裡的 id 表籤相同
set APP_ID=com.milkmidi.catchAsBitmapMatrixDemo

:: 打包後要輸出的資料夾路徑
set DIST_PATH=dist
set DIST_NAME=milkmidi_air

:: Debugging using a custom IP
set DEBUG_IP=



:validation
%SystemRoot%\System32\find /C "<id>%APP_ID%</id>" "%APP_XML%" > NUL
if errorlevel 1 goto badid
goto end

:badid
echo.
echo ERROR: 
echo   Application ID in 'bat\SetupApplication.bat' (APP_ID) 
echo   does NOT match Application descriptor '%APP_XML%' (id)
echo.

:end