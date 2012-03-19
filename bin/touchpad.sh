DEVNAME="ImPS/2 Generic Wheel Mouse"
function get_mouse_state(){
    xinput list-props "$DEVNAME" | grep "Device Enabled" | awk 'BEGIN{FS=":\t"}{print $2}'
}

function set_mouse_state(){
    NEWSTATE=$1
    xinput set-prop "$DEVNAME" "Device Enabled" $NEWSTATE
}

TPSTATE=$(get_mouse_state)
let NEWSTATE="! $TPSTATE"
if [ $NEWSTATE -eq 1 ]
then
    echo "Enabling mouse..."
else
    echo "Disabling mouse..."
fi
set_mouse_state $NEWSTATE
