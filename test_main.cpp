// test_main.cpp
#include "TrigFunction.h"
#include <cassert>
#include <cmath>
#include <iostream>
#include <chrono>
#include <vector>
#include <random>
#include <algorithm>

void testFuncA() {
    TrigFunction trigFunc(0.5);
    double result = trigFunc.FuncA(3);
    double expected = 0.4817708;
    assert(std::abs(result - expected) < 1e-6);
}

void testExecutionTime() {
    auto t1 = std::chrono::high_resolution_clock::now();

    // Setup test data
    std::vector<int> aValues;
    std::mt19937 mtre{123};
    std::uniform_int_distribution<int> distr{0, 2000000};

    // Fill vector
    for (int i = 0; i < 2000000; i++) {
        aValues.push_back(distr(mtre));
    }

    // Perform calculations
    TrigFunction trigFunc(0.5);
    double funcResult = 0.0;
    for (int n = 1; n <= 500; n++) {
        funcResult = trigFunc.FuncA(n);
        std::sort(begin(aValues), end(aValues));
    }

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::seconds>(t2 - t1).count();

    // Assert execution time is between 5 and 20 seconds
    assert(duration >= 5 && duration <= 20);
    std::cout << "Execution time: " << duration << " seconds" << std::endl;
}

int main() {
    testFuncA();
    testExecutionTime();
    std::cout << "All tests passed!" << std::endl;
    return 0;
}