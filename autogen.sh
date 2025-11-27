#!/bin/sh

cd build/
cmake ..
make 
cd ..

echo "microbenchmark is compiled on $PWD/example/"

echo "To run the microbenchmakr use mpirun -np X ./executable_file"
