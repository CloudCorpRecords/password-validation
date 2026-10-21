fn all_in(s: &str, lo: u8, hi: u8) -> bool {
    !s.is_empty() && s.bytes().all(|c| (lo..=hi).contains(&c))
}

/// Reports whether `pwd` meets any of the weak-password conditions.
pub fn is_weak(pwd: &str, common_words: &[String]) -> bool {
    if pwd.len() < 6 {
        return true;
    }
    if all_in(pwd, b'0', b'9') {
        return true;
    }
    if all_in(pwd, b'a', b'z') || all_in(pwd, b'A', b'Z') {
        return true;
    }
    common_words.iter().any(|w| !w.is_empty() && pwd.contains(w.as_str()))
}

/// Classifies each password as "weak" or "strong".
pub fn get_password_strength(passwords: &[String], common_words: &[String]) -> Vec<&'static str> {
    passwords
        .iter()
        .map(|p| if is_weak(p, common_words) { "weak" } else { "strong" })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn v(items: &[&str]) -> Vec<String> {
        items.iter().map(|s| s.to_string()).collect()
    }

    #[test]
    fn problem_example() {
        assert_eq!(
            get_password_strength(
                &v(&["iliketoCoDe", "teaMAKEsmehappy", "123456789", "xYz12", "password"]),
                &v(&["coffee", "code", "happy"]),
            ),
            vec!["strong", "weak", "weak", "weak", "weak"]
        );
    }

    #[test]
    fn rules() {
        let none: Vec<String> = vec![];
        assert!(is_weak("Abc12", &none));
        assert!(!is_weak("Abc123", &none));
        assert!(is_weak("123456", &none));
        assert!(!is_weak("12345a", &none));
        assert!(is_weak("abcdefg", &none));
        assert!(is_weak("ABCDEFG", &none));
        assert!(!is_weak("Abcdefg", &none));
        assert!(is_weak("mycoffeecup1", &v(&["coffee"])));
        assert!(!is_weak("myCoffeeCup", &v(&["coffee"])));
        assert!(!is_weak("Abc123", &v(&[""])));
    }
}
