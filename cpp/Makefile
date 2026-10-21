CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra -Werror
BUILD := build

all: $(BUILD)/main $(BUILD)/test_solution

$(BUILD)/%: %.cpp solution.cpp solution.hpp
	@mkdir -p $(BUILD)
	$(CXX) $(CXXFLAGS) -o $@ $< solution.cpp

test: $(BUILD)/test_solution
	./$(BUILD)/test_solution

clean:
	rm -rf $(BUILD)

.PHONY: all test clean
