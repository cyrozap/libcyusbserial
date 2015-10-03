cmake_minimum_required(VERSION 2.8)

project(libcyusbserial C)

set(CMAKE_HELPERS_BINARY_DIR ${PROJECT_SOURCE_DIR}/cmake/helpers)
set(CMAKE_HELPERS_SOURCE_DIR ${PROJECT_SOURCE_DIR}/cmake/helpers)
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/modules)

include(FindLibUSB)
if(WIN32)
    include(FindLibPThreadsWin32)
endif()

################################################################################
# System configuration
################################################################################

# OSX
if(APPLE)
    set(CMAKE_MACOSX_RPATH ON)
    set(CMAKE_SKIP_BUILD_RPATH FALSE)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
    list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
    if(${isSystemDir} STREQUAL "-1")
        set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
    endif()
endif()

################################################################################
# GCC and Clang
################################################################################
if(CMAKE_C_COMPILER_ID STREQUAL "GNU" OR
   CMAKE_C_COMPILER_ID STREQUAL "Clang")

    add_definitions(-Wall)
    add_definitions(-Wextra)
    add_definitions(-Wno-unused-parameter)

    if(TREAT_WARNINGS_AS_ERRORS)
        add_definitions(-Werror)
    endif()

    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_definitions(-DDEBUG=1)
        add_definitions(-O0)
    endif(CMAKE_BUILD_TYPE STREQUAL "Debug")

endif(CMAKE_C_COMPILER_ID STREQUAL "GNU" OR
      CMAKE_C_COMPILER_ID STREQUAL "Clang")

################################################################################
# Process subdirectories
################################################################################
include_directories(${PROJECT_SOURCE_DIR}/include)
add_subdirectory(include)
add_subdirectory(lib)
add_subdirectory(tools)
