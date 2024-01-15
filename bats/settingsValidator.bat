@echo off
setlocal enabledelayedexpansion

rem Define the settings file's path
set "settingsFile=..\settings\mySettings.txt"

rem Check if the file exists
if not exist "%settingsFile%" (
    echo The file "%settingsFile%" does not exist!
    exit /b
)

rem Retrieve the list of variable names from the first argument
set "variableList=%~1"

rem Initialize a flag to determine if any variables are missing or not defined
set missing=0

rem Loop through the provided list and check each variable in the settings file
for %%v in (%variableList%) do (
    set found=0
    for /f "eol=# tokens=1,* delims==" %%i in ('type "%settingsFile%"') do (
        if "%%i"=="%%v" (
            set found=1
            if "%%j"=="" (
                echo Setting '%%v' is defined but does not have a value.
                set missing=1
            )
        )
    )
    if "!found!"=="0" (
        echo Setting '%%v' is missing.
        set missing=1
    )
)

rem Conclude based on the flag
if %missing%==1 (
    exit /b 1
) else (
    echo Settings okay.
)
