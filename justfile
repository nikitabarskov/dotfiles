bash_files := "install.sh bootstrap.sh scripts/xfce4-hidpi-setup.sh .aliases"
sh_files := ".profile .environment .xprofile"

fix:
    oxfmt --write .

validate:
    oxfmt --check .
    shellcheck --shell=bash {{ bash_files }}
    shellcheck --shell=sh -x --exclude=SC1091 {{ sh_files }}

upgrade target="":
    mise upgrade --bump {{ target }}

lock:
    mise lock --platform linux-x64 --platform macos-arm64

use target:
    mise use {{ target }}
