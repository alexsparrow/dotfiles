#!/bin/sh
#
#
#
# (c) 2007, by Jochen Schweizer
# (c) 2007 Christian Dietrich
# with help from Robert Manea

source ~/.dot.conf
source $DOTPATH/dzen/config.sh

source $DOTPATH/shell/display_info.sh
DISP_WIDTH=$(display_width)

GH=7
GW=30
GFG='#aecf96'
GBG='#37383a'

W=50
H=17
X=0
X=`expr $DISP_WIDTH - 300 - $W`
Y=0
WIDTH=500

FW="mpc volume +5"      # 5 sec forwards
RW="mpc volume -5"      # 5 sec backwards
NEXTS="mpc next"      # previous song
PREVS="mpc prev"      # next song
TOGGS="mpc toggle"    # play/pause
FILE=/dev/shm/musicmeter.$USER
ICONPATH=$DOTPATH/img

MAXPOS="100"

while :; do
  MPC="`mpc`"
  #POS=`echo "$MPC" | sed -ne 's/volume: \(.*\)%.*/\1/p'`
  POS=`mpc | sed -ne 's/^.*(\([0-9]*\)%).*$/\1/p'`
  POSM="$POS $MAXPOS"
  #TITLE=`mpc | head -n 1`
  TITLE="mpc"
  (
  echo  -n "^tw()^i(${ICONPATH}/music.xbm)"
  echo "$POSM" | gdbar -h $GH -w $GW -fg $GFG -bg $GBG -nonl
  echo " "
  echo "^cs()"
  echo "$MPC" | sed 's/\[/[^fg(green)/; s/\]/^fg()]/'

### Warning: due to problems with the wiki engine, you have to manually add a space after 'i  \', it has to be 'i  \ '
  echo $( (echo ""; mpc playlist) | grep -C 1 "^>" | sed  -ne "1 s/^[^)]*) /^fg(red)Previous:^fg() /p;
  i  \
  ;3 s/^[^)]*) /^fg(green)Next:^fg() /p;"  | tr -d "\n")
  ) > $FILE
  cat $FILE
  sleep 1
done |  dzen2 -x $X -y $Y -tw $W -h $H -w $WIDTH -ta l -sa c -fg $FG -bg $BG \
       -fn $FN -l 4  \
       -e "button4=exec:$RW;button5=exec:$FW;button1=exec:$NEXTS;
          ;button3=exec:$PREVS;button2=exec:$TOGGS;entertitle=uncollapse;leavetitle=collapse"
