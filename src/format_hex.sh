#!/bin/bash

set -euo pipefail

od -v -An -t x4 "$1.bin" | awk '{$1=$1};1' > "$1.hex"
