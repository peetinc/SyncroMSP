# RepackageSyncroDesktop
Fast and ugly repackaging script to help repackage SyncroDesktop.pkg to not force allowing Screen Recording TCC.

## Usage:
Put `RepackageSyncroDesktop.sh`in its own directory and `chmod 755 ./RepackageSyncroDesktop.sh`
Either ...
Place your `SyncroDesktop-CODE.pkg` in the same directory as `RepackageSyncroDesktop.sh`
ONLY ONE copy of `SyncroDesktop-CODE.pkg` can be in the directory with `RepackageSyncroDesktop.sh`
or ... 
pass your `SyncroDesktop-CODE.pkg` to `SyncroDesktop-CODE.pkg` as an argument
`./SyncroDesktop-CODE.pkg /path/to/SyncroDesktop-CODE.pkg`

## Process:
The script does some decent checks to make sure the .pkg is actually `SyncroDesktop-CODE.pkg`
Downloads a copy of [munkipkg](https://github.com/munki/munki-pkg)
Imports your `SyncroDesktop-CODE.pkg` to a `munkipkg` project
Opens the `postinstall` script in `TextEdit.app`
You must edit the `postinstall` to your liking, save AND quit `TextEdit.app`
* Comment out or remove the "#waiting while device will be registered" section allow for unattendend install

Ejoy the warnings about testing and retesting
The output will be in the build directory of your munkipkg project.
`RepackageSyncroDesktop.sh` will open the directory in the finder when finished.

