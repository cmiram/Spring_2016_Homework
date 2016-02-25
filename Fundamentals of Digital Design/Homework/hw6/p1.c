#include <stdio.h>

int main()
{
 // Two strings, 100 bytes allocated for each
 char s1[100];
 char s2[100];

 // Read string 1
 printf("Enter string 1: ");
 scanf("%s", s1);
 // Read string 2
 printf("Enter string 2: ");
 scanf("%s", s2);
 // Compare them
 int index = 0;
 while (1)
 {
 // Load characters from s1 and s2
 char c1 = s1[index];
 char c2 = s2[index];

 // Current character is greater for s1
 if (c1 > c2)
 {
 printf("s1 > s2\n");
 break;
 }

 // Current character is greater for s2
 if (c1 < c2)
 {
 printf("s1 < s2\n");
 break;
 } 

 // End of strings reached
 if (c1 == 0)
 {
 printf("The strings are equal\n");
 break;
 }

 // Compare next character
 index++;
 }
} 