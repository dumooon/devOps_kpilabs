#include "TrigFunction.h"
#include <cmath>

// Implementation of FuncA: calculates sum of first 3 elements of the series
double TrigFunction::FuncA() {
    int n = 3;
    double result = 0.0;
    for (int i = 0; i < n; ++i) {
        result += (std::pow(-1, i) * std::pow(x, 2 * i + 1)) / (2 * i + 1);
    }
    return result;
}
