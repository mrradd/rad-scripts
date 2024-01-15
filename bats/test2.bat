@echo off
setlocal EnableDelayedExpansion

echo ~This grabs the name and extension from a file.

rem There can be spaces in the file name.
set fileName=herp derp.txt

for %%A in ("%fileName%") do (
	set "name=%%~nA"
)

for %%f in ("%fileName%") do (
	set "extension=%%~xf"
)

echo File name is: %name%
echo File extension is: %extension%


pause