#!/bin/bash
# little dzen-thingy to control your volume
# you need amixer (or aumix) and gdbar
# (c) 2007 Tom Rauchenwald and Jochen Schweizer
source ~/.dot.conf
source $DOTPATH/dzen/config.sh

source $DOTPATH/shell/display_info.sh
DISP_WIDTH=$(display_width)

W=50         # width of the dzen bar
GW=30         #  width of the volume gauge
GFG='#a8a3f5' # color of the gauge
GH=7          # height of the gauge
GBG='#333'    # color of gauge background
X=`expr $DISP_WIDTH - 200 - 50 - $W`        # x position
Y=0         # y position
H=17

# Caption of the gauge
# in this case it displays the volume icon shipped with dzen
CAPTION="^i(/home/alex/.alexdot/img/volume.xbm) "

# command to increase the volume
CI="amixer -c0 sset PCM 5dB+ >/dev/null"
#CI="aumix -v +5"
# command to decrease the volume
CD="amixer -c0 sset PCM 5dB- >/dev/null"
#CD="aumix -v -5

# command to pipe into gdbar to display the gauge
# should print out 2 space-seperated values, the first is the current
# volume, the second the maximum volume
#MAX=`amixer -c0 get PCM | awk '/^  Limits/ { print $5 }'`
MAX=100
#CV="amixer -c0 get Master | awk '/^  Front Left/ { print \$4 \" \" $MAX }'"
CV="amixer -c0 get Master | awk '/^  Mono/ {print \$4 \" \" $MAX}' | tr -d '[]%'"
ON="amixer -c0 get Master | awk '/^  Mono/ {print \$6 }' | tr -d '[]%'"
#CV="aumix -q | line | cut -d \" \" -f 3"

while true; do
    echo -n $CAPTION
    MUTE=`eval "$ON"`
    GFGmute=$GFG
    if [ $MUTE == "off" ] ;
    then GFGmute="#ff4747"
    fi
    eval "$CV" | gdbar -h $GH -w $GW -fg $GFGmute -bg $GBG
    sleep 1;
done | dzen2 -ta c -tw $W -y $Y -x $X -fg $FG -bg $BG -e "button3=exit;button4=exec:$CI;button5=exec:$CD" -fn $FN -h 17
