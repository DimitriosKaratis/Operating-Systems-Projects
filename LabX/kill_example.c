#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void handler(int sig) {
    printf("Child received signal %d\n", sig);
}

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        signal(SIGUSR1, handler);
        pause();  // Wait for signal
    } else {
        sleep(1);  // Ensure child sets up the handler
        kill(pid, SIGUSR1);
    }

    return 0;
}

