@echo off

setlocal

rem Parameters
set repoPath=%1

echo.

echo ~Starting '%~n0%~x0'.

echo ~Navigating to '%repoPath%'.
cd %repoPath%

echo ~Switching to local master.
call git checkout master

echo ~Fetching changes for origin.
call git fetch origin

echo ~Merging changes from origin/master.
call git merge origin/master

echo ~Current branch:
call git rev-parse --abbrev-ref HEAD

echo ~Finished '%~n0%~x0'.

echo.


