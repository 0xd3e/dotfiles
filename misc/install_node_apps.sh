#!/usr/bin/env zsh

PACKAGES=(
	'typescript'
	'typescript-language-server'
	'@volar/vue-language-server'
	'vscode-langservers-extracted'
)

for pkg in ${PACKAGES[@]}
do
	npm install -g $pkg
done
