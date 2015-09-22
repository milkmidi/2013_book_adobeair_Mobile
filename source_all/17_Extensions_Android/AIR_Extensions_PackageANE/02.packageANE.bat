echo off
set FLEX_SDK=D:\40_Flex\_SDK_\SDK
set ADT=%FLEX_SDK%\bin\adt
set EXTENSION_SRC=./src
set EXTENSION_TMP_DIR=./tmp
set EXTENSION_OUTPUT=%EXTENSION_TMP_DIR%/nativeextensions.swc
set NATIVE_EXTENSION_NAME=./bin/AIR3Extension.ane
set EXTENSION_XML=%EXTENSION_SRC%/extension.xml
set SIGNING_OPTIONS=-storetype pkcs12 -storepass 1234 -keystore "../../_Android_Certificate/milkmidiAIR.p12" -tsa none


echo on
"%ADT%" -package %SIGNING_OPTIONS% -target ane %NATIVE_EXTENSION_NAME% %EXTENSION_XML% -swc "%EXTENSION_OUTPUT%" -platform Android-ARM -C "%EXTENSION_TMP_DIR%/Android-ARM" .
::..\..\SDK\bin\adt.bat -package -storetype pkcs12 -keystore letsplay.p12 -storepass 158246 -target ane com.coolexp.ANELib.ane extension.xml -swc CoolExpANELib.swc -platform iPhone-ARM -C iPhone-ARM .
pause