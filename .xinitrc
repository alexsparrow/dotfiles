source ~/.dot.conf

source $DOTPATH/shell/dotc_utils.sh

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE=ibus

#xrandr --output DVI-0 --auto --output VGA-0 --auto --left-of DVI-0
xsetroot -cursor_name left_ptr
xset -b
xscreensaver -nosplash &
setxkbmap -layout gb
xrdb -merge .Xresources

dotc_stop_all

dotc_panels $DOTPATH/dzen/panels.conf
# dotc_start_bkg $DOTPATH/dzen/clock.sh clock
# dotc_start_bkg $DOTPATH/dzen/volume.sh volume
# dotc_start_bkg $DOTPATH/dzen/battery.sh battery
# dotc_start_bkg $DOTPATH/dzen/mpc.sh mpc
# dotc_start_bkg $DOTPATH/dzen/trayer.sh trayer
dotc_start_log devmon devmon
dotc_start_log dropboxd dropbox
dotc_start_log offlineimap offlineimap
doct_start_log "xcompmgr -n" xcompmgr
ibus-daemon -x &
urxvtd &
hsetroot -fill ~/Documents/RAEVONA___Docking_Towers_by_ANTIFAN_REAL.jpg


exec xmonad

dotc_stop_all
