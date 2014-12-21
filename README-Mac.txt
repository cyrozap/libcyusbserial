========================================================================================
                      Cypress Semiconductor Corporation
                            CyUSB Serial library.
=========================================================================================

Copying/Installing Prebuilt binaries:

./bin folder of the SDK contains prebuilt binaries of libusb-1.0.9 (libusb-1.0.0.dylib) which is built
from unmodified source of libusb-1.0.9. and Cypress USB-Serial library (libcyusbserial.0.1.dylib).
Copy all the *.dylib to /usr/local/lib.
Prebuilt I2C/SPI test application is available in  ./bin/CyUSBSerialTestUtility.
Run the application from terminal for testing the communication of I2C/SPI on Cypress USB-Serial
DVk.

Refer to I2C/SPI test application in mac/testUtility folder for sample application.


*** If user wants to built the library from the source follow the instructions below.

Pre-requisite:

1. libusb-1.0.9 is required for compilation and functioning of the APIs in the library.

Installation steps:

1.Open a terminal window.

2.cd to the main directory where SDK was extracted and to mac/library.

3.Type 'sudo make' in the terminal.

3.This will generate shared library libcyusbserial.0.1.dylib and its soft link libcyusbserial.dylib,
both of them will be copied/installed to /usr/local/lib.

4.Application can link and start using the library.

Documentation:

Refer to ./common/doc/CyUSBSerial API Documentation.pdf for APIs supported in Cypress
USB-Serial vendor mode and ./common/header/CyUSBSerial.h for library header file.


