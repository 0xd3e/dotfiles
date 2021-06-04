#!/usr/bin/env zsh

FONT_DIR="$HOME/Library/Fonts"
FONT_URLS=(
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono.ttf'
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono-Bold.ttf'
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono-Italic.ttf'
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono-Bold-Italic.ttf'
)

for url in "${FONT_URLS[@]}"
do
	name=$(basename $url)
	curl --silent --output $FONT_DIR/$name $url
done
