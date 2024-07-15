#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

__attribute__((noreturn))

void pipeLine(int feed){
    int prime;
    if(read(feed, &prime, sizeof(prime)) == 0){
        // no more data to read
        close(feed);// close the read end
        exit(1);
    }
    printf("prime %d\n", prime);
    int cp[2]; // create a pipe
    pipe(cp);
    if(fork() == 0){
        // child process
        close(cp[1]); // close the write end
        pipeLine(cp[0]); // read from the pipe
        close(cp[0]); // close the read end
        exit(0);
    }
    close(cp[0]); // close the read end
    int num;
    while(read(feed, &num, sizeof(num)) != 0){
        if(num % prime != 0){
            // num is not divisible by prime
            write(cp[1], &num, sizeof(num)); // write to the pipe
        }
    }
    close(cp[1]); // close the write end
    wait(0); // wait for the child process to finish
    exit(0);
}

int main (int argc, char *argv[]){
   int p[2];
   pipe(p); // create a pipe
   if(fork() == 0){
    // child process
    close(p[1]); // close the write end
    pipeLine(p[0]); // read from the pipe
    close(p[0]); // close the read end
    exit(0);
   }
   else{
    // parent process
    close(p[0]); // close the read end
    for(int i = 2; i <= 35; i++){
        write(p[1], &i, sizeof(i)); // write to the pipe
    }
    close(p[1]); // close the write end
    wait(0); // wait for the child process to finish
    exit(0);
   }
    exit(0);
}