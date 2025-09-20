#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

void handle_sigint(int sig) {
    printf("SIGINT signal caught!\n");
    exit(0);
}

int main() {
    signal(SIGINT, handle_sigint);
    printf("Press Ctrl+C to trigger SIGINT\n");
    while (1) {} // Infinite loop to keep the program running
    return 0;
}
