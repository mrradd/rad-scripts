@echo off
setlocal enabledelayedexpansion

set "TEMPLATE_FILE=.\settings\settingsTemplate.txt"

set "OUTPUT_FILE=.\settings\mySettings.txt"

for /f "tokens=1 delims== eol=#" %%a in (%TEMPLATE_FILE%) do (
    echo %%a=!%%a! >> %OUTPUT_FILE%
)

echo Settings have been written to "%OUTPUT_FILE%". Now add values to them.

endlocal