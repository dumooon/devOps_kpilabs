// main.cpp
#include <iostream>
#include "TrigFunction.h"

int main() {
    static const double x = 0.5;  // Set static x value
    static const int n = 10;      // Set static n value

    TrigFunction trigFunc(x);
    std::cout << "Result of FuncA: " << trigFunc.FuncA(n) << std::endl;

    return 0;
}