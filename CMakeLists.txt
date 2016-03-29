cmake_minimum_required(VERSION 2.8)

project(libcyusbserial C)

set(CMAKE_HELPERS_BINARY_DIR ${PROJECT_SOURCE_DIR}/cmake/helpers)
set(CMAKE_HELPERS_SOURCE_DIR ${PROJECT_SOURCE_DIR}/cmake/helpers)
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/modules)

include(FindLibUSB)

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

if(WIN32)
    find_package(LibPThreadsWin32)
    if(LIBPTHREADSWIN32_FOUND)
        set(WIN_RUNTIME_ITEMS ${WIN_RUNTIME_ITEMS}
            "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/pthreads-win32/COPYING.LIB.txt"
            "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/pthreadVC2.dll")

        add_custom_command(
            OUTPUT "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/pthreads-win32/COPYING.LIB.txt"
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${LIBPTHREADSWIN32_LIB_COPYING}"
                "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/pthreads-win32/COPYING.LIB.txt"
            COMMENT "Copying pthreads-win32 license to output directory..."
        )

        add_custom_command(
            OUTPUT "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/pthreadVC2.dll"
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${LIBPTHREADSWIN32_PATH}/dll/${LIBPTHREADSWIN32_LIBRARY_PATH_SUFFIX}/pthreadVC2.dll"
                "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/"
            COMMENT "Copying pthreadVC2.dll to output directory..."
        )
    endif(LIBPTHREADSWIN32_FOUND)

    if(LIBUSB_FOUND)
        set(WIN_RUNTIME_ITEMS ${WIN_RUNTIME_ITEMS}
            "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/libusb/COPYING"
            "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/libusb-1.0.dll")

        # The libusb Windows release does not appear to include a COPYING file.
        # Since it's LGPLv2.1, we'll copy the equivalent license from our
        # license directory
        add_custom_command(
            OUTPUT "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/libusb/COPYING.LESSER.txt"
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${CMAKE_CURRENT_SOURCE_DIR}/COPYING.LESSER.txt"
                "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/libusb/COPYING.LESSER.txt"
            COMMENT "Copying libusb license to output directory..."
        )

        add_custom_command(
            OUTPUT "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/libusb-1.0.dll"
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${LIBUSB_PATH}/${LIBUSB_LIBRARY_PATH_SUFFIX}/libusb-1.0.dll"
                "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/"
            COMMENT "Copying libusb-1.0.dll to output directory..."
        )
    endif(LIBUSB_FOUND)

    set(WIN_RUNTIME_ITEMS ${WIN_RUNTIME_ITEMS}
        "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/libcyusbserial/COPYING.LESSER.txt"
    )

    add_custom_command(
        OUTPUT "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/libcyusbserial/COPYING.LESSER.txt"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${CMAKE_CURRENT_SOURCE_DIR}/../COPYING"
            "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/licenses/libcyusbserial/COPYING.LESSER.txt"
        COMMENT "Copying libcyusbserial COPYING.LESSER.txt file to output directory..."
    )
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
