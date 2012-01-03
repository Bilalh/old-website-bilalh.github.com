---
layout: post
title: Fixing corrupt mp3s
date: 2011-12-24 16:33:17
category: Unix
tags:
 - Utilities
 - Audio
---

To fix corrupt mp3 use [mp3val](http://mp3val.sourceforge.net/).  The website has binaries for Windows, and sources for other platforms (Linux, Mac OS X). 

Installation
------------

**Update**: binaries for Mac OS X (tested on 10.6) [here](/files/mp3val)

To install on a Mac either install it the easy way:

	brew install mp3val

or download the sources and then `cd` to the directory of sources and then do

	make -f Makefile.gcc

and then place the binaries in `/usr/local/bin`


Usage
-----

To fix the corrupt mp3s use 

	mp3val -f

which tells `mp3val` to fix the errors in the mp3s.  Wildcards can be used e.g.

	mp3val -f *.mp3
	
which fix all mp3 in the current directory.

`mp3val` keeps all the old tags as well, which is useful