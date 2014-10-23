#!/bin/bash

make clean
rm Makefile
rm DelayPrint.so
rm delayPrint_wrap.c

swig -ruby delayPrint.i
ruby extconf.rb
make
mv delayPrint.so DelayPrint.so
