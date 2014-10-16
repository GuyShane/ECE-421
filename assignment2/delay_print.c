#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void delayPrint(int seconds, char *message) {
  sleep(seconds);
  printf("%s\n",message);
}
