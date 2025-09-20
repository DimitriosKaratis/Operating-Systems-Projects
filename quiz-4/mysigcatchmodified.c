#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

int sigint_count = 0;

void custom_handler(int sig) {
    sigint_count++;
    printf("Signal %d caught! Count: %d\n", sig, sigint_count);
    if (sigint_count == 2) {
        signal(SIGINT, SIG_DFL); // Restore default behavior
        printf("Default behavior restored. Press Ctrl+C again to terminate.\n");
    }
}

int main() {
    signal(SIGINT, custom_handler);
    printf("Press Ctrl+C to trigger SIGINT\n");
    while (1) {} // Infinite loop to keep the program running
    return 0;
}
