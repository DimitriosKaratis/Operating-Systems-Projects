#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

int sigint_count = 0;

void custom_sigint_handler(int sig) {
    printf("Signal %d caught. Count: %d\n", sig, ++sigint_count);

    if (sigint_count == 2) {
        printf("Restoring default SIGINT behavior...\n");
        signal(SIGINT, SIG_DFL);
    }
}

int main() {
    signal(SIGINT, custom_sigint_handler);
    printf("Press Ctrl+C to trigger SIGINT...\n");
    while (1);
    return 0;
}

