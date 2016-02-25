#include <stdio.h>

int main()
{
 // Read string
 char s[100];
 printf("Enter string: ");
 gets(s);

 // Remove spaces
 char c;
 int old_index = 0;
 int new_index = 0;
 do
 {
     // Read character
     c = s[old_index];

     // Old position moves ahead
     old_index++;
     // If it's a space, ignore
     if (c == ' ')
        continue;
     // Copy character
     s[new_index] = c;
     // New position moves ahead
     new_index++;
 } while (c);
 // Print result
 printf("New string: %s\n", s);
}