# Password Validation

Classifies each password as `weak` or `strong`.

A password is **weak** if any of these hold:
- it contains a word from the common words list (case-sensitive)
- it contains only digits
- it contains only lowercase or only uppercase letters
- it has fewer than 6 characters

Otherwise it is **strong**.

## Usage

Requires Node 22+.

```bash
npm test
printf '5\niliketoCoDe\nteaMAKEsmehappy\n123456789\nxYz12\npassword\n3\ncoffee\ncode\nhappy\n' | npm start --silent
```

Output:
```
strong
weak
weak
weak
weak
```

## Live interview demo

This repo was built as a demo during a live HackerRank technical interview
(problem: **Password Validation**, TypeScript). It was written with the help of
an AI coding agent (Claude Code), which was disclosed to the interviewers.

What it shows:
- the solution itself ([`solution.ts`](solution.ts)): a pure function, separate from I/O
- a HackerRank-style stdin runner ([`main.ts`](main.ts))
- tests covering the problem's example and edge cases ([`solution.test.ts`](solution.test.ts))

Rule order in `isWeak`: length, then all digits, then single case, then
common-word substring. The common-word check runs last because it's the most
expensive (O(len × words)).
