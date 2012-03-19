source ~/.dot.conf
source $DOTPATH/shell/display_info.sh

# Start a program in the background with log output
function dotc_start_log {
    CMD=$1
    NAME=$2
    $CMD > $DOTPATH/run/$NAME.log 2>&1 &
    echo $! > $DOTPATH/run/$NAME.pid
    echo "$CMD" > $DOTPATH/run/$NAME.cmd
}

# Start a program in the background without log output
function dotc_start_bkg {
    CMD=$1
    NAME=$2
    $CMD &
    echo $! > $DOTPATH/run/$NAME.pid
    echo "$CMD" > $DOTPATH/run/$NAME.cmd

}

# Stop all started programs
function dotc_stop_all {
    for i in $DOTPATH/run/*.pid
    do
	kill `cat $i` && rm $i
    done
}

# Try to start/restart app
function dotc_restart {
    NAME=$1
    CMD=$(cat $DOTPATH/run/$NAME.cmd)

    if [ -e $DOTPATH/run/$NAME.pid ]
    then
	PID=`cat $DOTPATH/run/$NAME.pid`
	echo "Killing $PID"
	kill $PID && rm $DOTPATH/run/$NAME.pid
    fi

    if [ -e $DOTPATH/run/$NAME.log ]
    then
	echo "Starting log output"
	dotc_start_log $CMD $NAME
    else
	echo "Starting no log output"
	dotc_start_bkg $CMD $NAME
    fi
}

function dotc_panels {
    X=$(display_width)
    cat $1|
    while read file
    do
        if [[ $file == \#* ]]
        then
            continue
        fi
        set -- $(echo $file | awk 'BEGIN{FS="[ \t]*";OFS=" "}{print $1, $2}')
        SCRIPT=$1
        WIDTH=$2
        X=`expr $X - $WIDTH`
#        echo $SCRIPT $X
        dotc_start_bkg "$DOTPATH/dzen/$SCRIPT.sh $X $WIDTH"
    done
}
