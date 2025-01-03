// main.cpp
#include "TrigFunction.h"
#include <iostream>

int main() {
    static const double x = 0.5;
    static const int n = 10;
    
    TrigFunction trigFunc(x);
    std::cout << "Result of FuncA: " << trigFunc.FuncA(n) << std::endl;
    return 0;
}