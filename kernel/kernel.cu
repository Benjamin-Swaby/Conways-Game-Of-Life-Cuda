#include "board.h"

#include <iostream>

using namespace cgol;

__global__ void step(int *arr, int *result, size_t N, int width) {
    int index =  blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

   for(int i = index; i < N; i += stride)
   {
        int live_neighbours = 0;
        int neighbour_indexes[8];

        neighbour_indexes[0] = (i - width) - 1; // top left
        neighbour_indexes[1] = (i - width); // top
        neighbour_indexes[2] = (i - width) + 1; // top right

        neighbour_indexes[3] = (i - 1); // left
        neighbour_indexes[4] = (i + 1); // right

        neighbour_indexes[5] = (i + width) - 1; // bottom left
        neighbour_indexes[6] = (i + width); // bottom
        neighbour_indexes[7] = (i + width) + 1; // bottom right


        // if the top left isn't at the end of the line or before the array
        if (!(neighbour_indexes[0] < 0 || neighbour_indexes[0] % width == (width - 1))) {
            if (arr[neighbour_indexes[0]]) {
                live_neighbours++;
            }
        }

        // if the top one does exist 
        if (!(neighbour_indexes[1] < 0)) {
            if (arr[neighbour_indexes[1]]) {
                live_neighbours++;
            }
        }

        // if the top right isn't at the start of a line or before the array
        if (!(neighbour_indexes[2] < 0 || neighbour_indexes[2] % width == 0)) {
            if (arr[neighbour_indexes[2]]) {
                live_neighbours++;
            }
        }

        // if the left isn't at the end of a line
        if (!(neighbour_indexes[3] % width == (width - 1)) || neighbour_indexes[3] < 0) {
            if (arr[neighbour_indexes[3]]) {
                live_neighbours++;
            }
        }

        // if the right isn't at the start of the next line
        if (!(neighbour_indexes[4] % width == 0) || neighbour_indexes[4] > N) {
            if (arr[neighbour_indexes[4]]) {
                live_neighbours++;
            }
        }

        // if the bottom left isn't at the end of a line
        if (!(neighbour_indexes[5] > N || neighbour_indexes[5] % width == (width - 1))) {
            if (arr[neighbour_indexes[5]]) {
                live_neighbours++;
            }
        }

        // if the bottom one isn't out of the array
        if (neighbour_indexes[6] < N) {
            if (arr[neighbour_indexes[6]]) {
                live_neighbours++;
            }
        }

        // if the bottom right isn't at the start of a line or out of the array
        if (!(neighbour_indexes[7] > N || neighbour_indexes[7] % width == 0)) {
            if (arr[neighbour_indexes[7]]) {
                live_neighbours++;
            }
        }

        // -----------------------------------------
        

        //printf("Cell %d has %d ln \n" , i , live_neighbours);

        if (arr[i] && (live_neighbours == 2 || live_neighbours == 3)) {
            result[i] = 1;
        }else if (!arr[i] && (live_neighbours == 3))
        {
            result[i] = 1;
        }else {
            if(arr[i]) {
                result[i] = 0;
            }else if (!arr[i]) {
                result[i] = 0;
            }
        }
        
        
        
        

   }
}


cudaDeviceProp getDetails(int deviceId)
{
    cudaDeviceProp props;
    cudaGetDeviceProperties(&props, deviceId);
    return props;
}


#define multi 20
void launcher(board *mb) {

    int deviceId;
    cudaGetDevice(&deviceId);
    cudaDeviceProp props = getDetails(deviceId);

    size_t N = (mb->width * mb->height);
    size_t size = sizeof(int) * N;

    int *result;
    int *d_result;
    int *d_input;

    result = (int*)malloc(size);
    
    // allocate device memory for the maps
    cudaMalloc((void **)&d_input, size);
    cudaMalloc((void **)&d_result, size);

    cudaMemcpy(d_input, mb->arr, size, cudaMemcpyHostToDevice);


    // calculate kernel configuaration
    int threads_per_block = 512;
    //printf("number of sms :%d \n", props.multiProcessorCount);
    int number_of_blocks = props.multiProcessorCount * multi;

    //create error variables
    cudaError_t step_error;
    cudaError_t asyncErr;

    // call the kernel
    step<<<threads_per_block, number_of_blocks>>>(d_input, d_result, N, mb->width);

    // copy the data back
    cudaMemcpy(result, d_result, size, cudaMemcpyDeviceToHost);

    // check for errors
    step_error = cudaGetLastError();
    if(step_error != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(step_error));

    asyncErr = cudaDeviceSynchronize();
    if(asyncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(asyncErr));

    // create a new board and link it to the head / previous board
    board *result_board = new board(mb->width, mb->height);
    result_board->arr = result;
    result_board->position = mb->position + 1;
    
    // link backwards and forwards
    result_board->prev = mb;
    mb->next = result_board;

    // clean up
    cudaFree(d_result); cudaFree(d_input);
}