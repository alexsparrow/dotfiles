#!/usr/bin/sh
rofi -modi clipboard:~/.bin/cliphist-rofi-img-only -show clipboard -show-icons \
	-theme-str '#window {height: 80%; }' -theme-str '#element-icon {size: 10ch; }'
