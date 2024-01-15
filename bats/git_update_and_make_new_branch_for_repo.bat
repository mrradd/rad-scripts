@echo off
setlocal EnableDelayedExpansion

rem Parameters
set newBranchName=%1
set repoPath=%2

rem -----Setup start-----
set "GENERAL_SETTINGS_FILE_PATH=..\settings\generalSettings.txt"
set "MY_SETTINGS_FILE_PATH=..\settings\mySettings.txt"

rem Should be the /bats dir.
set currentDir=%~dp0

for /f "tokens=1,2 delims== eol=#" %%a in (%GENERAL_SETTINGS_FILE_PATH%) do (
    set "%%a=%%b"
)

for /f "tokens=1,2 delims== eol=#" %%a in (%MY_SETTINGS_FILE_PATH%) do (
    set "%%a=%%b"
)
rem -----Setup end-----

set updateMasterBat=%currentDir%%git_update_master_for_repo%
set newBranchBat=%currentDir%%git_new_branch_off_master_for_repo%

echo.
echo ~Starting '%~n0%~x0'.

echo ~Executing '%updateMasterBat%'
call %updateMasterBat% %repoPath%

echo ~Executing '%newBranchBat%'
call %newBranchBat% %newBranchName% %repoPath%

echo ~Finished '%~n0%~x0'.

echo.