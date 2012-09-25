ffmpeg-tutorial
===============

This repository contains files from an FFmpeg tutorial originally written by
Stephen Dranger (dranger@gmail.com).  The files have been updated to work with
the most recent version of FFmpeg (N-42806-gf4451d2 at the time of writing).
The updates were performed with an effort to modify as little code as possible,
so that the original code and tutorial descriptions could be easily consulted.

The code from the original tutorial and the accompanying description is located
[here](http://dranger.com/ffmpeg/).

Main changes:
-------------

* Renamed includes, e.g. ffmpeg/avcodec.h --> libavcodec/avcodec.h
* Work around deprecated functions and symbols (see below)
* Initializing pointers to NULL on declaration.  Some FFmpeg functions
  (e.g. avformat_open_input) now segfault when given uninitialized pointers as
  input.
* Removed tutorial08.c, which introduced software scaling (as
  opposed to using the img_convert method).  img_convert has been deprecated
  and is no longer available, so these new tutorials use software scaling
  from the very beginning, and a separate tutorial is not necessary.

Deprecated Functions and Symbols
--------------------------------

This section describes the changes made to work around deprecated functions
and symbols, in the format: before --> after.  In some cases, a simple rename
sufficed (e.g. dump_format), but in others, more significant changes to the
code were required (e.g. avcodec_decode_audio2).  Consult the diffs for each
respective tutorial to see exactly what has changed since the original 
version of the tutorial.

* av_open_input_file --> avformat_open_input
* av_find_stream_info --> avformat_find_stream_info
* dump_format --> av_dump_format
* CODEC_TYPE_VIDEO --> AVMEDIA_TYPE_VIDEO
* avcodec_open --> avcodec_open2
* avcodec_decode_video --> avcodec_decode_video2
* img_convert --> sws_scale
* av_close_input_file --> avformat_close_input
* avcodec_decode_audio2 --> avcodec_decode_audio4
* CODEC_TYPE_AUDIO --> AVMEDIA_TYPE_AUDIO
* url_set_interrupt_cb --> avio_open2
* url_ferror --> check attribute is->pFormatCtx->pb->error
* pstrcpy --> av_strlcpy

Building and Running
--------------------

First, make sure you have a recent installation of FFmpeg.  It's recommended
that you build FFmpeg from source as described in 
[this link](https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide).

To build the tutorials:

    cd ffmpeg-tutorial
    make

To run a tutorial:

    bin/tutorial01.out