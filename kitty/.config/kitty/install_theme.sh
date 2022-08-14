#!/bin/bash

themes=('Chalkboard', 'Floraverse')

for theme in ${themes[@]} 
do
  if [[ ! -e ./kitty-themes/themes/$theme.conf ]]
  then
    THEME=https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/$theme.conf
    wget -q "$THEME" -P ~/.config/kitty/kitty-themes/themes
    echo Installed $theme.conf
  fi
done

echo Done
