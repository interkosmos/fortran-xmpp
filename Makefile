.POSIX:
.SUFFIXES:

FC      = gfortran
CC      = gcc
AR      = ar
MAKE    = make
PREFIX  = /usr

DEBUG   = -std=f2018 -g -O0 -Wall -fmax-errors=1
RELEASE = -std=f2018 -O2

FFLAGS  = $(RELEASE)
CFLAGS  = -O2
LDFLAGS = -I$(PREFIX)/include -L$(PREFIX)/lib
LDLIBS  = -lstrophe -lexpat -lssl -lcrypto -lz
ARFLAGS = rcs
INCDIR  = $(PREFIX)/include/libfortran-xmpp
LIBDIR  = $(PREFIX)/lib
SRC     = src/xmpp.f90 src/xmpp_macro.c src/xmpp_util.f90
OBJ     = xmpp.o xmpp_macro.o xmpp_util.o
MOD     = xmpp.mod xmpp_util.mod
TARGET  = ./libfortran-xmpp.a

.PHONY: all clean debug examples install

all: $(TARGET)

examples: basic roster

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) -c src/xmpp_macro.c
	$(FC) $(FFLAGS) $(LDFLAGS) -c src/xmpp_util.f90
	$(FC) $(FFLAGS) $(LDFLAGS) -c src/xmpp.f90
	$(AR) $(ARFLAGS) $(TARGET) $(OBJ)

debug: $(SRC)
	$(MAKE) FFLAGS="$(DEBUG)"

basic: $(TARGET) examples/basic.f90
	$(FC) $(FFLAGS) $(LDFLAGS) -o basic examples/basic.f90 $(TARGET) $(LDLIBS)

roster: $(TARGET) examples/roster.f90
	$(FC) $(FFLAGS) $(LDFLAGS) -o roster examples/roster.f90 $(TARGET) $(LDLIBS)

install: $(TARGET)
	@echo "--- Installing library to $(LIBDIR)/ ..."
	install -d $(LIBDIR)
	install -m 644 $(TARGET) $(LIBDIR)/
	@echo "--- Installing modules to $(INCDIR)/ ..."
	install -d $(INCDIR)
	install -m 644 $(MOD) $(INCDIR)/

clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e $(TARGET) ]; then rm $(TARGET); fi
	if [ -e basic ]; then rm basic; fi
	if [ -e roster ]; then rm roster; fi
