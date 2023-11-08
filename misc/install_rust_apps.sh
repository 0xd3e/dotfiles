#!/usr/bin/env zsh

PACKAGES=(
	'bat'
	'exa'
	'fd-find'
	'gitui'
	'git-delta'
	'just'
	'ripgrep'
	'starship'
	'tealdeer'
	'tectonic'
	'zoxide'
)

for pkg in ${PACKAGES[@]}
do
	cargo install --locked $pkg
done

COMPONENTS=(
	'rust-analyzer'
	'rust-src'
)

for comp in ${COMPONENTS[@]}
do
	rustup component add $comp
done
