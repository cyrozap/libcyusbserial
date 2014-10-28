all:
	gcc -fPIC -g -Wall -o libcyusb.o -c cyusb.c -I ../../common/header
	gcc -fPIC -g -Wall -o libcyuart.o -c cyuart.c -I ../../common/header
	gcc -fPIC -g -Wall -o libcyi2c.o -c cyi2c.c -I ../../common/header
	gcc -fPIC -g -Wall -o libcyspi.o -c cyspi.c -I ../../common/header
	gcc -fPIC -g -Wall -o libcyphdc.o -c cyphdc.c -I ../../common/header
	gcc -fPIC -g -Wall -o libcyjtag.o -c cyjtag.c -I ../../common/header
	gcc -fPIC -g -Wall -o libcymisc.o -c cymisc.c -I ../../common/header
	gcc -shared -g -Wl,-soname,libcyusbserial.so -o libcyusbserial.so.1 libcyusb.o libcyuart.o libcyi2c.o libcyspi.o libcyphdc.o libcyjtag.o libcymisc.o -l usb-1.0
	cp libcyusbserial.so.1 /usr/local/lib
	ln -sf /usr/local/lib/libcyusbserial.so.1 /usr/local/lib/libcyusbserial.so
	ldconfig
	rm -f libcyusb.o libcyuart.o libcyspi.o libcyi2c.o libcyphdc.o libcyjtag.o libcymisc.o
clean:
	rm -f libcyusbserial.so libcyusbserial.so.1
help:
	@echo	'make		would compile and create the library and create a link'
	@echo	'make clean	would remove the library and the soft link to the library (soname)'
