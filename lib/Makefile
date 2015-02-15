CC ?= gcc

TARGET = libcyusbserial

SOURCES := cyusb.c cyuart.c cyi2c.c cyspi.c cyphdc.c cyjtag.c cymisc.c

PREFIX = /usr/local

OBJECTS = $(SOURCES:.c=.o)

UNAME_S := $(shell uname -s)

CFLAGS += -Wall -fPIC
ifeq ($(UNAME_S), Linux)
	CFLAGS += -g
endif

INCLUDES += $(shell pkg-config --cflags libusb-1.0)
LIBS += $(shell pkg-config --libs libusb-1.0)

all: $(TARGET)

$(TARGET): $(OBJECTS)
ifeq ($(UNAME_S), Linux)
	$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDES) -shared -g -Wl,-soname,$@.so -o $@.so.1 $^ $(LIBS)
endif
ifeq ($(UNAME_S), Darwin)
	$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDES) -dynamiclib -o $@.0.1.dylib $^ $(LIBS)
endif

%.o: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ -c $<

install: $(TARGET)
ifeq ($(UNAME_S), Linux)
	cp libcyusbserial.so.1 $(PREFIX)/lib
	ln -sf $(PREFIX)/lib/libcyusbserial.so.1 $(PREFIX)/lib/libcyusbserial.so
	ldconfig
endif
ifeq ($(UNAME_S), Darwin)
	cp libcyusbserial.0.1.dylib $(PREFIX)/lib
	ln -sf $(PREFIX)/lib/libcyusbserial.0.1.dylib $(PREFIX)/lib/libcyusbserial.dylib
endif

clean:
ifeq ($(UNAME_S), Linux)
	rm -f $(TARGET).so $(TARGET).so.1 $(OBJECTS)
endif
ifeq ($(UNAME_S), Darwin)
	rm -f $(TARGET).0.1.dylib $(OBJECTS)
endif

.PHONY: all clean install
