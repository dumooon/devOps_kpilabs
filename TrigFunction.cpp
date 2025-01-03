#include "TrigFunction.h"
#include <cmath>

double TrigFunction::FuncA(int n) {
    double result = 0.0;
    for(int i = 0; i < n; i++) {
        double term = std::pow(-1, i) * std::pow(x, 2*i + 1) / (2*i + 1);
        result += term;
    }
    return result;
}