CC ?= gcc

TARGET = cyusbserialtest

CFLAGS += -g -Wall
LDFLAGS += -lcyusbserial

all: $(TARGET)

%: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

clean:
	rm -f $(TARGET)

.PHONY: all clean
