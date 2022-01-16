#include <iostream>
#include <fstream>
#include <string>

#include "board.h"
#include "kernel.h"

using namespace cgol;


int main(int argc, char *argv[]){

    if (argc < 4) {
        std::cout << "enter the map dir and the size of the board and the number of generations eg: \n ./cgol map.mp 100 6\n for a 100x100 map stored at map.mp for 6 generations" << std::endl;
        return -1;
    }
    

    int size = atoi(argv[2]);
    int generations = atoi(argv[3]);

    board *my_board = new board(size,size); //make a new board 

    my_board->position = 0; // set as the head

    my_board->read(argv[1]); // read the file into the board array
    my_board->print(); // print the board

    board *input = my_board;
    std::string path_base = "./out/map";
    for (int i = 0; i < generations; i++) {
        launcher(input);
        input->print();
        std::string path = path_base + std::to_string(i);
        input->write(path, input->arr, (input->width * input->height));
        input = input->next;
    }

    return 1;
}