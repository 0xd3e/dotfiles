#!/usr/bin/env zsh

FONT_DIR="$HOME/Library/Fonts"
FONT_URLS=(
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono.ttf'
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono-Bold.ttf'
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono-Italic.ttf'
	'https://raw.githubusercontent.com/golang/image/master/font/gofont/ttfs/Go-Mono-Bold-Italic.ttf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-Thin.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-ThinItalic.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-ExtraLight.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-ExtraLightItalic.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-Light.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-LightItalic.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-Regular.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-Italic.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-Medium.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-MediumItalic.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-SemiBold.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-SemiBoldItalic.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-Bold.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-BoldItalic.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-ExtraBold.otf'
	'https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/fonts/otf/JetBrainsMono-ExtraBoldItalic.otf'
)

for url in "${FONT_URLS[@]}"
do
	name=$(basename $url)
	curl --silent --output $FONT_DIR/$name $url
done
