#!/bin/sh
#
# by lyon8 (lyon8@gmx.net)
# show your laptop battery state in dzen

# 09/11/2011 Alex: had to change "line" to "head -1"
#		   added height parameter
#                  moved config options into separate file

source ~/.dot.conf
source $DOTPATH/dzen/config.sh

source $DOTPATH/shell/display_info.sh
DISP_WIDTH=$(display_width)
DISP_HEIGHT=$(display_height)

W=$2     # width of the dzen bar
GW=30      # width of the gauge
GFG='#999'  # color of the gauge
GH=7       # height of the gauge
GBG='#333'  # color of gauge background
X=$1
Y=0    # y position
H=17

STATEFILE='/proc/acpi/battery/BAT0/state' # battery's state file
INFOFILE='/sys/class/power_supply/BAT0/charge_now'   # battery's info file
INFOFILE2='/sys/class/power_supply/BAT0/charge_full'   # battery's info file

LOWBAT=25        # percentage of battery life marked as low
LOWCOL='#ff4747' # color when battery is low
TIME_INT=1         # time intervall in seconds

PREBAR='^i(/home/alex/.alexdot/img/battery.xbm)' # caption (also icons are possible)

while true; do
# look up battery's data
BAT_NOW=`cat $INFOFILE`;
BAT_FULL=`cat $INFOFILE2`;

BAT_NOW_PC=`expr $BAT_NOW \* 100`

# calculate remaining power
RPERC=$(expr $BAT_NOW_PC / $BAT_FULL)

# draw the bar and pipe everything into dzen
if [ $RPERC -le $LOWBAT ]; then GFG=$LOWCOL; fi
echo -n $PREBAR
eval echo $RPERC | gdbar -h $GH -w $GW -fg $GFG -bg $GBG
sleep $TIME_INT;
done | dzen2 -ta c -tw $W -y $Y -x $X -fg $FG -bg $BG -fn $FN -h $H
