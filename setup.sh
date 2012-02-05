#!/bin/sh

# Test if file is tracked by git
function is_in_git {
    git ls-files $1 --error-unmatch 2>&1
    return $?
}

# Last git rev where file $1 was changed
function git_last_rev {
    REV=$(git log -1 $1 | head -1)
    set -- $REV
    shift
    echo $@
}

# Extract _LAST_REVISION_ line from file $1
function file_last_rev {
    FILE=$1
    GREPO=$(grep "_LAST_REVISION_" $FILE)
    [ $? -eq 0 ] || { return 1; }
    REV=`echo $GREPO | head -1`
    set -- $REV
    shift; shift;
    echo $@
}

# Given previous git revision $1 and new revision $2
# Create a patch taking file $3 from revision $1 -> $2
# Apply to file $TARGET to get $TARGET.new
# Rewrite _LAST_REVISION_ line to $2
function git_patch {
    OLD_REV=$1
    NEW_REV=$2
    SOURCE=$3
    TARGET=$4
    TEMPF=$(mktemp)
    git diff -p $OLD_REV $NEW_REV -- $SOURCE > $TEMPF
    TEMPF2=$(mktemp)
    patch $TARGET -o $TEMPF2 < $TEMPF
    sed "/_LAST_REVISION_/ c\
         # _LAST_REVISION_ $NEW_REV" $TEMPF2 > $TARGET.new
    rm $TEMPF
    rm $TEMPF2
}

# Check if the global config file exists. If not link it.
if [ ! -e ~/.dot.conf ]
then
    echo "Creating .dot.conf"
    ln -s $PWD/.dot.conf ~/.dot.conf
else
    echo "Found .dot.conf"
fi

# Source global conf and move to home directory
source ~/.dot.conf
cd

# Look for list of files to copy
if [ ! -e $DOTPATH/config_files ]
then
    echo "Can't find configuration file: $DOTPATH/config_files. Exiting"
    exit 1
fi

# Copy files
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
    [ ! -e $SOURCE ] && { echo "-> WARNING: $SOURCE not found. Skipping"; echo; continue;}
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
    echo
done

# Copy template files
cd $DOTPATH
cat $DOTPATH/config_templates |
while read file
do
    set -- $(echo $file | awk 'BEGIN{FS="->";OFS=" "}{print $1,$2}')
    DEP=$1
    SOURCE=$1
    TARGET=$2
    eval DEP=$DEP
    eval SOURCE=$SOURCE
    eval TARGET=$DOTPATH/$TARGET
    echo "Template file: $DEP"

    X=`is_in_git $SOURCE`
    if [ $? -ne 0 ] || [ ! -e $SOURCE ]
    then
	echo "-> WARNING: Source file doesn't exist or is not in git. Skipping"
	echo
	continue
    fi
    if [ ! -e $TARGET ] && [ ! -h $TARGET ]
    then
	echo "-> Target doesn't exist"
	GIT_REV=$(git_last_rev $SOURCE)
	sed  "$ a\ \n# _LAST_REVISION_ $GIT_REV" $SOURCE > $TARGET
	echo "-> Created $TARGET @ $GIT_REV"
    else
	OLD_REV=$(file_last_rev $TARGET)
	if [ $? -ne 0 ]
	then
	    echo "Can't find revision of config file: $TARGET. Skipping."
	    echo
	    continue
	fi
	GIT_REV=$(git_last_rev $SOURCE)
	if [ ! "$OLD_REV" == "$GIT_REV" ]
	then
	    echo "-> Change detected: old = $OLD_REV, new = $GIT_REV"
	    OUT=$(git_patch $OLD_REV $GIT_REV $SOURCE $TARGET)
	    echo "-> Attempted patch: $TARGET.new"
	    echo "-> Check the patch is OK and replace"
	else
	    echo "File up to date: $SOURCE @ $GIT_REV"
	fi
    fi
    echo
done
