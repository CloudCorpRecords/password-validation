"""Password Validation: classify each password as "weak" or "strong"."""

from typing import List


def _all_in(s: str, lo: str, hi: str) -> bool:
    return len(s) > 0 and all(lo <= c <= hi for c in s)


def is_weak(pwd: str, common_words: List[str]) -> bool:
    if len(pwd) < 6:
        return True
    if _all_in(pwd, "0", "9"):
        return True
    if _all_in(pwd, "a", "z") or _all_in(pwd, "A", "Z"):
        return True
    return any(w and w in pwd for w in common_words)


def get_password_strength(passwords: List[str], common_words: List[str]) -> List[str]:
    return ["weak" if is_weak(p, common_words) else "strong" for p in passwords]
