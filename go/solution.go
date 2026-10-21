package main

import "strings"

func allIn(s string, lo, hi byte) bool {
	if len(s) == 0 {
		return false
	}
	for i := 0; i < len(s); i++ {
		if s[i] < lo || s[i] > hi {
			return false
		}
	}
	return true
}

// IsWeak reports whether pwd meets any of the weak-password conditions.
func IsWeak(pwd string, commonWords []string) bool {
	if len(pwd) < 6 {
		return true
	}
	if allIn(pwd, '0', '9') {
		return true
	}
	if allIn(pwd, 'a', 'z') || allIn(pwd, 'A', 'Z') {
		return true
	}
	for _, w := range commonWords {
		if w != "" && strings.Contains(pwd, w) {
			return true
		}
	}
	return false
}

// GetPasswordStrength classifies each password as "weak" or "strong".
func GetPasswordStrength(passwords, commonWords []string) []string {
	result := make([]string, len(passwords))
	for i, p := range passwords {
		if IsWeak(p, commonWords) {
			result[i] = "weak"
		} else {
			result[i] = "strong"
		}
	}
	return result
}
