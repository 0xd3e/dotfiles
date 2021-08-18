#!/usr/bin/env zsh

PACKAGES=(
	'python-lsp-server[yapf]'
	'ansible-core'
)

for pkg in ${PACKAGES[@]}
do
	pipx install $pkg
done
