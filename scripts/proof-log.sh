#!/usr/bin/env bash
# Writes proof/verify.log: commit, date, toolchain versions, then the full
# plain-text output of scripts/verify.sh.
set -uo pipefail
cd "$(dirname "$0")/.."
mkdir -p proof
{
  echo "commit:    $(git rev-parse HEAD)"
  echo "date:      $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  [ -n "${GITHUB_RUN_ID:-}" ] && echo "ci run:    ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
  echo
  echo "toolchains:"
  echo "  node    $(node --version 2>&1)"
  echo "  python  $(python3 --version 2>&1)"
  echo "  c++     $(c++ --version 2>&1 | head -1)"
  echo "  go      $(go version 2>&1)"
  echo "  java    $(java -version 2>&1 | head -1)"
  echo "  rust    $(rustc --version 2>&1)"
  echo "  ruby    $(ruby --version 2>&1)"
  echo
  scripts/verify.sh
  echo "exit code: $?"
} > proof/verify.log 2>&1
tail -3 proof/verify.log
grep -q '^exit code: 0$' proof/verify.log
