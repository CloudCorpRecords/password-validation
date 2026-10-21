import sys

from solution import get_password_strength


def main() -> None:
    lines = [l.rstrip("\r") for l in sys.stdin.read().split("\n")]
    i = 0
    n = int(lines[i]); i += 1
    passwords = lines[i:i + n]; i += n
    m = int(lines[i]); i += 1
    common_words = lines[i:i + m]
    print("\n".join(get_password_strength(passwords, common_words)))


if __name__ == "__main__":
    main()
