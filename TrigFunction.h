// TrigFunction.h
#ifndef TRIGFUNCTION_H
#define TRIGFUNCTION_H

class TrigFunction {
private:
    double x;

public:
    TrigFunction(double input = 0.0) : x(input) {}
    double FuncA(int n);  // Updated to include int parameter
};

#endif