// A board is a linked list
// each board contains:
//  - a 2d array of the board
//  - the index of the board
//  - pointer to the next board

#pragma once

#include <cstddef>
#include <string>

namespace cgol {

    class board {
        public:
            int width; // width of the matrix / number of columns in the matrix
            int height; // number of rows in the matrix
            int* arr; // **the** array 
            
            board *next; // next board
            board *prev; // previous board

            int position;
            
             //constructor 
            board(int x, int y) {
                width = x;
                height = y;
                arr = new int[width * height]; 
            }

            // super cool indexing function to treat a 1d array as 2d
            size_t index( int x, int y ) const { return x + width * y; }
            void print();
            void read(std::string path);
            void write(std::string path, int *arr, size_t N);
           
    };


}