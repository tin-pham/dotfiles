#!/bin/sh
export PATH=$PATH:~/bin

xrandr --setprovideroutputsource NVIDIA-0
xrandr --auto
xrandr --output eDP-1-1 --off
xrandr --ouput HDMI-1-1 --primary
#xrandr --output eDP-1-1 --gamma 1:1:1 --brightness 1
#xrandr --output HDMI-1-1 --auto --left-of eDP-1-1

#set_monitor &
set_bg &
set_ibus &
#picom -b --experimental-backends #new version didn't have experimental-backends
#picom -b

exec dbus-launch --sh-syntax --exit-with-session dwm
