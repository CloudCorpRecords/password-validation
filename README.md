# Password Validation, in 7 languages

[![verify](https://github.com/CloudCorpRecords/password-validation/actions/workflows/verify.yml/badge.svg)](https://github.com/CloudCorpRecords/password-validation/actions/workflows/verify.yml)

One HackerRank problem, solved the same way in **TypeScript, Python, C++, Go, Java, Rust and Ruby**.
Each implementation has its own unit tests, and all seven must produce byte-identical
output on one shared set of golden cases.

![All seven implementations passing unit tests and every shared case](docs/verify-demo.gif)

<sub>Recorded by CI on every push to `main` ([MP4](docs/verify-demo.mp4)), so the video always reflects the current code.</sub>

## The problem

A password is **weak** if any of these hold:

- it contains a word from the common words list (case-sensitive substring)
- it contains only digits
- it contains only lowercase letters, or only uppercase letters
- it has fewer than 6 characters

Otherwise it is **strong**. Given a list of passwords and a list of common words, classify each password.

```
passwords    = ["iliketoCoDe", "teaMAKEsmehappy", "123456789", "xYz12", "password"]
common_words = ["coffee", "code", "happy"]
output       = ["strong", "weak", "weak", "weak", "weak"]
```

## Languages

| Language   | Solution | Unit tests | stdin runner |
|------------|----------|------------|--------------|
| TypeScript | [`typescript/solution.ts`](typescript/solution.ts) | [`solution.test.ts`](typescript/solution.test.ts) (`node:test`) | [`main.ts`](typescript/main.ts) |
| Python     | [`python/solution.py`](python/solution.py) | [`test_solution.py`](python/test_solution.py) (`unittest`) | [`main.py`](python/main.py) |
| C++17      | [`cpp/solution.cpp`](cpp/solution.cpp) | [`test_solution.cpp`](cpp/test_solution.cpp) | [`main.cpp`](cpp/main.cpp) |
| Go         | [`go/solution.go`](go/solution.go) | [`solution_test.go`](go/solution_test.go) (`go test`) | [`main.go`](go/main.go) |
| Java 21    | [`java/Solution.java`](java/Solution.java) | [`SolutionTest.java`](java/SolutionTest.java) | [`Main.java`](java/Main.java) |
| Rust       | [`rust/src/lib.rs`](rust/src/lib.rs) | in `lib.rs` (`cargo test`) | [`main.rs`](rust/src/main.rs) |
| Ruby       | [`ruby/solution.rb`](ruby/solution.rb) | [`test_solution.rb`](ruby/test_solution.rb) (`minitest`) | [`main.rb`](ruby/main.rb) |

None of them use third-party dependencies. Each splits the pure solution function from the
stdin/stdout runner, so the logic can be unit-tested without I/O.

## How it's verified

1. **Unit tests per language** cover the problem's example, the length boundary (5 vs 6),
   digits only, single case, case-sensitive common words, and ignoring an empty common word.
2. **Shared golden cases** in [`cases/`](cases): each `NN-name.in` is HackerRank-format stdin
   (`n`, then the passwords, then `m`, then the common words) with the expected `NN-name.out`.
   Every language's runner is diffed against all of them, including a CRLF-input case.
3. **CI** ([`verify.yml`](.github/workflows/verify.yml)) runs each language as a separate job,
   then records the full run with [VHS](https://github.com/charmbracelet/vhs) and commits the video.

Run it yourself (needs whichever toolchains you want to check: Node 22+, Python 3, a C++17 compiler, Go, JDK 17+, Rust, Ruby):

```bash
scripts/verify.sh
```

```bash
scripts/verify.sh python rust
```

## Design notes

- **Rule order:** length, then digits-only, then single-case, then the common-word scan.
  The cheap O(len) checks short-circuit before the O(len × words) substring scan.
- **"Only lowercase/uppercase letters"** is read strictly: the whole password must be letters of
  one case. `abc!!!` and `!!!!!!` are strong under these rules (see `cases/06-symbols-and-mixed`).
- **ASCII:** character classes are ASCII (`0-9`, `a-z`, `A-Z`) in every language, so behavior
  matches exactly instead of each language's Unicode rules.
- **Empty common words** are ignored; otherwise `""` would match every password.

## Live interview demo

This started during a live HackerRank technical interview (TypeScript), written with the help of
an AI coding agent (Claude Code), which was disclosed to the interviewers. It was then ported to six
more languages with a shared test suite to show the same solution holds up across languages.
