cmake_minimum_required(VERSION 3.15)
project(LRCs)

add_subdirectory(third_party/pybind11)
set(simulator_source
        pybind_cpp/interface.cpp
        pybind_cpp/interface.h
        pybind_cpp/pybind.cpp)
pybind11_add_module(Code_parameters ${simulator_source})

set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_FLAGS "-g -Wall -DASIO_STANDALONE")
set(CMAKE_CXX_FLAGS "-g -Wall -std=c++11 -DASIO_STANDALONE")
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third_party/gf-complete/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third_party/jerasure/include/jerasure)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third_party/jerasure/include)

link_directories(${CMAKE_CURRENT_SOURCE_DIR}/third_party/jerasure/lib)
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/third_party/gf-complete/lib)



aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/src/   PROJECT_SRC)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/include/   PROJECT_SRC)
#echo PROJECT_SRC
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR}/include/metadefinition.h   PROJECT_SRC1)
# message(${PROJECT_SRC1}) 

foreach (_target
        test_tools)
    add_executable(${_target}            
            ${CMAKE_CURRENT_SOURCE_DIR}/${_target}.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/src/Azure_LRC_1.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/src/Azure_LRC.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/src/General.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/src/Optimal_LRC.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/src/Xorbas.cpp
            )
    target_link_libraries(${_target}
            -lJerasure -lgf_complete
            )
endforeach ()


add_library(utils SHARED ${PROJECT_SRC})

set_target_properties(utils PROPERTIES output_name "utils")

target_compile_definitions(Code_parameters
                           PRIVATE VERSION_INFO=${EXAMPLE_VERSION_INFO})
set(Jerasurelib ${CMAKE_CURRENT_SOURCE_DIR}/third_party/jerasure/lib/libJerasure.so)
set(gf_completelib ${CMAKE_CURRENT_SOURCE_DIR}/third_party/gf-complete/lib/libgf_complete.so)

target_link_libraries(Code_parameters
PRIVATE
${Jerasurelib} ${gf_completelib} utils
)

