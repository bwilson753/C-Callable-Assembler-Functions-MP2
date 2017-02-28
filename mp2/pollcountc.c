/* echo.c: use assembly language i/o to echo console input */
/* build with makefile in $pcex:  make A=echo      */

#include <stdio.h>

extern int pollcount_putc(unsigned char);
void main()
{
  unsigned int i, count[5];
  unsigned char c[] = "ABCDE";

  for (i = 0; i < 300000; i++)
     ;

  for (i = 0; i < 5; i++)
     count[i] = pollcount_putc(c[i]);

  printf("\n");
  for (i = 0; i < 5; i++)
     printf("Count %d is %7d\n", i, count[i]);

}

