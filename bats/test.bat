@echo off
setlocal EnableDelayedExpansion

echo ~This pulls a couple variables from 'mySettings.txt' and displays them.
set "SETTINGS_FILE=..\settings\mySettings.txt"

for /f "tokens=1,2 delims== eol=#" %%a in (%SETTINGS_FILE%) do (
    set "%%a=%%b"
)

echo ~scriptsDirectory: %scriptsDirectory%
echo ~PSQL_PATH: %PSQL_PATH%

pause