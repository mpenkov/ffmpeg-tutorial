ffmpeg-tutorial
===============

This repository is fork from original repo

* https://github.com/chelyaev/ffmpeg-tutorial

Mainly because there is audio broken and code is not keep in shape in order
to maintain maximum compatibility to tutorial

In Makefile there is possibility to use libavresample or libswresample which
you have installed is not auto detected! They are under run time which

Use libavresampler in gcc: -D\_\_RESAMPLER\_\_ -D\_\_LIBAVRESAMPLE\_\_
Use libswresampler in gcc: -D\_\_RESAMPLER\_\_ -D\_\_LIBSWRESAMPLE\_\_

all the magic happens in function

int audio_tutorial_resample(VideoState *is, struct AVFrame *inframe)

that you feed original frame in and it'll convert it it to what you want

* FLTP is 32-bit Float Planar (Ogg/Vorbis, OPUS, MP4, WMA and many more) 
* S16P is Stereo 16-bit Planar (MP3, MPEG2 and MPEG1)
* S16 is SDL output format that is not planar

Planar means if I get it right
<pre>
Right--------------------
RRRRRRRRRRRRRRRRRRRRRRRRR
Left---------------------
LLLLLLLLLLLLLLLLLLLLLLLLL
-------------------------
</pre>

So you samples are in order that first there is right channel and after that there
is left channel in package. In case of normal PCM S16 you have

<pre>
Right/Left--------------
RRLLRRLLRRLLRRLLRRLLRRLL
------------------------
</pre>

That's why audio sound so strange without resample and if it is float are thing totally
differently from this.

Mainly this repository contains files from an FFmpeg tutorial originally written by
Stephen Dranger (dranger@gmail.com).  The files have been updated to work with
the most recent version of FFmpeg (see VERSION.txt for the most recent version 
at the time of writing).
The updates were performed with an effort to modify as little code as possible,
so that the original code and tutorial descriptions could be easily consulted.

The code from the original tutorial and the accompanying description is located
[here](http://dranger.com/ffmpeg/).

Main changes
------------

* Added stuff to resample audio to correct output so it really works
* Renamed includes, e.g. ffmpeg/avcodec.h --> libavcodec/avcodec.h
* Work around deprecated functions and symbols (see below)
* Initializing pointers to NULL on declaration.  Some FFmpeg functions
  (e.g. avformat\_open\_input) now segfault when given uninitialized pointers as
  input.
* Removed tutorial08.c, which introduced software scaling (as
  opposed to using the img\_convert method).  img\_convert has been deprecated
  and is no longer available, so these new tutorials use software scaling
  from the very beginning, and a separate tutorial is not necessary.

Deprecated Functions and Symbols
--------------------------------

This section describes the changes made to work around deprecated functions
and symbols, in the format: before --> after.  In some cases, a simple rename
sufficed (e.g. dump\_format), but in others, more significant changes to the
code were required (e.g. avcodec\_decode\_audio2).  Consult the diffs for each
respective tutorial to see exactly what has changed since the original 
version of the tutorial.

* av\_open\_input\_file --> avformat\_open\_input
* av\_find\_stream\_info --> avformat\_find\_stream\_info
* dump\_format --> av\_dump\_format
* CODEC\_TYPE\_VIDEO --> AVMEDIA\_TYPE\_VIDEO
* avcodec\_open --> avcodec\_open2
* avcodec\_decode\_video --> avcodec\_decode\_video2
* img\_convert --> sws\_scale
* av\_close\_input\_file --> avformat\_close\_input
* avcodec\_decode\_audio2 --> avcodec\_decode\_audio4
* CODEC\_TYPE\_AUDIO --> AVMEDIA\_TYPE\_AUDIO
* url\_set\_interrupt\_cb --> avio\_open2
* url\_ferror --> check attribute is->pFormatCtx->pb->error
* pstrcpy --> av\_strlcpy

Building and Running
--------------------

You should have at least FFMPEG 1.0 installed. This is tested with and should work.
If you have FFMPEG 2.0 or higher installed you can use Resampler code. Those libraries
are also with pre FFMPEG 1.0 but they won't necessary work as expected.

Ubuntu/Debian (Mint also) have preset of using libav (avconv) and it should work but the will be some
minor and major difference's in quality so it's recommended that you build FFmpeg
from source as described in 
[this link](https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide).

To build the tutorials:

    git clone https://github.com/illuusio/ffmpeg-tutorial.git
    cd ffmpeg-tutorial
    make

To run a tutorial, first make sure that your ffmpeg installation is on your
$LD\_LIBRARY\_PATH and then:

    bin/tutorial01.out audio/videofile
