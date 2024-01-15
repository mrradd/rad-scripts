@echo off

rem Parameters
set newBranchName=%1
set repoPath=%2

echo.
echo ~Navigating to '%repoPath%'
cd %repoPath%

echo ~Switching to master just in case.
call git checkout master

echo ~Creating new local branch '%newBranchName%' based off local master.
call git branch %newBranchName%

echo ~Checking out new local branch '%newBranchName%'.
call git checkout %newBranchName%

echo ~Pushing '%newBranchName%' to remote.
call git push -u -v --progress origin %newBranchName%

echo ~Current branch:
call git rev-parse --abbrev-ref HEAD

echo ~Finished '%~n0%~x0'.

echo.
