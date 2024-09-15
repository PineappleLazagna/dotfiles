
#!/bin/bash
directory=~/Pictures/Wallpapers
monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'` 
if [ -d "$directory" ]; then
  random_wallpaper=$(ls $directory/* | shuf -n 1)
  echo $random_wallpaper
  hyprctl hyprpaper unload all;
  hyprctl hyprpaper preload $random_wallpaper;
  hyprctl hyprpaper wallpaper ",$random_wallpaper";
fi
