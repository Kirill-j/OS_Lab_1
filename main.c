#define _CRT_SECURE_NO_WARNINGS 

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "fib.h"

#define MAXBUFSIZE 1024

const int STDIO = 1;

char hello_str [] = "Hello, World!\n";
int n = 10;
char numbers[10];

int main(void) {
    ssize_t l = write(STDIO, hello_str, strlen(hello_str));
    char buf [MAXBUFSIZE];
    int p[2];
    pipe(p);
    ssize_t rc = fork();

    if (rc == 0) // the child process
    {
        for (int i = 1; i <= n; i++)
        {
            numbers[i] = fib(i);
        }
        l = snprintf(buf, sizeof(buf), "%i fibonacci numbers:\n%i", n, numbers[10]);

        close(p[0]);
        write(p[1], buf, MAXBUFSIZE);

        close(p[1]);
        _exit(0);
    }
    else if (rc > 0)
    {
        int crc;
        close(p[1]);
        wait(& crc);
        l = read(p[0], buf, MAXBUFSIZE);
        write(STDIO, buf, strlen(buf));
        printf("\n");
        // getchar(); getchar();

        close(p[0]);
    }
    else
        printf("Error creating a child process!\n");
   
    return 0;
}