#!/bin/sh

rm -rf build
cmake -S . -B build
cmake --build build
cmake --install build --prefix $HOME/nom

rm -rf build
echo "microbenchmark is compiled on $PWD/example/"

echo "To run the microbenchmakr use mpirun -np X ./executable_file"
