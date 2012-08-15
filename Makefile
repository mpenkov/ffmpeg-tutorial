#
# http://www.gnu.org/software/make/manual/make.html
#
CC=gcc
INCLUDES=`pkg-config --cflags libavcodec libavformat libavutil libswscale sdl opencv`
#
# -Wno-unused is to get rid of lots of warnings from within OpenCV source.
# I can't really do much more about them.
#
CFLAGS=-Wall -ggdb $(INCLUDES) -Wno-write-strings -Wno-unused
LDFLAGS=`pkg-config --libs libavcodec libavformat libavutil libswscale sdl opencv` -lm
EXE=tutorial01.out tutorial02.out tutorial03.out tutorial04.out\
	tutorial05.out tutorial06.out tutorial07.out
SRC=
OBJ=$(patsubst %.c,obj/%.o,$(SRC))

#
# This is here to prevent Make from deleting secondary files.
#
.SECONDARY:
	

#
# $< is the first dependency in the dependency list
# $@ is the target name
#
all: dirs $(addprefix bin/, $(EXE)) tags

dirs:
	mkdir -p obj
	mkdir -p bin

tags: *.c
	ctags *.c

bin/%.out: obj/%.o $(OBJ)
	$(CC) $(CFLAGS) $(INCLUDES) $(LDFLAGS) $< $(OBJ) -o $@

obj/%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f obj/*
	rm -f bin/*
	rm -f tags
