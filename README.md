# Conway's Game Of Life 

## Prerequisites
    - Cuda enabled GPU
    - Cuda toolkit (nvcc)
    - C++ compiler
    - cmake
    - make
    - A linux environment (Can be virtualised)

## Building
    To build this program :
        - Clone the repo,
        - `mkdir build`
        - `cd build`
        - `cmake ..`
        - `make`

## Running
    This program requires some data in the 
    form of a map to be given to it. To do this
    either create a file (map.mp) for example and fill 
    it with a matrix of 1 and 0. Alternatively a helper program
    can generate you a grid.

## About This Project
    This project is to show a CUDA implimentation of Conway's Game Of Life 


## TODO
    - [x] Read input from a file
    - [x] Make a helper program to generate maps
    - []  Create an evaluation Kernel
    - []  form a linked list data structure of boards
    - []  pass the boards iteratively to generate new boards
    - []  dump old boards into a map file
    - []  pop the tail of the linked list to save memory
    - []  *python utility to render map files*
    - []  improve generation helper python program
