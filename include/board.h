// A board is a linked list
// each board contains:
//  - a 2d array of the board
//  - the index of the board
//  - pointer to the next board

#pragma once

namespace cgol {

    template<size_t max>
    class board {
        public:
            // a 2d buffer to store cells in
            // each cell is an int either 1 or 0.
            int arr[max][max];
            int state_count; // the iteration of the board
            board *next_board;
    };

}