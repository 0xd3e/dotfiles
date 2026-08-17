#!/usr/bin/env fish
#
# dotdiff.fish
#
# Compares each tool's files in configs/files/<tool> against the deployed
# location on disk (read from the <tool>_config_path variables in
# dotfile.yaml), and prints a diff wherever they differ.
#
# USAGE (from anywhere, or from within the repo):
#   ./dotdiff.fish                 # diff every tool found in dotfile.yaml
#   ./dotdiff.fish fish nvim       # diff only specific tools

set -l repo (path resolve (status dirname))
set -l playbook_path $repo/dotfiles.yaml
set -l files_root $repo/configs/files

if not test -f $playbook_path
	echo "Couldn't find $playbook_path" >&2
	exit 1
end

if not test -d $files_root
	echo "Couldn't find $files_root" >&2
	exit 1
end

set -l home_var $HOME
set -l dot_config_var "$home_var/.config"

set -l tool_filter $argv

for line in (grep -E '^\s*[A-Za-z0-9_]+_config_dir:' $playbook_path)
    set -l var_name (string replace -r '^\s*([A-Za-z0-9_]+)_config_dir:.*' '$1' -- $line)
    set -l raw_value (string replace -r '^[^:]+:\s*' '' -- $line)

    # Strip surrounding quotes.
    set -l value (string trim -c '\'"' -- $raw_value)

    # Resolve the variables.
    set value (string replace -a '{{ home }}' $home_var -- $value)
    set value (string replace -a '{{home}}' $home_var -- $value)
    set value (string replace -a '{{ dot_config }}' $dot_config_var -- $value)
    set value (string replace -a '{{dot_config}}' $dot_config_var -- $value)

    if string match -qr '\{\{.*\}\}' -- $value
        echo "Skipping '$var_name' — unresolved template in value: $value" >&2
        continue
    end

    # Honor an optional tool filter.
    if test (count $tool_filter) -gt 0
        if not contains $var_name $tool_filter
            continue
        end
    end

    set -l src_dir $files_root/$var_name
    set -l dest_dir $value

    if not test -d $src_dir
        echo "No source dir for '$var_name' at $src_dir — skipping" >&2
        continue
    end

    if not test -e $dest_dir
        echo "── $var_name ──────────────────────────────"
        echo "  not deployed yet (missing: $dest_dir)"
        echo
        continue
    end

    set -l diff_output (/usr/bin/diff -rq --exclude='.git' $src_dir $dest_dir 2>/dev/null)

    if test -n "$diff_output"
        echo "── $var_name ──────────────────────────────"
        echo "   repo: $src_dir"
        echo "   live: $dest_dir"
        echo
        diff -ru --exclude='.git' $src_dir $dest_dir
        echo
    end
end
