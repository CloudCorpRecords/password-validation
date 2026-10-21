/**
 * Password Validation
 *
 * A password is "weak" if it meets ANY of these conditions:
 *   - Contains a word from the common words list (case-sensitive substring)
 *   - Contains only digits
 *   - Contains only lowercase or only uppercase letters
 *   - Has fewer than 6 characters
 * All other passwords are "strong".
 */
export function getPasswordStrength(passwords: string[], commonWords: string[]): string[] {
    return passwords.map((pwd) => (isWeak(pwd, commonWords) ? 'weak' : 'strong'));
}

function isWeak(pwd: string, commonWords: string[]): boolean {
    if (pwd.length < 6) return true;
    if (/^[0-9]+$/.test(pwd)) return true;
    if (/^[a-z]+$/.test(pwd) || /^[A-Z]+$/.test(pwd)) return true;
    return commonWords.some((w) => w.length > 0 && pwd.includes(w));
}
