typedef struct mysem {
  int count;
  pthread_mutex_t lock;
} mysem;

//Part 1 functions
int sem_init(struct mysem *sem, int ignore, int init);
int sem_post(struct mysem *sem);
int sem_wait(struct mysem *sem);

//Part 1 helper function
void block_until_count_increases(struct mysem *sem, int last_count);
  
int sem_init(struct mysem *sem, int ignore, int init) {
    sem->count = init;
    pthread_mutex_init(&(sem->lock), NULL);
}
    
int sem_post(struct mysem *sem) {
    pthread_mutex_lock(&(sem->lock));
    (sem->count)++;
    pthread_mutex_unlock(&(sem->lock));
}

int sem_wait(struct mysem *sem) {
    pthread_mutex_lock( &(sem->lock) );
    int last_count = sem->count;
    (sem->count)--;
    
    if (sem->count < 0) {
        pthread_mutex_unlock( &(sem->lock) );
        block_until_count_increases(sem, last_count);
        pthread_mutex_lock( &(sem->lock) );
    }
    pthread_mutex_unlock( &(sem->lock) );
}

void block_until_count_increases(struct mysem *sem, int last_count) {
    pthread_mutex_lock( &(sem->lock) );
    while (sem->count < last_count) {
        pthread_mutex_unlock( &(sem->lock) );
    }
    pthread_mutex_unlock( &(sem->lock) );
}