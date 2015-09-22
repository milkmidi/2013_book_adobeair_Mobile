echo off
set FLEX_SDK=D:\40_Flex\_SDK_\SDK

set COMPC=%FLEX_SDK%\bin\compc

set EXTENSION_SRC=./src/
set EXTENSION_CLASS_NAME=com.milkmidi.android.extensions.AndriodExtension
set EXTENSION_TMP_DIR=./tmp
set EXTENSION_OUTPUT=%EXTENSION_TMP_DIR%/nativeextensions.swc
echo on
mkdir "%EXTENSION_TMP_DIR%"
%COMPC% -source-path %EXTENSION_SRC% -include-classes %EXTENSION_CLASS_NAME% -swf-version 13 -external-library-path %FLEX_SDK%/frameworks/libs/air/airglobal.swc -output %EXTENSION_OUTPUT%
pause