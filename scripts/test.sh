#!/usr/bin/env bash
set -euo pipefail

echo "Running tests..."

# "Exfil" simulation: prove the secret was accessible without printing it.
# We record length + sha256 prefix into an artifact.
if [[ -n "${DEMO_SECRET:-}" ]]; then
  len=${#DEMO_SECRET}
  hash=$(printf "%s" "DEMO_SECRET" | sha256sum | awk '{print $1}' | cut -c1-12)
  echo "DEMO_SECRET was present. len=$len sha256_prefix=$hash" | tee artifact.txt
else
  echo "DEMO_SECRET not present" | tee artifact.txt
fi
