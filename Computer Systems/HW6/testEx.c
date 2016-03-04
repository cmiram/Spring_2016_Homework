#include <stdio.h>

void foo(int in, int* in1, int* in2);

int main() {
    int a[4] = {0, 0, 0, 0};
    int x = 5;
    
    foo(10, &x, &(a[3]));
    
    printf("x=%d a[3]=%d", x, a[3]);
    return 0;
}

void foo(int in, int* in1, int* in2) {
    *in1 =  in + 1;
    *in2 =  in + 2;
}