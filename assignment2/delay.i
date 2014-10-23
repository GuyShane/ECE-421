%module Delay
%{
  #include <stdio.h>
  #include <unistd.h>
  extern void delay_print(int ms, char * message);
  extern void delay(int ms);
  %}
extern void delay_print(int ms, char * message);
extern void delay(int ms);
