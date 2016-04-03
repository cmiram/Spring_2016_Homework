// For debugging in GDB with threads: methodology 1
//   (gdb) info threads
//   (gdb) thread 2
//   (gdb) # and so on for other threads
//   (gdb) where # each thread has its own stack
//   (gdb) frame 2  # to go to call frame 2

// For debugging in GDB: methodology 2
//   (gdb) break consumer
//   (gdb) run
//   (gdb) print buf
//   (gdb) next
//   (gdb) print buf  # and so on

#include <stdio.h>
#include <unistd.h> //for sleep
#include <stdlib.h> //for rand
#include <pthread.h> // Needed for pthread_mutex_lock(), etc.
#include <mysem.c> //my implementation of semaphores

mysem sem_producer;  // Should count number of empty slots available
mysem sem_consumer;  // Should count number of items in the buffer
pthread_mutex_t mut_buf = PTHREAD_MUTEX_INITIALIZER;  // Lock for anybody touching buf

//Part 2 helper functions
void push_buf(int work_item);
int take_from_buf();

//Part 3 declarations
void *producer(void *arg);
void *consumer(void *arg);

int buffer[4] = {0, 0, 0, 0};

int main() {
    // ... uses pthread_create to start producer and consumer
    // WARNING:  the primary thread runs main().  When main exits, the primary
    //             thread exits
    int semProd = sem_init(&sem_producer, 0, 4);
    int semCons = sem_init(&sem_consumer, 0, 0);
    
    pthread_t threadProd1;
    pthread_create(&threadProd1, NULL, producer, NULL);
    pthread_t threadCons1;
    pthread_create(&threadCons1, NULL, consumer, NULL);
    
    pthread_t threadProd2;
    pthread_create(&threadProd2, NULL, producer, NULL);
    pthread_t threadCons2;
    pthread_create(&threadCons2, NULL, consumer, NULL);
    
    pthread_t threadProd3;
    pthread_create(&threadProd3, NULL, producer, NULL);
    pthread_t threadCons3;
    pthread_create(&threadCons3, NULL, consumer, NULL);
    
    pthread_join(threadProd1, NULL);
    pthread_join(threadCons1, NULL);
    pthread_join(threadProd2, NULL);
    pthread_join(threadCons2, NULL);
    pthread_join(threadProd3, NULL);
    pthread_join(threadCons3, NULL);
}

void *producer(void *arg) {
    int work_item = 1;
    while (1) {
        sleep( rand() % 5 );
        sem_wait(&sem_producer);  // Wait for empty slots
        pthread_mutex_lock(&mut_buf);
        push_buf(work_item++);  // inside critical section with mut_buf lock
        pthread_mutex_unlock(&mut_buf);
        //printf("\nPre-Producer Post\n");
        sem_post(&sem_consumer);  // Tell the consumer there's a new work item
        //printf("\nPost-Producer Post\n");
    }
}

// Exactly the same, but the inverse:
void *consumer(void *arg) {
    while (1) {
        int work_item;
        sleep( rand() % 5 );
        sem_wait(&sem_consumer);
        //printf("\nAfter Cons Sem_Wait\n");
        pthread_mutex_lock(&mut_buf);
        work_item = take_from_buf();
        pthread_mutex_unlock(&mut_buf);
        printf("%d ", work_item);
        fflush(stdout);  // Force printing now; don't wait for the newline
        sem_post(&sem_producer);

    }
}

void push_buf(int work_item) {
    int i = 0;
    while(buffer[i] != 0 && i <3) {
        i++;
    }
    if (buffer[i] != 0) {
        printf("\nPushing Error!\n");
        exit(-1);
    }
    buffer[i] = work_item;
    //printf("\n[%d, %d, %d, %d]\n", buffer[0], buffer[1], buffer[2], buffer[3]);
}

int take_from_buf() {
    int i = 0;
    int result;
    while(buffer[i] == 0 && i < 3) {
        i++;
    }
    if (buffer[i] == 0) {
        printf("\nTaking Error!\n");
        exit(-1);
    }
    result = buffer[i];
    buffer[i] = 0;
    return result;
}