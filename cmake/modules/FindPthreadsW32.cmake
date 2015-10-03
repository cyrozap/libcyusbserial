# This file finds pthreads-w32 on Windows

if(DEFINED __INCLUDED_LIBCYUSBSERIAL_FINDPTHREADS_CMAKE)
    return()
endif()
set(__INCLUDED_LIBCYUSBSERIAL_FINDPTHREADS_CMAKE TRUE)

include(CheckLibraryExists)
include(CheckIncludeFile)

# Windows only
if(WIN32)
    set(PTHREADS_PATH
        "C:/Program Files/pthreads-w32/prebuilt-dll-2-9-1-release/"
        CACHE
        PATH
        "Path to pthreads-w32 files."
    )

    if(CMAKE_CL_64)
        set(PTHREADS_LIBRARY_PATH_SUFFIX dll/x64)
    else(CMAKE_CL_64)
        set(PTHREADS_LIBRARY_PATH_SUFFIX dll/x86)
    endif(CMAKE_CL_64)

    find_file(PTHREADS_HEADER_FILE
        NAMES
        pthread.h
        PATHS
        ${PTHREADS_PATH}
        PATH_SUFFIXES
        include
        )
    mark_as_advanced(PTHREADS_HEADER_FILE)
    get_filename_component(PTHREADS_INCLUDE_DIRS "${PTHREADS_HEADER_FILE}" PATH)

    find_library(pthread_LIBRARY
        NAMES
        pthreadVC2
        PATHS
        ${PTHREADS_PATH}
        PATH_SUFFIXES
        ${PTHREADS_LIBRARY_PATH_SUFFIX}
        )
    mark_as_advanced(pthread_LIBRARY)
    if(pthread_LIBRARY)
        set(PTHREADS_LIBRARIES ${pthread_LIBRARY})
    endif(pthread_LIBRARY)

    message(STATUS "Checking for pthreads-w32...")
    message(AUTHOR_WARNING ${PTHREADS_INCLUDE_DIRS})
    message(AUTHOR_WARNING ${PTHREADS_LIBRARIES})
    if(PTHREADS_INCLUDE_DIRS AND PTHREADS_LIBRARIES)
        message(STATUS "pthreads-w32 found")
        set(CMAKE_REQUIRED_INCLUDES "${PTHREADS_INCLUDE_DIRS}")
        check_include_file("{PTHREADS_HEADER_FILE}" PTHREADS_FOUND)
    else(PTHREADS_INCLUDE_DIRS AND PTHREADS_LIBRARIES)
        message(SEND_ERROR "pthreads-w32 not found!")
    endif(PTHREADS_INCLUDE_DIRS AND PTHREADS_LIBRARIES)
endif()
