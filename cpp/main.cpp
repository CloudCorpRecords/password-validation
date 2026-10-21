#include <iostream>
#include <string>
#include <vector>

#include "solution.hpp"

static std::string readLine() {
    std::string line;
    std::getline(std::cin, line);
    if (!line.empty() && line.back() == '\r') line.pop_back();
    return line;
}

static std::vector<std::string> readList() {
    int n = std::stoi(readLine());
    std::vector<std::string> items(n);
    for (auto& item : items) item = readLine();
    return items;
}

int main() {
    auto passwords = readList();
    auto commonWords = readList();
    for (const auto& r : getPasswordStrength(passwords, commonWords)) std::cout << r << '\n';
    return 0;
}
