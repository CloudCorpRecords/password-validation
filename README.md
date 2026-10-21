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
