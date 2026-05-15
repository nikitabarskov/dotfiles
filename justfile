fix:
    mise fmt
    biome check --unsafe --write

upgrade target="":
    mise upgrade --bump {{ target }}

lock:
    mise lock --platform linux-x64 --platform macos-arm64
