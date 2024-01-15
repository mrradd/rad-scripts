# Rad Scripts
A series of scripts I made to make things slightly easier. Sure each task could be done in less than a minute with some clicking around, typing a bit,
etm, but now you can use that minute for other things--you're welcome.

> :warning:
> (ノಠ益ಠ)ノ彡┻━┻
> This is very much a, "just to see if I can," kind of project that ended up being kind of useful. These scripts are not __safe__ in the sense that
> there is little to no error checking for missing variables, files, or directories. Error checking will be added in the future--maybe. Everything
> works for me if that makes you feel better, but if something breaks... oops?

## Getting started
Using Command Line, run the `initialSetup.bat` script. This will create a file called `mySettings.txt` in the `~\rad-scripts\settings` directory
which will define the variables which are used by the scripts. The value of these variables must be changed to reflect your local dev environment
in order for the scripts to work properly.

> The `mySettings.txt` file follows the same conventions for variable definition `varName=value` similar to any other `.bat` script. There cannot be
> empty space on either side of the `=` sign.
```
PSQL_PATH=C:\path\to\psql.exe
PG_RESTORE_PATH=C:\path\to\pg_restore.exe
PG_DB_HOST=db_host_name
PG_DB_PORT=port_for_db
PG_DB_USERNAME=db_username
PG_DB_PASSWORD=db_password
root_db_backup_dir=D:\path\to\root\db\backup\dir
```
### Example customized mySettings.txt file
> :warning:
> (ノಠ益ಠ)ノ彡┻━┻
> Although it is ignored, this file should never be committed.
```
PSQL_PATH="C:\Program Files\pgAdmin 4\v6\runtime\psql.exe"
PG_RESTORE_PATH="C:\Program Files\pgAdmin 4\v6\runtime\pg_restore.exe"
PG_DB_HOST=localhost
PG_DB_PORT=9001
PG_DB_USERNAME=coolUserName
PG_DB_PASSWORD=sup3r53cur3P455w0rd
root_db_backup_dir=D:\workspace\dbBackups
```
## Running a script
Open Command Line in this project's `~\rad-scripts\bats` directory, and call one of the scripts the same way you would any other `.bat` file.

# Script Documentation

> :warning:
> (ノಠ益ಠ)ノ彡┻━┻
> Before running any script that modifies a repository (generally anything named `git*.bat`, or that __executes__ similarly named `bats`), make sure
> you do not have uncommited changes first as these are untested for times where there is a merge conflict when updating.

## git_new_branch_off_master_for_repo.bat [newBranchName] [repoPath]
Using `git` this checks out the `local master`, tries to create a new branch with the specified name for the repo at the specified path, and pushes
the new branch to the remote repo with tracking.

- __Parameters__
  - `newBranchName`: The name of the new branch to be created.
  - `repoPath`: Path to the repository to create a new branch for.
- __Usage__
  - `git_new_branch_off_master_for_repo.bat cool_branch_name D:\repos\coolRepo`

## git_update_and_make_new_branch_for_repo.bat [newBranchName] [repoPath]
Updates the `local master` branch of the repo at the specified path, creates a new branch for that repo with the specified name, and pushes the new
branch to the remote repo.

- __Parameters__
  - `newBranchName`: The name of the new branch to be created.
  - `repoPath`: Path to the repository to create a new branch for.
- __Executes__
  - `git_update_master_for_repo.bat`
  - `git_new_branch_off_master_for_repo.bat`
- __Usage__
  - `git_update_and_make_new_branch_for_repo.bat cool_branch_name D:\repos\coolRepo`

## git_update_master_for_repo.bat [repoPath]
Using `git` this checks out `local master`, and pulls updates from the `remote master`.

- __Parameters__
  - `repoPath`: Path to the repository to update `local master` for.
- __Usage__
  - `git_update_and_make_new_branch_for_repo.bat D:\repos\coolRepo`

## pg_remake_and_restore_db.bat [dbRestoreFileName] [dbRestoreScriptDirName]
> :warning:
> (ノಠ益ಠ)ノ彡┻━┻ DO NOT RUN THIS IN PRODUCTION! IT IS FOR LOCAL DEVELOPMENT ONLY.

Parses the name of the database from the provided restore file's name and sets a local variable called `dbName`, then uses `PGAdmin CLI` tools to
kill all connections to the database matching `dbName`, deletes the database matching `dbName`, creates a new database called `dbName`, and
restores it using the provided restore file. The restore file must be located in the specified directory whose root path is the `root_db_backup_dir`
path defined in `mySettings.txt`.
> In case you're interested: the passed in `dbRestoreScriptDirName`'s (in this example, `20230828`) full directory path to `dbRestoreFileName` would
> be calculated by combining `root_db_backup_dir`, from `mySettings.txt` with local variable `dbName` and the parameter `dbRestoreFileName` like so
> `%root_db_backup_dir%\%dbName%\%dbRestoreFileName%`. Based on the Usage example below the calculation would result in
> `D:\workspace\dbBackups\20230828\superCoolDbName.sql`.
- __Parameters__
  - `dbRestoreFileName`: The name of the restore script including its file extension (e.g. `.sql`). The file name must be the same as the database
    you wish to restore.
  - `dbRestoreScriptDirName`: The directory the restore file is located in whose root is the `root_db_backup_dir` path defined in `mySettings.txt`.
- __Usage__
  - `pg_remake_and_restore_db.bat superCoolDbName.sql 20230828`