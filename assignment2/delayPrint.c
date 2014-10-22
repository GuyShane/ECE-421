#include <stdio.h>
#include <unistd.h>

void delay_print(int ms, char * message) {
  usleep(ms*1000);
  printf("%s\n",message);
}
