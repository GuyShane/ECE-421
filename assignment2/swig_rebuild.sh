#!/bin/bash

make clean
rm Makefile
rm Delay.so
rm delay_wrap.c

swig -ruby delay.i
ruby extconf.rb
make
mv delay.so Delay.so
