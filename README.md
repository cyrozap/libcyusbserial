# Cypress Semiconductor Corporation CyUSB Serial Library

[![Build Status](https://travis-ci.org/cyrozap/libcyusbserial.svg?branch=master)](https://travis-ci.org/cyrozap/libcyusbserial)

## Pre-requisites

1. libusb 1.0.9 (or higher) is required for compilation and functioning of the
   APIs in the library.

2. GNU Make, the GCC toolchain, and CMake are used for the build process.


## Building the library and the test utility

1. Make a build directory and `cd` to it. Example: `mkdir build && cd !$`

2. Run `cmake` on the source directory and then make. Example:
   `cmake ../ && make`

3. This will generate the shared library `libcyusbserial.so.1`
   (`libcyusbserial.0.1.dylib` on OS X) and its soft link `libcyusbserial.so`
   (`libcyusbserial.dylib` on OS X).

4. Run `sudo make install` to install the header file, libraries, and test
   utility into `PREFIX` (`/usr/local/` by default).

5. You might need to run `ldconfig` now.

6. User can launch the application and test the communication with Cypress
   USB-Serial DVK in vendor mode.


## Note
Refer to the [CyUSBSerial API documentation][1] for descriptions of all the
vendor mode APIs. The header file of the library is in
`./include/CyUSBSerial.h`.

[1]: http://www.cypress.com/?docID=45725
