#include <stdio.h>
int main()
{
int i;
int j;
int fact = 1;
int temp;
int num = 5; /* hold what factorial you want */
for (int i = num; i >= 2; i--)
{
temp = fact;
for (int j = i; j >= 2; j--)
{
fact = fact + temp;
}
}
printf("fact: %d\n", fact);
return 0;
}