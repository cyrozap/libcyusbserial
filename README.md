# Cypress Semiconductor Corporation CyUSB Serial Library

[![LGPLv2.1+ License](http://img.shields.io/badge/license-LGPLv2.1+-blue.svg)](https://www.gnu.org/licenses/lgpl-2.1.html)
[![Travis-CI Build Status](https://travis-ci.org/cyrozap/libcyusbserial.svg?branch=master)](https://travis-ci.org/cyrozap/libcyusbserial)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/2c5g7ncuqabs4h6m/branch/master?svg=true)](https://ci.appveyor.com/project/cyrozap/libcyusbserial/branch/master)


## Pre-requisites

1. libusb 1.0.9 (or higher) is required for compilation and functioning of the
   APIs in the library.

2. GNU Make, the GCC toolchain, and CMake are used for the build process.


## Building the library and the test utility

1. Make a build directory and `cd` to it. Example: `mkdir build && cd build`

2. Run `cmake` on the source directory and then make. Example:
   `cmake ../ && make`

3. Run `sudo make install` to install the header file, libraries, and test
   utility into `PREFIX` (`/usr/local/` by default).

4. If you're on Linux, you might need to run `ldconfig` now.

5. You can now launch the application and communication with the Cypress
   USB-Serial DVK in vendor mode.


## Note
Refer to the [CyUSBSerial API documentation][1] for descriptions of all the
vendor mode APIs. The header file of the library is in
`./include/CyUSBSerial.h`.

[1]: http://www.cypress.com/?docID=45725
