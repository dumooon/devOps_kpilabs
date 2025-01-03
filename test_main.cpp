#include "TrigFunction.h"
#include <cassert>
#include <cmath>
#include <iostream>

void testFuncA() {
    TrigFunction trigFunc(0.5);
    double result = trigFunc.FuncA(3);
    double expected = 0.4817708;
    assert(std::abs(result - expected) < 1e-6);
}

int main() {
    testFuncA();
    std::cout << "All tests passed!" << std::endl;
    return 0;
}