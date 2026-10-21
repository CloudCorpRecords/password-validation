#!/usr/bin/env bash
# Builds every implementation, runs its unit tests, then feeds every shared
# case in cases/*.in through its stdin runner and diffs against cases/*.out.
#
#   scripts/verify.sh              # all languages
#   scripts/verify.sh python go    # just these
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

ALL=(typescript python cpp go java rust ruby)
LANGS=("${@:-${ALL[@]}}")

if [ -t 1 ] || [ -n "${FORCE_COLOR:-}" ]; then
  G=$'\e[32m'; R=$'\e[31m'; B=$'\e[1m'; D=$'\e[2m'; N=$'\e[0m'
else
  G=; R=; B=; D=; N=
fi

build() {
  case "$1" in
    typescript) : ;;
    python)     : ;;
    cpp)        make -s -C cpp all ;;
    go)         (cd go && go build -o build/main .) ;;
    java)       mkdir -p java/build && javac -d java/build java/*.java ;;
    rust)       (cd rust && cargo build -q --release) ;;
    ruby)       : ;;
  esac
}

unit() {
  case "$1" in
    typescript) (cd typescript && npm test --silent) ;;
    python)     (cd python && python3 -m unittest -q test_solution) ;;
    cpp)        make -s -C cpp test ;;
    go)         (cd go && go test ./...) ;;
    java)       java -cp java/build SolutionTest ;;
    rust)       (cd rust && cargo test -q) ;;
    ruby)       ruby ruby/test_solution.rb ;;
  esac
}

run() {
  case "$1" in
    typescript) node --no-warnings --experimental-strip-types typescript/main.ts ;;
    python)     python3 python/main.py ;;
    cpp)        ./cpp/build/main ;;
    go)         ./go/build/main ;;
    java)       java -cp java/build Main ;;
    rust)       ./rust/target/release/password_validation ;;
    ruby)       ruby ruby/main.rb ;;
  esac
}

cases=(cases/*.in)
summary=()
failed=0

for lang in "${LANGS[@]}"; do
  echo "${B}== $lang ==${N}"
  if ! build "$lang" >/tmp/pv-build-$$ 2>&1; then
    cat /tmp/pv-build-$$
    echo "  ${R}build FAILED${N}"
    summary+=("$(printf '%-11s %sbuild failed%s' "$lang" "$R" "$N")")
    failed=1
    continue
  fi

  if unit "$lang" >/tmp/pv-unit-$$ 2>&1; then
    unit_status="${G}pass${N}"
    echo "  unit tests      ${G}PASS${N}"
  else
    cat /tmp/pv-unit-$$
    unit_status="${R}FAIL${N}"
    echo "  unit tests      ${R}FAIL${N}"
    failed=1
  fi

  ok=0
  for in_file in "${cases[@]}"; do
    name="$(basename "$in_file" .in)"
    expected="${in_file%.in}.out"
    if diff -u "$expected" <(run "$lang" <"$in_file") >/tmp/pv-diff-$$ 2>&1; then
      ok=$((ok + 1))
      echo "  ${D}case${N} $name ${G}ok${N}"
    else
      echo "  ${D}case${N} $name ${R}MISMATCH${N}"
      sed 's/^/      /' /tmp/pv-diff-$$
      failed=1
    fi
  done

  color=$G; [ "$ok" -eq "${#cases[@]}" ] || color=$R
  summary+=("$(printf '%-11s unit %s   cases %s%d/%d%s' "$lang" "$unit_status" "$color" "$ok" "${#cases[@]}" "$N")")
done
rm -f /tmp/pv-build-$$ /tmp/pv-unit-$$ /tmp/pv-diff-$$

echo
echo "${B}Summary${N}"
printf '  %s\n' "${summary[@]}"
echo
if [ "$failed" -eq 0 ]; then
  echo "${G}${B}All ${#LANGS[@]} implementations agree on all ${#cases[@]} shared cases.${N}"
else
  echo "${R}${B}Some checks failed.${N}"
fi
exit "$failed"
