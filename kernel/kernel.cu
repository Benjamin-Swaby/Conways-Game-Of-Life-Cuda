#include "board.h"

using namespace cgol;

__global__ void step(int *arr, int *result, size_t N, int width) {
    int index =  blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

   for(int i = index; i < N; i += stride)
   {
       
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
    printf("number of sms :%d \n", props.multiProcessorCount);
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

    // clean up
    cudaFree(d_result); cudaFree(d_input);
    free(result);
}