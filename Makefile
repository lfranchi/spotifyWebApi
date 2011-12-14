TARGET=spshell
LDLIBS += -ljansson -lmysqlclient -lpthread -lrt
CFLAGs += -Werror


$(TARGET): spshell.o spshell_posix.o appkey.o toplist.o cmd.o browse.o playlist.o search.o mysql.o
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $^ -o $@

# Copyright (c) 2010 Spotify Ltd

all:	check-libspotify $(TARGET)

#
# Direct path to libspotify
#
ifdef LIBSPOTIFY_PATH

P=$(shell cd "$(LIBSPOTIFY_PATH)" && pwd)

check-libspotify:
	@test -f $(P)/lib/libspotify.so || (echo "Failed to find libspotify.so in $(P)/lib" >&2 ; exit 1)
	@test -f $(P)/include/libspotify/api.h || (echo "Failed to find libspotify/api.h in $(P)/include" >&2 ; exit 1)

CFLAGS  += -I$(P)/include
LDFLAGS += -Wl,-rpath,$(P)/lib -L$(P)/lib
LDLIBS  += -lspotify


#
# Use pkg-config(1)
#
else

check-libspotify:
	@pkg-config --exists libspotify || (echo "Failed to find libspotify using pkg-config(1)" >&2 ; exit 1)

CFLAGS  += $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --cflags libspotify)
LDFLAGS += $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --libs-only-L libspotify)
LDLIBS  += $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --libs-only-l --libs-only-other libspotify)

endif

ifdef DEBUG
CFLAGS += -ggdb -O0
endif

CFLAGS += -Wall

.PHONY: all check-libspotify clean

vpath %.c ../

clean:
	rm -f *.o *~ $(TARGET)

