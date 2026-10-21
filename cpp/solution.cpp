#include "solution.hpp"

#include <algorithm>

static bool allIn(const std::string& s, char lo, char hi) {
    return !s.empty() && std::all_of(s.begin(), s.end(), [&](char c) { return c >= lo && c <= hi; });
}

bool isWeak(const std::string& pwd, const std::vector<std::string>& commonWords) {
    if (pwd.size() < 6) return true;
    if (allIn(pwd, '0', '9')) return true;
    if (allIn(pwd, 'a', 'z') || allIn(pwd, 'A', 'Z')) return true;
    for (const auto& w : commonWords) {
        if (!w.empty() && pwd.find(w) != std::string::npos) return true;
    }
    return false;
}

std::vector<std::string> getPasswordStrength(const std::vector<std::string>& passwords,
                                             const std::vector<std::string>& commonWords) {
    std::vector<std::string> result;
    result.reserve(passwords.size());
    for (const auto& p : passwords) result.push_back(isWeak(p, commonWords) ? "weak" : "strong");
    return result;
}
