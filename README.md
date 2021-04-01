# Set-up development machine with Ansible

## Intro

I am tired of setting up my dev laptop every time something happens or changing the job. I used Ansible to configure my routine tasks of setting up the environment:

- Mac OS preferences.
- Touch ID for sudo authentication.
- [zsh](https://github.com/zsh-users/zsh), [hyper](https://github.com/vercel/hyper) and [spaceship](https://github.com/denysdovhan/spaceship-prompt).
- Install essential tools and packages, communication, development, and media apps.
- Python via [pyenv](https://github.com/pyenv/pyenv).
- Configuration files as symlinks. 

## Usage

You can use this repository as a bootstrap or template for your personal configuration.

* Clone this repository to your local drive.
* In [configs/default.config.yaml](configs/default.config.yaml) set the folder where you cloned repository via variable `dotfiles_repo_local`.
* Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
* Run `ansible-playbook main.yml -i inventory.yaml --ask-become-pass` inside this directory. Enter your account password when prompted.

### Dependencies

#### Common

* Python 3
* [Ansible](https://docs.ansible.com/ansible/2.10/installation_guide/index.html) (I am using 2.10)

#### MacOS Specific
Ensure Apple's command line tools are installed (`xcode-select --install`).

## Inspired by

* [@webpro/awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
* [@mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [@nikitavoloboev/dotfiles](https://github.com/nikitavoloboev/dotfiles)
* [@cowboy/dotfiles](https://github.com/cowboy/dotfiles)
* [@geerlingguy/dotfiles](https://github.com/geerlingguy/dotfiles)
* [@geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

## Potential improvements

* Use `ansible` to configure Mac OS preferences.
* Add configuration for my Linux setup.
* Add configuration for my Windows entertainment setup.
* CI via GitHub actions.
