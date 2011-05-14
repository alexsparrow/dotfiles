
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE="ibus"

xsetroot -cursor_name left_ptr
xscreensaver -nosplash &
setxkbmap -layout gb
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request  --height 15 --transparent true --tint 0x303030 &
./.alexdot/dzen.sh | dzen2 -ta l -h 17 -bg '#303030' -fg 'grey70' -x 900 -p -e '' -w 700 -fn '-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*' &
gnome-sound-applet &
dropboxd &
synapse &
ibus-daemon & 
xrdb -merge .Xresources
exec ck-launch-session xmonad
