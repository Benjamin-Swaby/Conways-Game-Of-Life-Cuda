#include <iostream>
#include <fstream>
#include <string>

#include "board.h"

using namespace cgol;

template<size_t max>
int read(int arr[max][max], std::string path) {

    char ch;
    std::fstream fin(path, std::fstream::in);
    
    int x = 0;
    int y = 0;

    while (fin >> std::noskipws >> ch) {

        if (x > max) {
            y++;
            x = 0;
        }
        arr[y][x] = (int)ch - 48;

        x++;
    }
}

int main(){

    //define a new board of size 10x10
    board<10> my_board;
    read(my_board.arr,"map.mp");
    
    for (int i = 0; i < 10; i++) {
        std::cout << my_board.arr[0][i] << "\n";
    }
    
}