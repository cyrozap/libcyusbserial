add_executable(cyusbserialtest cyusbserialtest.c)

################################################################################
# Version information
################################################################################

set(VERSION_INFO_MAJOR  0)
set(VERSION_INFO_MINOR  0)
set(VERSION_INFO_PATCH  1)

################################################################################
# Link libraries
################################################################################
target_link_libraries(cyusbserialtest LINK_PUBLIC cyusbserial)

################################################################################
# Installation
################################################################################
if(NOT DEFINED BIN_INSTALL_DIR)
    set(BIN_INSTALL_DIR bin)
endif()

install(TARGETS cyusbserialtest DESTINATION ${BIN_INSTALL_DIR})
