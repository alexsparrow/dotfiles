
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
./.alexdot/dzen.sh | dzen2 -ta l -h 17 -bg $BGCOL -fg $FGCOL -x $XMAILDATE -p -e '' -w 600 -fn $FONT &
./.alexdot/volume.sh | dzen2 -ta l -h 17 -bg $BGCOL -fg $FGCOL -x $XVOLUME -p -e 'button3=exit;button4=exec:$CI;button5=exec:$CD' -w 50 -fn $FONT &
#./.alexdot/hostsup.sh | dzen2 -ta 1 -h 17 -bg $BGCOL -fg $FGCOL -x 0 -p -e '' -w 800 -xs 2 -fn $FONT &
gnome-sound-applet &
dropboxd &
synapse &
ibus-daemon -x &
xrdb -merge .Xresources
hsetroot -fill Dropbox/Wallpapers/airship.jpg
xcompmgr -n &
devmon &
exec ck-launch-session xmonad
