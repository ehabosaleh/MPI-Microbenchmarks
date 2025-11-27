cmake_minimum_required(VERSION 3.15)
project(Neighbor-Overlap-Microbenchmark C)

find_package(MPI REQUIRED)

add_library(nom STATIC
  src/nom.c
  src/grid.c
  src/compute.c
)

target_include_directories(nom
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_compile_features(nom PUBLIC c_std_11)
target_compile_options(nom PRIVATE -O3 -Wall -Wextra -Wno-unused-parameter -pthread -fPIC)
target_link_libraries(nom PUBLIC MPI::MPI_C pthread m)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/examples")

add_executable(neighbor-overlap-microbenchmark examples/main.c)
target_link_libraries(neighbor-overlap-microbenchmark nom)

