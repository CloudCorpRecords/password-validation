#pragma once
#include <string>
#include <vector>

bool isWeak(const std::string& pwd, const std::vector<std::string>& commonWords);
std::vector<std::string> getPasswordStrength(const std::vector<std::string>& passwords,
                                             const std::vector<std::string>& commonWords);
