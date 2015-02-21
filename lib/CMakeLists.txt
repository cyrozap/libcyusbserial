set(VERSION_INFO_MAJOR  0)
set(VERSION_INFO_MINOR  1)
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

target_link_libraries(cyusbserial ${LIBUSB_LIBRARIES})

set_target_properties(cyusbserial PROPERTIES SOVERSION ${VERSION_INFO_MAJOR})

################################################################################
# Library installation information
################################################################################
install(TARGETS cyusbserial
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} # .so/.dylib
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} # .a/.lib
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR} # .dll
)
