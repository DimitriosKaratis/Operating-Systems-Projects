#include <stdio.h>
#include <unistd.h>

int main() {
    int fd[2];
    pid_t pid;
    char buffer[20];

    if (pipe(fd) == -1) {
        perror("Pipe failed");
        return 1;
    }

    pid = fork();
    if (pid == 0) {
        read(fd[0], buffer, sizeof(buffer));
        printf("Child received: %s\n", buffer);
    } else {
        char *message = "Hello from parent";
        write(fd[1], message, sizeof(buffer));
    }

    return 0;
}

