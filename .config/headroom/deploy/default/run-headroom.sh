#!/usr/bin/env bash
set -euo pipefail

exec "${HOME}/.local/bin/mise" exec -- headroom install agent run --profile default
