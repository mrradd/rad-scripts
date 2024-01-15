@echo off
setlocal enabledelayedexpansion

rem Paths
set "SETTINGS_PATH=settings\mySettings.txt"
set "UPDATEDSETTINGS_PATH=settings\settingsTemplate.txt"
set "TEMP_PATH=temp.txt"
set "NEWSETTINGS_PATH=newSettings.txt"

rem Varify there is a mySettings.txt file.
if not exist "%SETTINGS_PATH%" (
    echo The file '%SETTINGS_PATH%' does not exist. Run initial_setup.bat first.
    exit 1
)

rem Clear any existing temporary data
if exist %TEMP_PATH% del %TEMP_PATH%
if exist %NEWSETTINGS_PATH% del %NEWSETTINGS_PATH%

rem Extract only variable names from %SETTINGS_PATH% to a temporary file
for /f "eol=# tokens=1 delims==" %%a in (%SETTINGS_PATH%) do (
    echo %%a >> %TEMP_PATH%
)

rem Compare variable names from %UPDATEDSETTINGS_PATH% with %TEMP_PATH%
for /f "tokens=1 delims== eol=#" %%a in (%UPDATEDSETTINGS_PATH%) do (
    findstr /b /c:"%%a" %TEMP_PATH% >nul
    if errorlevel 1 (
        echo %%a is missing
        echo %%a=!%%a! >> %NEWSETTINGS_PATH%
    )
)

echo ADD THE NEW SETTINGS TO YOUR mySettings.txt FILE, AND SET THEIR VALUES.

rem Cleanup
del %TEMP_PATH%

endlocal