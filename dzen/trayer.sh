#!/bin/sh
source ~/.dot.conf
source $DOTPATH/dzen/config.sh

source $DOTPATH/shell/display_info.sh
DISP_WIDTH=$(display_width)

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
       --expand true --widthtype request  --margin 350 --height 15 \
       --transparent true --tint 0x303030 --alpha 0
