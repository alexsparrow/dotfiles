#!/bin/bash
# little dzen-thingy to control your volume
# you need amixer (or aumix) and gdbar
# (c) 2007 Tom Rauchenwald and Jochen Schweizer

source ~/.dot.conf
source $DOTPATH/dzen/config.sh

source $DOTPATH/shell/display_info.sh
DISP_WIDTH=$(display_width)
DISP_HEIGHT=$(display_height)

DATE_FORMAT='^p(5)^fg(#909090)^fg(green)%a, ^fg(white)%d^fg()/%m/%Y ^fg(#FFFF00)%H:%M^fg()'
W=$2         # width of the dzen bar
GW=50         #  width of the volume gauge
GFG='#a8a3f5' # color of the gauge
GH=7          # height of the gauge
GBG='#333'    # color of gauge background
X=$1          # x position
Y=0           # y position
H=17

# Caption of the gauge
# in this case it displays the volume icon shipped with dzen
CAPTION="^i(/home/alex/.alexdot/img/clock.xbm) "

# command to pipe into gdbar to display the gauge
# should print out 2 space-seperated values, the first is the current
# volume, the second the maximum volume
while true; do
    echo -n $CAPTION
#    eval "$CV" | gdbar -h $GH -w $GW -fg $GFG -bg $GBG
    echo `date "+$DATE_FORMAT"`
    sleep 1;
done | dzen2 -ta c -tw $W -y $Y -x $X -fg $FG -bg $BG -fn $FN -h 17
