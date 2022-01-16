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
This program takes some arguments and needs an environment
### Environment
- in `./bin` create `./bin/out` 
- run the generator script `python3 Gen.py`
- enter the number of columns you would like
- a file `map.mp` has been created
- run the program with `./cgol map.mp [number of columns] [number of generations]`


## About This Project
This project is to show a CUDA implimentation of Conway's Game Of Life 


## TODO
- [x] Read input from a file
- [x] Make a helper program to generate maps
- [x] Create an evaluation Kernel
- [x] form a linked list data structure of boards
- [x] pass the boards iteratively to generate new boards  
- [x]  **dump result boards into a map file**
- []  pop the tail of the linked list to save memory
- []  profile and optimise code
- []  **python utility to render map files**
- []  improve generation helper python program
