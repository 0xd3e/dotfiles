#!/usr/bin/env zsh

PACKAGES=(
	'ansible-core'
	'pgcli'
)

for pkg in ${PACKAGES[@]}
do
	pipx install $pkg
done
