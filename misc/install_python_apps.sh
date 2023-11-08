#!/usr/bin/env zsh

PACKAGES=(
	's3cmd'
)

for pkg in ${PACKAGES[@]}
do
	pipx install $pkg
done
