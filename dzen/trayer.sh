#!/bin/sh
source ~/.dot.conf
source $DOTPATH/dzen/config.sh

source $DOTPATH/shell/display_info.sh
DISP_WIDTH=$(display_width)

X=`expr $DISP_WIDTH - $1`

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
       --expand true --widthtype request  --margin $X --height 15 \
       --transparent true --tint 0x303030 --alpha 0
