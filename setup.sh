#!/bin/sh

if [ ! -e ~/.dot.conf ]
then
    echo "Creating .dot.conf"
    ln -s $PWD/.dot.conf ~/.dot.conf
else
    echo "Found .dot.conf"
fi

source ~/.dot.conf
cd

if [ ! -e $DOTPATH/config_files ]
then
    echo "Can't find configuration file: $DOTPATH/config_files. Exiting"
    exit 1
fi

cat $DOTPATH/config_files |
while read file
do
    set -- $(echo $file | awk 'BEGIN{FS="->";OFS=" "}{print $1,$2}')
    DEP=$1
    SOURCE=$DOTPATH/$1
    TARGET=$2
    eval DEP=$DEP
    eval SOURCE=$SOURCE
    eval TARGET=$TARGET

    echo "Configuration file: $DEP"
    [ ! -e $SOURCE ] && { echo "-> WARNING: $SOURCE not found. Skipping"; continue;}
    if [ ! -e $TARGET ]
    then
	echo "-> Target file not found: $TARGET"
	if [ -h $TARGET ]
	then
	    echo "-> WARNING: Appears to be a dead symlink: $TARGET -> $(realpath $TARGET)"
	    echo "-> Skipping"
	else
	    echo "-> Linking: $TARGET -> $SOURCE"
	    ln -s $SOURCE $TARGET
	fi
    else
	if [ -h $TARGET ]
	then
	    echo -n "-> Exists: $TARGET -> $(realpath $TARGET)"
	    if [ ! `realpath $TARGET` = `realpath $SOURCE` ]
	    then
		echo "\n-> WARNING: The installed file does not appear to point to the target"
	    else
		echo " [OK]"
	    fi
	else
	    echo "-> WARNING: Target is not a symlink"
	fi
    fi
done
