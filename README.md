# autocommit

shell script to automatically commit changes

## Requirements

* inotify-tools

## Usage

```
autocommit.sh -r <repo dir> [-m <auto commit message>] [-e <author's email>] [-n <author's name>] [-p <remote>]
```

Options:
* -r: git repo directory
* -m: Commit message (default: automated commit)
* -e: Author's email (default: autocommit@systemadmin.es)
* -n: Author's name (default: Dr. Auto Commit)
* -p: push changes to remote (default: master)
