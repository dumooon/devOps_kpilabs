// main.cpp
#include "TrigFunction.h"
#include <iostream>
#include "HTTP_Server.h"

int main() {
    
    std::cout << "Starting HTTP server on port 8081..." << std::endl;
    CreateHTTPserver();
    return 0;
}