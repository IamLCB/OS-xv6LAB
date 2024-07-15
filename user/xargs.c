#include "kernel/param.h"
#include "kernel/types.h"
#include "user/user.h"
#include <stddef.h>

// Function to read one line from standard input
int getOneLine(char *buf)
{
    char ch;
    char *str = buf;
    while (read(0, &ch, 1) == 1 && ch != '\n')
        *buf++ = ch;
    *buf = 0; // Null-terminate the string
    return strlen(str);
}

int main(int argc, char **argv)
{
    if (argc < 2)
    {
        fprintf(2, "Usage: %s command [args...]\n", argv[0]); // Provide more helpful error message
        exit(1);
    }

    char *args[MAXARG];
    for (int i = 1; i < argc; i++)
    {
        args[i - 1] = argv[i];
    }
    args[argc - 1] = NULL; // Ensure the array is properly null-terminated

    char buf[MAXPATH] = {0};
    while (getOneLine(buf) > 0)
    {                         // Check if line length is greater than zero
        args[argc - 1] = buf; // Set the last command argument to the input line
        if (fork() == 0)
        {
            exec(argv[1], args); // Execute the command in the child process
            exit(0);
        }
        wait(0);                 // Parent waits for the child to finish
        memset(buf, 0, MAXPATH); // Clear the buffer for the next input
    }
    exit(0);
}
