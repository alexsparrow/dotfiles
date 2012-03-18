function display_width {
    xdpyinfo  | grep dimensions | awk 'BEGIN { FS=":" }{print $2}' | awk 'BEGIN { FS="x" }{ print $1 }'
}

function display_height {
    xdpyinfo  | grep dimensions | awk 'BEGIN { FS=":" }{print $2}' | awk 'BEGIN { FS="x" }{ print $2 }'
}
