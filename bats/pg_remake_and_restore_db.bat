@echo off
rem Run this script to restore LOCAL dbs ONLY in PostgreSQL. NEVER RUN THIS IN PRODUCTION.
rem >Change the PSQL_PATH and the PG_RESTORE_PATH to the locations on your machine.
rem >This script has the signature of pg_remake_and_restore_db.bat [name_of_db] [path_to_restore_file] where path_to_restore_file includes the file name.
rem >> For example: pg_remake_and_restore_db.bat usermanagement.sql 20230828
rem >> The name of the script must be the same name of the database to be restored.
rem >>> Include the file's extension in the name as well. e.g. usermanagement.sql.

setlocal enabledelayedexpansion

rem Parameters
set dbRestoreFileName=%1
set dbRestoreScriptDirName=%2

rem -----Validation start-----
set badSettings=0
set badParameters=0

call settingsValidator.bat "PSQL_PATH, PG_RESTORE_PATH, PG_DB_HOST, PG_DB_PORT, PG_DB_USERNAME, PG_DB_PASSWORD"
set badSettings=%errorlevel%

call parameterValidator.bat "dbRestoreFileName, dbRestoreScriptDirName"
set badParameters=%errorlevel%

echo.

if %badSettings% NEQ 0 (
    echo ~Make sure the settings are properly defined.
)

if %badParameters% NEQ 0 (
    echo ~Make sure the parameters are properly defined.
)

echo.

if %badSettings% NEQ 0 (
    echo ~Bad settings. SKIPPING.
    exit /b 1
)

if %badParameters% NEQ 0 (
    echo ~Bad parameters. SKIPPING.
    exit /b 1
)
rem -----Validation end-----

rem -----Setup start-----
set "mySettingsFilePath=..\settings\mySettings.txt"

for /f "tokens=1,2 delims== eol=#" %%a in (%mySettingsFilePath%) do (
    set "%%a=%%b"
)

rem Get the file name.
for %%A in ("%dbRestoreFileName%") do (
	set "dbName=%%~nA"
)

rem Get the file extension. e.g. '.sql'.
for %%f in ("%dbRestoreFileName%") do (
	set "extension=%%~xf"
)

if exist %dbRestoreFileName% (
    echo ~"%dbRestoreFileName%" found.
) else (
    echo ~"%dbRestoreFileName%" not found--SKIPPING.
    exit /b 2
)
rem -----Setup end-----

echo ***NEVER RUN THIS IN PRODUCTION.***

rem Set password for psql.
set PGPASSWORD=%PG_DB_PASSWORD%

echo ~Killing all connections to %dbName%...
%PSQL_PATH% -h %PG_DB_HOST% -p %PG_DB_PORT% -U %PG_DB_USERNAME% -d postgres -c "DO $$ DECLARE current_pid INTEGER; BEGIN FOR current_pid IN (SELECT pid FROM pg_stat_activity WHERE datname = '%dbName%' AND pid <> pg_backend_pid()) LOOP EXECUTE 'SELECT pg_terminate_backend(' || current_pid || ')'; END LOOP; END $$;"

echo ~Dropping '%dbName%' if it exists...
%PSQL_PATH% -h %PG_DB_HOST% -p %PG_DB_PORT% -U %PG_DB_USERNAME% -d postgres -c "DROP DATABASE IF EXISTS %dbName%;"

echo ~Recreating '%dbName%'...
%PSQL_PATH% -h %PG_DB_HOST% -p %PG_DB_PORT% -U %PG_DB_USERNAME% -d postgres -c "CREATE DATABASE %dbName%;"

echo ~Restoring '%dbName%'
%PG_RESTORE_PATH% -h %PG_DB_HOST% -p %PG_DB_PORT% -U %PG_DB_USERNAME% -d %dbName% -v %root_db_backup_dir%\%dbRestoreScriptDirName%\%dbRestoreFileName%

rem Clean up the password environment recommended for security.
set PGPASSWORD=

echo ~Database %dbName% created.

echo ***NEVER RUN THIS IN PRODUCTION.***

endlocal