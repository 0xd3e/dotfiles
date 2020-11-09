# Dotfiles

This repository contains my dotfiles and other stuff I need to get going.
All of this is managed by [Ansible][ansible]. If you've never seen Ansible
before, the contents of this repository might be a bit overwhelming.

If you are only here for the configuration files, you can find them in the
subdirectories of the `roles` folder. Inside these directories you'll see other
directories called `files` and/or `templates`. These are the places where the
configuration files are stored.

Whenever possible, I kept using plain files under the `files` directory. Files
under the `templates` directory will most likely contain variables that are
replaced by Ansible.

[ansible]: https://www.ansible.com/
