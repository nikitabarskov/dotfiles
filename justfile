fix:
    oxfmt --write .

validate:
    oxfmt --check .

upgrade target="":
    mise upgrade --bump {{ target }}

lock:
    mise lock --platform linux-x64 --platform macos-arm64
