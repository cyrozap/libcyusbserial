================================================================================
                      Cypress Semiconductor Corporation
                   CyUSB Serial DVK test utility for I2C/SPI
================================================================================

This utility is used for testing I2C/SPI master mode functionality on the
Cypress CyUSBSerial DVK.

The utility writes to I2C/SPI flash devices on the DVK, reads the data back
and verifies the data read for integrity.


Using the test utility:
================================================================================
1. On starting the utility, the Cypress USB Serial devices that are connected
   are listed along with their device numbers, interface numbers and
   functionalities (SPI or I2C).

   $ CyUSBSerial
   ----------------------------------------------------------------------
   Device Number | VID | PID | INTERFACE NUMBER | FUNCTIONALITY
   ----------------------------------------------------------------------
   0             |4b4  |a    | 0     | VENDOR_I2C
   0             |4b4  |a    | 1     | VENDOR_SPI
   0             |4b4  |a    | 2     | NA
   ----------------------------------------------------------------------

2. A menu providing the various operations is also printed:
   ----------------------------------------------------------------------
   1: Print list of devices
   2: Select device...No device selected !!
   3: Enter I2C/SPI Flash page address and length to write/read.
   4: Verify data
   5: Exit
   ----------------------------------------------------------------------

3. On selecting option 2, the utility prompts for the device and interface
   number to be selected for testing.

   -----------------------------------
   Enter Device number to select:
   0
   Enter interface number:
   1
   -----------------------------------

   Once the selections are made, the menu will be updated with the details.
   ----------------------------------------------------------------------
   1: Print list of devices
   2: Change device selection--selected device: [Device number 0] : [Interface No 1] : SPI
   3: Enter I2C/SPI Flash page address and length to write/read.
   4: Verify data
   5: Exit
   ----------------------------------------------------------------------

4. Option 3 can be selected now to do data read/write to the I2C/SPI flash
   device. The utility prompts for the page address to be written as well as
   the length of data to be written.

   ------------------------------------------------
   Enter Page address ... (less than 65536)
   1234
   Enter length to read/write ... (less than 256)
   32
   ------------------------------------------------

   Length needs to be less than or equal to 256 bytes in the case of SPI access,
   and less than or equal to 64 bytes in the case of I2C access. Page address
   needs to be less than 65536 in case of SPI and 256 in case of I2C.

   Once the values are selected, the menu is updated with the details as below:
   -------------------------------------------------------------------
   1: Print list of devices
   2: Change device selection--selected device: [Device number 0] : [Interface No 1] : SPI
   3: Change Flash page address and length ...Entered is page address 1234 and length 123
   4: Verify data
   5: Exit
   -------------------------------------------------------------------

5. Selecting option 4 causes the utility to write a randomly generated data
   sequence to the flash device, read it back, and verify the data read back.

   The data pattern written and read back will be displayed as shown below:
   --------------------------------------------------------------------
   67 c6 69 73 51 ff 4a ec 29 cd ba ab f2 fb e3 46 7c c2 54 f8 1b e8 e7 8d 76 5a 2e 63 33 9f c9 9a
   --------------------------------------------------------------------
   Data Read back is:
   ---------------------------------------------------------------------
   67 c6 69 73 51 ff 4a ec 29 cd ba ab f2 fb e3 46 7c c2 54 f8 1b e8 e7 8d 76 5a 2e 63 33 9f c9 9a
   ---------------------------------------------------------------------
   Data verified successfully
   -------------------------------------------------------------------

6. The utility runs through these menu options until the user selects the
   exit option (5).

================================================================================

EOF
