set(VERSION_INFO_MAJOR  1)
set(VERSION_INFO_MINOR  0)
set(VERSION_INFO_PATCH  0)

include(GNUInstallDirs)

set(LIBCYUSBSERIAL_SOURCE cyusb.c cyuart.c cyi2c.c cyspi.c cyphdc.c cyjtag.c cymisc.c)

# Fall back to just "lib" if the item provided by GNUInstallDirs doesn't exist
# For example, on Ubuntu 13.10 with CMake 2.8.11.2,
# /usr/lib/${CMAKE_LIBRARY_ARCHITECTURE} doesn't exist.
if (NOT EXISTS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
    message(STATUS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR} does not exist. Defaulting libcyusbserial install location to ${CMAKE_INSTALL_PREFIX}/lib.")
        set(CMAKE_INSTALL_LIBDIR lib)
endif()

add_library(cyusbserial SHARED ${LIBCYUSBSERIAL_SOURCE})


################################################################################
# Include paths
################################################################################
set(LIBCYUSBSERIAL_INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}/../include
)


################################################################################
# Build dependencies
################################################################################
if(MSVC)
    set(LIBCYUSBSERIAL_INCLUDES ${LIBCYUSBSERIAL_INCLUDES} ${MSVC_C99_INCLUDES})

    find_package(LibPThreadsWin32 REQUIRED)
    if(LIBPTHREADSWIN32_FOUND)
        set(HAVE_THREADS true)
        set(LIBCYUSBSERIAL_INCLUDES
        ${LIBCYUSBSERIAL_INCLUDES} ${LIBPTHREADSWIN32_INCLUDE_DIRS})
        set(LIBCYUSBSERIAL_LIBS
        ${LIBCYUSBSERIAL_LIBS} ${LIBPTHREADSWIN32_LIBRARIES})
    else()
        set(HAVE_THREADS false)
    endif()
else(MSVC)
    find_package(Threads REQUIRED)
    if(Threads_FOUND)
        set(HAVE_THREADS true)
    else()
        set(HAVE_THREADS false)
    endif()
endif(MSVC)

if (NOT HAVE_THREADS)
    message(FATAL_ERROR "pthreads not found. This is required to build libcyusbserial.")
endif()

if(NOT LIBUSB_FOUND)
    message(FATAL_ERROR "libusb-1.0 not found. This is required to use the libcyusbserial libusb backend. For binary releases, try setting LIBUSB_PATH.")
else(NOT LIBUSB_FOUND)
    if(LIBUSB_VERSION)
        if(NOT LIBUSB_VERSION VERSION_LESS "1.0.10")
            add_definitions(-DHAVE_LIBUSB_GET_VERSION)
        endif()

        if(WIN32)
            # We require v1.0.19 because it provides Windows 8 USB 3.0
            # speed detection fixes, additional AMD/Intel USB 3.0 root
            # hub support, and some fixes to issues reported on v1.0.18
            # that yielded corrupted samples.
            if(${LIBUSB_VERSION} VERSION_LESS "1.0.19")
                message(FATAL_ERROR "libusb v1.0.19 is required in Windows.\n"
                                    "Please update libusb or consider using the Cypress backend if this is not possible.\n"
                                    "Detected version: ${LIBUSB_VERSION}\n")
            endif()
        elseif(APPLE)
            # A number of important changes were included in libusb
            # v1.0.16 hrough v1.0.18, including SuperSpeed support, 64-bit support,
            # and various build and crash fixes.
            if(${LIBUSB_VERSION} VERSION_LESS "1.0.18")
                message(FATAL_ERROR "libusb v1.0.18 is required in OS X. Please update libusb."
                                    "Detected version: ${LIBUSB_VERSION}\n")
            endif()
        elseif(UNIX)
            # A number of reported issues supposedly became resolved after
            # updating to >= 1.0.16.
            if(${LIBUSB_VERSION} VERSION_LESS "1.0.16")
                message(WARNING "\nlibusb >= 1.0.16 is HIGHLY recommended. "
                                "If you experience issues or poor performance, please try updating libusb.\n"
                                "Detected version: ${LIBUSB_VERSION}")
            endif()
        else()
            message(WARNING "Unexpected system type. Please report this warning to developers.")
        endif()
    else()
        message(WARNING "Not checking libcyusbserial/libusb compatibility because LIBUSB_VERSION is not defined.")
    endif()
    set(LIBCYUSBSERIAL_INCLUDES ${LIBCYUSBSERIAL_INCLUDES} ${LIBUSB_INCLUDE_DIRS})
endif(NOT LIBUSB_FOUND)

if(MSVC)
    set(LIBCYUSBSERIAL_INCLUDES ${LIBCYUSBSERIAL_INCLUDES}
        ${LIBPTHREADSWIN32_INCLUDE_DIRS})
endif()

include_directories(${LIBCYUSBSERIAL_INCLUDES})


################################################################################
# Build configuration
################################################################################

if(MSVC)
    set(LIBCYUSBSERIAL_LIBS ${LIBCYUSBSERIAL_LIBS} ${LIBPTHREADSWIN32_LIBRARIES})
else()
    set(LIBCYUSBSERIAL_LIBS ${LIBCYUSBSERIAL_LIBS} ${CMAKE_THREAD_LIBS_INIT})
endif(MSVC)

set(LIBCYUSBSERIAL_LIBS ${LIBCYUSBSERIAL_LIBS} ${LIBUSB_LIBRARIES})

target_link_libraries(cyusbserial ${LIBCYUSBSERIAL_LIBS})

# Set shared library version
set_target_properties(cyusbserial PROPERTIES SOVERSION ${VERSION_INFO_MAJOR})


################################################################################
# Library installation information
################################################################################
install(TARGETS cyusbserial
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} # .so/.dylib
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} # .a/.lib
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR} # .dll
)
