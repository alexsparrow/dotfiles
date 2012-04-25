

function md5_dir {
    DIR=$1
    TEMPF=$(mktemp)
    find $DIR -type f -print0 | xargs -0 md5sum > $TEMPF
    echo $TEMPF
}

function md5_cmp_dir {
    DIR1=$(md5_dir $1)
    DIR2=$(md5_dir $2)
}
