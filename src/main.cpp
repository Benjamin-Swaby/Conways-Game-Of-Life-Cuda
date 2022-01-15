#include <iostream>
#include <fstream>
#include <string>

#include "board.h"

using namespace cgol;


int main(int argc, char *argv[]){

    if (argc < 3) {
        std::cout << "enter the map dir and the size of the board eg: \n ./cgol map.mp 100 \n for a 100x100 map stored at map.mp" << std::endl;
        return -1;
    }
    

    int size = atoi(argv[2]);
    board *my_board = new board(size,size); //make a new board 

    my_board->read(argv[1]); // read the file into the board array
    my_board->print(); // print the board

    return 1;
}