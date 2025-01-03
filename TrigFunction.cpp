#include "TrigFunction.h"
#include <cmath>

// Implementation of FuncA:
// Calculates the sum of the first n elements of the arctan series.
// Param n: Number of elements in the series to calculate.
double TrigFunction::FuncA(int n) {
    double result = 0.0;
    for (int i = 0; i < n; ++i) {
        result += (std::pow(-1, i) * std::pow(x, 2 * i + 1)) / (2 * i + 1);
    }
    return result;
}
