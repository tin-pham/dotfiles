#!/bin/sh
export PATH=$PATH:~/bin

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --output HDMI-1-1 --auto --left-of eDP-1-1
xrandr --output eDP-1-1 --brightness .8

#set_monitor &
set_bg &
set_ibus &
picom -b --experimental-backends 

exec dbus-launch --sh-syntax --exit-with-session dwm

