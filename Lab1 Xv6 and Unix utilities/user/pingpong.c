#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
    // Check if the number of arguments is correct
    if (argc != 1)
    {
        fprintf(2, "Usage: pingpong\n");
        exit(1);
    }

    char buf[1] = {'a'}; // Buffer for pipe communication
    int ptc[2], ctp[2];  // Pipes: parent to child (ptc) and child to parent (ctp)

    // Create pipes
    pipe(ptc);
    pipe(ctp);

    // Create child process
    int pid = fork();

    if (pid > 0)
    {                                            // Parent process
        write(ptc[1], buf, 1);                   // Send signal to child
        read(ctp[0], buf, 1);                    // Receive signal from child
        printf("%d: received pong\n", getpid()); // Print received signal
        wait(&pid);                              // Wait for child process to finish
        exit(0);
    }
    else if (pid == 0)
    {                                            // Child process
        read(ptc[0], buf, 1);                    // Receive signal from parent
        printf("%d: received ping\n", getpid()); // Print received signal
        write(ctp[1], buf, 1);                   // Send signal to parent
        exit(0);
    }
    else
    { // Fork failed
        printf("fork error\n");
        exit(1);
    }
}
