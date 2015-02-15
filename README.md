# Cypress Semiconductor Corporation CyUSB Serial Library

[![Build Status](https://travis-ci.org/cyrozap/libcyusbserial.svg?branch=master)](https://travis-ci.org/cyrozap/libcyusbserial)

## Pre-requisites

1. libusb 1.0.9 (or higher) is required for compilation and functioning of the
   APIs in the library.

2. GNU Make and the GCC toolchain are used for the build process.


## Building the library and the test utility

1. `cd` to the main directory where the library source files are extracted and
   go to `./lib`.

2. Run `make`.

3. This will generate shared library `libcyusbserial.so.1`
   (`libcyusbserial.0.1.dylib` on OS X) and its soft link `libcyusbserial.so`
   (`libcyusbserial.dylib` on OS X).

4. Run `sudo make install` to install the libraries into `PREFIX`
   (`/usr/local/lib` by default).

5. Go to `./tools` (I2C/SPI test utility program) and run `make`. This will
   generate the `cyusbserialtest` binary.

6. User can launch the application and test the communication with Cypress
   USB-Serial DVK in vendor mode.


## Note
Refer to the [CyUSBSerial API documentation][1] for descriptions of all the
vendor mode APIs. The header file of the library is in
`./include/CyUSBSerial.h`.

[1]: http://www.cypress.com/?docID=45725
