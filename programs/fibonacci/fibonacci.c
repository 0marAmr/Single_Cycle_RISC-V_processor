#include <stdio.h>

int main() {
int x = 0;
int y = 1;
int sel = 1;
int i;

for (i = 0; i < 10; i++) {
    if (sel == 1) {
        x = x + y;
        sel = 2;
        printf("%d\n", x);
    } else {
        y = x + y;
        sel = 1;
        printf("%d\n", y);
    }
}

return 0;
}