#include <iostream>
#include <string>
#include <vector>

#include "solution.hpp"

static int failures = 0;

#define CHECK(cond)                                                          \
    do {                                                                     \
        if (!(cond)) {                                                       \
            std::cerr << "FAIL " << __FILE__ << ":" << __LINE__ << "  " #cond "\n"; \
            ++failures;                                                      \
        }                                                                    \
    } while (0)

int main() {
    using V = std::vector<std::string>;

    CHECK((getPasswordStrength({"iliketoCoDe", "teaMAKEsmehappy", "123456789", "xYz12", "password"},
                               {"coffee", "code", "happy"}) == V{"strong", "weak", "weak", "weak", "weak"}));
    CHECK(isWeak("Abc12", {}));
    CHECK(!isWeak("Abc123", {}));
    CHECK(isWeak("123456", {}));
    CHECK(!isWeak("12345a", {}));
    CHECK(isWeak("abcdefg", {}));
    CHECK(isWeak("ABCDEFG", {}));
    CHECK(!isWeak("Abcdefg", {}));
    CHECK(isWeak("mycoffeecup1", {"coffee"}));
    CHECK(!isWeak("myCoffeeCup", {"coffee"}));
    CHECK(!isWeak("Abc123", {""}));

    if (failures) {
        std::cerr << failures << " check(s) failed\n";
        return 1;
    }
    std::cout << "cpp: all unit tests passed\n";
    return 0;
}
