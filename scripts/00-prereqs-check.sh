#!/usr/bin/env bash
set -euo pipefail

req=(docker kubectl kind helm git)
for c in "${req[@]}"; do
  command -v "$c" >/dev/null 2>&1 || { echo "Missing: $c"; exit 1; }
done

echo "✅ Prereqs OK: ${req[*]}"
