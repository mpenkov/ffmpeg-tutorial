#
# http://www.gnu.org/software/make/manual/make.html
#

# You can choose to use libswresample (This is what macports provides)
# FFMPEG_RESAMPLE=-D__RESAMPLER__ -D__LIBSWRESAMPLE__
# FFMPEG_PKGCONFIG_RESAMPLE=libswresample

# Or you can use libavresample which is better
FFMPEG_RESAMPLE=-D__RESAMPLER__ -D__LIBAVRESAMPLE__
FFMPEG_PKGCONFIG_RESAMPLE=libavresample

CC:=gcc
INCLUDES:=$(shell pkg-config --cflags libavformat libavcodec libswscale libavutil $(FFMPEG_PKGCONFIG_RESAMPLE) sdl)
CFLAGS:=-Wall -ggdb $(FFMPEG_RESAMPLE) -std=c99
LDFLAGS:=$(shell pkg-config --libs libavformat libavcodec libswscale libavutil $(FFMPEG_PKGCONFIG_RESAMPLE) sdl) -lm
EXE:=tutorial01.out tutorial02.out tutorial03.out tutorial04.out\
	tutorial05.out tutorial06.out tutorial07.out

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

bin/%.out: obj/%.o
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@

obj/%.o : %.c
	$(CC) $(CFLAGS) $< $(INCLUDES) -c -o $@

clean:
	rm -f obj/*
	rm -f bin/*
	rm -f tags

