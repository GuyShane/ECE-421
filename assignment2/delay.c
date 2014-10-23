#include <stdio.h>
#include <unistd.h>

void delay_print(int ms, char * message) {
  usleep(ms*1000);
  printf("\n%s\n",message);
  printf("LittleShell-$: ");
}

void delay(int ms) {
  usleep(ms*1000);  
}
