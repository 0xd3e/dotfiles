# Dotfiles

This repository contains my dotfiles and other stuff I need to get going. For
now packages are managed by Nix (see [flake.nix](./flake.nix)) and everything
else is managed by Ansible.

## Usage

Nix needs to be installed before anything else can happen.

**Install Nix profile (run only once - if the system is new)**

```bash
$ nix profile install .
```

**Install packages**

```bash
$ nix profile upgrade 0
```

**Run Ansible**

```bash
$ nix develop
$ ansible-playbook dotfile.yaml
```

## Ansible Tags

These tags can be used to limit the tasks to a certain subset.

| Tag       | Description                                                 |
|:----------|:------------------------------------------------------------|
| `configs` | Run all tasks defined in the `configs` directory (dorfiles) |
| `zsh`     | Setup ZSH config files                                      |
| `bat`     | Write bat config                                            |
| `wezterm` | Setup WezTerm config                                        |
| `fonts`   | Install fonts                                               |
