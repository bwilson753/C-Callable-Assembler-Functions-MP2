/* countc.c: call assembly soubroutine to count c's in string 
   bob wilson
   02/15/03
   */

extern int count(char *string, char c);

int main(void)
{
  char string [] = "aabcabcabc";
  printf("The number of a's in the string is %d\n", count(string, 'a'));
  return 0;
}
