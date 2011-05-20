
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE="ibus"

xrandr --output DVI-0 --auto --output VGA-0 --auto --left-of DVI-0
xsetroot -cursor_name left_ptr
xscreensaver -nosplash &
setxkbmap -layout gb
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request  --height 15 --transparent true --tint 0x303030 &
./.alexdot/dzen.sh | dzen2 -ta l -h 17 -bg '#303030' -fg 'grey70' -x 800 -p -e '' -w 600 -fn '-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*' &
gnome-sound-applet &
dropboxd &
synapse &
ibus-daemon & 
xrdb -merge .Xresources
hsetroot -fill Dropbox/Wallpapers/airship.jpg
xcompmgr -n &
exec ck-launch-session xmonad

