#include "board.h"
#include "colours.h"

#include <iostream>
#include <fstream>
#include <string>

void cgol::board::print() {
    int x = 0;
    int y = 0;

    for (int i = 0; i < this->width*this->height; i++) {
        if (x >= width) {
            x = 0;
            std::cout << "\n"; 
        }
        //std::cout << "x = " << x << " y = " << y << "\n";

        if (arr[i]) {
            std::cout << GRN<< arr[i] << reset << ",";
        } else {
            std::cout << RED << arr[i] << reset << ",";
        }
        
        x++;
    }

    std::cout << std::endl;
} 

void cgol::board::read(std::string path) {
    char ch;
    std::fstream fin(path, std::fstream::in);
    
    int x = 0;

    while (fin >> std::noskipws >> ch) {
        //std::cout << "arr[" << x << "] = " << (int)ch - 48 << "\n";
        arr[x] = (int)ch - 48;
        x++;
    }
}