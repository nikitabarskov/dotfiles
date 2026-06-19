bash_files := "install.sh bootstrap.sh scripts/xfce4-hidpi-setup.sh .aliases"
sh_files := ".profile .environment .xprofile"

default:
    just --list

configure:
    mise install

fix:
    mise fmt --all
    oxfmt --write .
    shfmt --write .

validate:
    mise fmt --check
    oxfmt --check .
    shellcheck --shell=bash {{ bash_files }}
    shellcheck --shell=sh -x --exclude=SC1091 {{ sh_files }}
    shfmt --diff .

mise_args := ""

upgrade target="":
    mise upgrade {{ mise_args }} --bump {{ target }}

lock:
    mise lock {{ mise_args }} --platform linux-x64 --platform macos-arm64

use target:
    mise use {{ mise_args }} {{ target }}
