#!/usr/bin/env bash
set -euo pipefail

# Claude and ChatGPT app uploads require a zip whose root is the skill folder,
# and the folder name must match the `name` field in SKILL.md.

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
out="$root/dist"
rm -rf "$out"
mkdir -p "$out"

for dir in "$root"/skills/*/; do
  skill="$(basename "$dir")"
  (cd "$root/skills" && zip -qr "$out/$skill.zip" "$skill" -x '.*')
  echo "packaged $out/$skill.zip"
done
