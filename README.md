ffmpeg-tutorial
===============

This repository contains files from an FFmpeg tutorial originally written
by Stephen Dranger.  The files have been updated to work with the most
recent version of FFmpeg (N-42806-gf4451d2 at the time of writing).  The
original tutorial is located (here)[http://dranger.com/ffmpeg/].

Main changes:

* Renamed includes, e.g. ffmpeg/avcodec.h --> libavcodec/avcodec.h
* Work around deprecated functions and symbols (see below)
* Initializing pointers to NULL on declaration.  Some FFmpeg functions
  (e.g. avformat_open_input) segfault when given uninitialized pointers 
  as input.

Deprecated functions and symbols
--------------------------------

before --> after

* av_open_input_file --> avformat_open_input
* av_find_stream_info --> avformat_find_stream_info
* dump_format --> av_dump_format
* CODEC_TYPE_VIDEO --> AVMEDIA_TYPE_VIDEO
* avcodec_open --> avcodec_open2
* avcodec_decode_video --> avcodec_decode_video2
* img_convert --> sws_scale (this is a relatively big change)
* av_close_input_file --> avformat_close_input
