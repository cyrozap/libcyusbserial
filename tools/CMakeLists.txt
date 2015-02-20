add_executable(cyusbserialtest cyusbserialtest.c)

target_link_libraries(cyusbserialtest LINK_PUBLIC cyusbserial)

################################################################################
# Installation
################################################################################
if(NOT DEFINED BIN_INSTALL_DIR)
    set(BIN_INSTALL_DIR bin)
endif()

install(TARGETS cyusbserialtest DESTINATION ${BIN_INSTALL_DIR})
