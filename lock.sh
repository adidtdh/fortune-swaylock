#!/usr/bin/env bash
scr='/tmp/screenshot.png'
icon="lock-icon.png"
# To change the font used add `-font $font`
# After pointsize in the 'add fortune text section'
# font="$HOME/.local/share/fonts/Aller_Lt.ttf"
# Expand is used to convert the tabs to spaces which
# are handled better by imageMagick
fortune=$(expand -t 2 <(fortune -s))
gradientColor='#E84C3D'

# take a screenshot
grim "$scr"

# get gradient dimensions directly from the screenshot
read width height <<<$(file $scr | cut -d, -f 2 | tr -d ' ' | tr 'x' ' ')
height=$((height / 2))

convert "$scr" -scale 10% -scale 1000%\
	-size "${width}x${height}" -gravity south-west \
	gradient:none-"$gradientColor" -composite -matte \
	"$icon" -gravity center -composite -matte \
	-gravity center -pointsize 20 \
	-fill "#EAE4D1" -annotate +0+200 "$fortune" "$scr"
swaylock -ui "$scr"
