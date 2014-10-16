%module delay_print

%{
#include <stdlib.h>
#include <unistd.h>
  %}
   extern void delayPrint(int seconds, char *message);
