synclient MaxTapTime=0 
synclient MaxTapMove=0
synclient CoastingSpeed=10
synclient MaxSpeed=1.05
synclient AccelFactor=0.18

xrdb -merge .Xresources
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec i3 -V -d all > ~/.i3.log
