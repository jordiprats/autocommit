# autocommit

shell script to automatically commit changes

## Requirements

* inotify-tools

## Usage

```
autocommit.sh -r <repo dir> [-m <auto commit message>] [-e <author's email>] [-n <author's name>] [-p] [-d]
```

Options:
* **-r**: git repo directory
* **-m**: Commit message (default: automated commit)
* **-e**: Author's email (default: autocommit@systemadmin.es)
* **-n**: Author's name (default: Dr. Auto Commit)
* **-p**: push changes to origin
* **-d**: enable debug

## Example

```
$ bash autocommit.sh -r /home/jprats/git/autocommit -p -d &
[1] 19331
$ Setting up watches.  Beware: since -r was given, this may take a while!
Watches established.

$ touch a
/home/jprats/git/autocommit/ CREATE a
$ [master d955784] automated commit
 1 file changed, 1 insertion(+), 1 deletion(-)
X11 forwarding request failed on channel 0
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 293 bytes | 0 bytes/s, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To git@github.com:jordiprats/autocommit.git
   0c322b5..d955784  master -> master
Setting up watches.  Beware: since -r was given, this may take a while!
Watches established.

$ rm a
/home/jprats/git/autocommit/ DELETE a
$ [master 1f741e5] automated commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 a
X11 forwarding request failed on channel 0
Counting objects: 2, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 230 bytes | 0 bytes/s, done.
Total 2 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
   d955784..1f741e5  master -> master
Setting up watches.  Beware: since -r was given, this may take a while!
Watches established.

$

```
