
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE=ibus

BGCOL='#303030'
FGCOL='grey70'
FONT='-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*'
XMAILDATE=900
XVOLUME=1200
#xrandr --output DVI-0 --auto --output VGA-0 --auto --left-of DVI-0
xsetroot -cursor_name left_ptr
xset -b
xscreensaver -nosplash &
setxkbmap -layout gb
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request  --height 15 --transparent true --tint 0x303030 &
./.alexdot/dzen/clock.sh &
echo $! > ./.alexdot/dzen/clock.pid
./.alexdot/dzen/volume.sh &
echo $! > ./.alexdot/dzen/volume.pid
./.alexdot/dzen/battery.sh &
echo $! > ./.alexdot/dzen/battery.pid
#./.alexdot/hostsup.sh | dzen2 -ta 1 -h 17 -bg $BGCOL -fg $FGCOL -x 0 -p -e '' -w 800 -xs 2 -fn $FONT &
gnome-sound-applet &
dropboxd &
offlineimap &
#synapse &
urxvtd &
ibus-daemon -x &
xrdb -merge .Xresources
hsetroot -fill ~/Documents/RAEVONA___Docking_Towers_by_ANTIFAN_REAL.jpg
xcompmgr -n &
devmon &
exec ck-launch-session xmonad

killall -9 trayer
killall -9 dzen2
killall ibus-daemon
killall dropboxd
killall offlineimap
killall devmon
killall xcompmgr
