cmake_minimum_required(VERSION 3.10)
project(MatrixMultiplication)

find_package(MPI REQUIRED)
include_directories(${MPI_INCLUDE_PATH})

include_directories(include)

add_subdirectory(googletest)
include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

# Aggiungi la libreria matrix_multiplication
add_library(matrix_multiplication_without_errors STATIC src/matrix_mult.cpp)

# Definisci l'eseguibile principale
add_executable(main src/main.cpp)
target_link_libraries(main ${MPI_LIBRARIES} matrix_multiplication_without_errors)

# Definisci l'eseguibile di test
add_executable(test_multiplication test/test_matrix_multiplication.cpp)
target_link_libraries(test_multiplication gtest gtest_main matrix_multiplication_without_errors ${MPI_LIBRARIES})

if (MPI_COMPILE_FLAGS)
  set_target_properties(main PROPERTIES COMPILE_FLAGS "${MPI_COMPILE_FLAGS}")
  set_target_properties(test_multiplication PROPERTIES COMPILE_FLAGS "${MPI_COMPILE_FLAGS}")
endif ()

if (MPI_LINK_FLAGS)
  set_target_properties(main PROPERTIES LINK_FLAGS "${MPI_LINK_FLAGS}")
  set_target_properties(test_multiplication PROPERTIES LINK_FLAGS "${MPI_LINK_FLAGS}")
endif ()

enable_testing()

include(GoogleTest)
gtest_discover_tests(test_multiplication)
