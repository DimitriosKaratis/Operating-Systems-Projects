#include <stdio.h>
#include <unistd.h>

int main() {
    FILE *file = fopen("pid_file.txt", "a");

    if (file == NULL) {
        perror("Failed to open file");
        return 1;
    }

    pid_t pid = fork();

    if (pid == 0) {
        fprintf(file, "Child PID: %d\n", getpid());
    } else {
        fprintf(file, "Parent PID: %d\n", getpid());
    }

    fclose(file);
    return 0;
}

