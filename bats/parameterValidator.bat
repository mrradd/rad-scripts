@echo off
setlocal enabledelayedexpansion

rem Retrieve the list of variable names from the first argument
set "variableList=%~1"

rem Initialize a flag to determine if any variables are missing or not defined
set missing=0

rem Loop through the provided list and check each variable in the settings file
for %%v in (%variableList%) do (
    if not defined %%v (
        echo Parameter '%%v' is not set.
        set missing=1
    )
)

rem Conclude based on the flag
if %missing%==1 (
    exit /b 1
) else (
    echo Paramters okay.
)
