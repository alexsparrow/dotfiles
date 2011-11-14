#!/bin/sh
#
# by lyon8 (lyon8@gmx.net)
# show your laptop battery state in dzen

# 09/11/2011 Alex: had to change "line" to "head -1"
		   added height parameter

BG='#303030'     # dzen backgrounad
FG='grey70'     # dzen foreground
W=80     # width of the dzen bar
GW=30      # width of the gauge
GFG='#999'  # color of the gauge
GH=7       # height of the gauge
GBG='#333'  # color of gauge background
X=1180       # x position
Y=0    # y position
H=17

FN='-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*'

STATEFILE='/proc/acpi/battery/BAT0/state' # battery's state file
INFOFILE='/proc/acpi/battery/BAT0/info'   # battery's info file

LOWBAT=25        # percentage of battery life marked as low
LOWCOL='#ff4747' # color when battery is low
TIME_INT=1         # time intervall in seconds

PREBAR='^i(/home/alex/.alexdot/img/battery.xbm)' # caption (also icons are possible)

while true; do
# look up battery's data
BAT_FULL=`cat $INFOFILE|grep design|head -1|cut -d " " -f 11`;
STATUS=`cat $STATEFILE|grep charging|cut -d " " -f 12`;
RCAP=`cat $STATEFILE|grep remaining|cut -d " " -f 8`;

# calculate remaining power
RPERCT=`expr $RCAP \* 100`;
RPERC=`expr $RPERCT / $BAT_FULL`;

# draw the bar and pipe everything into dzen
if [ $RPERC -le $LOWBAT ]; then GFG=$LOWCOL; fi
echo -n $PREBAR
eval echo $RPERC | gdbar -h $GH -w $GW -fg $GFG -bg $GBG
sleep $TIME_INT;
done | dzen2 -ta c -tw $W -y $Y -x $X -fg $FG -bg $BG -fn $FN -h $H
