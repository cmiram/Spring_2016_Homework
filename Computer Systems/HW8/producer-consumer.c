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
#include <pthread.h> // Needed for pthread_mutex_lock(), etc.

typedef struct sem_t {
  int count;
  pthread_mutex_t lock;
} sem_t;

//Part 1 functions
int sem_init(struct sem_t *sem, int ignore, int init);
int sem_post(struct sem_t *sem);
int sem_wait(struct sem_t *sem);

//Part 1 helper function
void block_until_count_increases(struct sem_t *sem, int last_count);

//Part 2 helper functions
void push_buf(int work_item);
int take_from_buf();

//Part 3 declarations
void *producer(void *arg);
void *consumer(void *arg);

sem_t sem_producer;  // Should count number of empty slots available
sem_t sem_consumer;  // Should count number of items in the buffer
pthread_mutex_t mut_buf = PTHREAD_MUTEX_INITIALIZER;  // Lock for anybody touching buf

int buffer[4] = {0, 0, 0, 0};

int main() {
    // ... uses pthread_create to start producer and consumer
    // WARNING:  the primary thread runs main().  When main exits, the primary
    //             thread exits
    int semProd = sem_init(&sem_producer, 0, 1);
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
    
    while (1) {
        
    }  // Don't let the primary thread exit
}

void *producer(void *arg) {
    int work_item = 1;
    while (1) {
        sleep( rand() % 5 );
        sem_wait(&sem_producer);  // Wait for empty slots
        pthread_mutex_lock(&mut_buf);
        push_buf(work_item++);  // inside critical section with mut_buf lock
        pthread_mutex_unlock(&mut_buf);
        sem_post(&sem_consumer);  // Tell the consumer there's a new work item
    }
}

// Exactly the same, but the inverse:
void *consumer(void *arg) {
    while (1) {
        int work_item;
        sleep( rand() % 5 );
        sem_wait(&sem_consumer);
        pthread_mutex_lock(&mut_buf);
        work_item = take_from_buf();
        pthread_mutex_unlock(&mut_buf);
        sem_post(&sem_producer);

        printf("%d ", work_item);
        fflush(stdout);  // Force printing now; don't wait for the newline
    }
}
  
int sem_init(struct sem_t *sem, int ignore, int init) {
    sem->count = init;
    pthread_mutex_init(&(sem->lock), NULL);
}
    
int sem_post(struct sem_t *sem) {
    pthread_mutex_lock(&(sem->lock));
    sem->count += 1;
    pthread_mutex_unlock(&(sem->lock));
}
    
int sem_wait(struct sem_t *sem) {
    pthread_mutex_lock(&(sem->lock));
    int last_count = sem->count;
    (sem->count)--;
    
    if (sem->count < 0) {
        pthread_mutex_unlock(&(sem->lock));
        block_until_count_increases(sem, last_count);
        pthread_mutex_lock(&(sem->lock));
    }
    pthread_mutex_unlock(&(sem->lock));
}

void block_until_count_increases(struct sem_t *sem, int last_count) {
    pthread_mutex_lock(&(sem->lock));
    while (sem->count < last_count) {
        pthread_mutex_unlock(&(sem->lock));
    }
    pthread_mutex_unlock(&(sem->lock));
}

void push_buf(int work_item) {
    int i = 0;
    while(buffer[i] != 0) {
        if (i == 3) {
            i = 0;
        }
        else {
            i += 1;
        }
    }
    buffer[i] = work_item;
}

int take_from_buf() {
    int i = 0;
    int result;
    while(buffer[i] == 0) {
        if (i==3) {
            i = 0;
        }
        else {
            i += 1;
        }
    }
    result = buffer[i];
    buffer[i] = 0;
    return result;
}