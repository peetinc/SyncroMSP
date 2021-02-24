#!/bin/bash

#### Quick Repackaging to disable forced Screen Recording permissions
#### Provided as-is with no warranty

SCRIPT_DIR="$(dirname "$0")"
cd $SCRIPT_DIR

PKG=$1
if [ -z $PKG ];then
	SCRIPT_DIR_PKG=$(ls SyncroDesktop-*.pkg)
	PKGLenth=$(echo ${#SCRIPT_DIR_PKG})
	if [ $PKGLenth -ne 74 ];then
	echo "Error: You have a SyncroDesktop Package in the script directory, but it's name is not 74 characters"
	echo "Please consider rm $PKG"
	else
	echo "./$SCRIPT_DIR_PKG appears to be a vaild SyncroDesktop package ... Proceeding."
	PKG=./$SCRIPT_DIR_PKG
	fi
fi

if [ -z $PKG ];then
	echo "Error: No SyncroDesktop Package Provided."
	echo "Please provide path to SyncroDesktop-ENROLLMENTCODE.pkg"
	echo "i.e. RepackageSyncro.sh /Path/to/SyncroDesktop-ENROLLMENTCODE.pkg"
	exit 1
fi


if !( pkgutil --check-signature $PKG | grep "HXTBKHMS52" >> /dev/null 2>&1 );then
	echo "The provided pkg/file is not signed by Developer ID Installer: Shulik Sergey (HXTBKHMS52)"
	exit 1
	else
	echo "The provided pkg/file is signed by Developer ID Installer: Shulik Sergey (HXTBKHMS52)"
fi

CODE=$(echo $PKG | sed -e 's/.*-\(.*\)\..*/\1/')
MUNKIPKG_DIR="./SyncroDesktop-$CODE"

if [ ! -f ./munkipkg ]; then 
	curl "https://raw.githubusercontent.com/munki/munki-pkg/main/munkipkg" -O
	chmod 755 ./munkipkg
fi

if [ -d $MUNKIPKG_DIR ]; then
	echo "munkipkg has already imported $MUNKIPKG_DIR."
	echo "Please delete $MUNKIPKG_DIR if you are building a fesh silent installer."
	else
	./munkipkg --import $PKG $MUNKIPKG_DIR
fi

echo "*** Opening $MUNKIPKG_DIR/scripts/postinstall script in TextEdit ****"
echo "*** You must edit the post install script as you'd like. Save AND quit TextEdit to continue. ****"
echo "*** To allow silent install, comment out or remove the following section ***"
echo "*** #waiting while device will be registered ***"

open -W -a TextEdit "$MUNKIPKG_DIR/scripts/postinstall"

./munkipkg	$MUNKIPKG_DIR
echo ""
echo ""
echo "Your new PKG should be in $MUNKIPKG_DIR/build."
sleep 2
echo ""
echo "Please test and retest before deploying."
sleep 2
echo ""
echo "Really, I'm not kidding."
echo ""
echo ""
sleep 5
echo "Here's your pkg ..."
sleep 2

open $MUNKIPKG_DIR/build

