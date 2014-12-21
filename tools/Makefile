CC = gcc

TARGETS = cyusbserialtest

CFLAGS += -g -Wall
LDFLAGS += -lcyusbserial

all: $(TARGETS)

%: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

clean:
	rm -f $(TARGETS)

.PHONY: all clean
