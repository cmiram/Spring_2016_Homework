#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

struct cacheLine {
    int valid;
    int tag;
    int set;
    struct cacheLine *next;
};

struct cacheLine *firstRow;
int maxCacheIndex;
int testSet[] = {0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80,
    0, 4, 8, 12, 16, 71, 3, 41, 81, 39, 38, 71, 15, 39, 11, 51, 57, 41};

int isHitOrMiss(int k, int tag, int set);
int itemsInCache();
int itemsWithThisSetNumber(int set);

void testRun1();
void testRun2();
void testRun3();
void testRun4();

void directMapped(int cacheSize, int lineSize);
void nWaySetAssociative(int cacheSize, int lineSize, int n);
void fullyAssociative(int cacheSize, int lineSize);

int main() {
    testRun1();
    printf("\n\n");
    firstRow = NULL;
    
    testRun2();
    printf("\n\n");
    firstRow = NULL;
    
    testRun3();
    printf("\n\n");
    firstRow = NULL;
    
    testRun4();
    return 0;
}

void testRun1() {
    directMapped(128, 8);
}

void testRun2() {
    nWaySetAssociative(64, 8, 2);
}

void testRun3() {
    directMapped(128, 16);
}

void testRun4() {
    fullyAssociative(64, 8);
}

void directMapped(int cacheSize, int lineSize) {
    int isHit;
    firstRow = NULL;
    maxCacheIndex = cacheSize/lineSize;
    
    int tag, set, tagSetTemp, offset, i;
    int loopControl = 39;
    isHit = 0;
    for(i=0; i<39; i++) {
        offset = testSet[i] % lineSize;
        tagSetTemp = testSet[i] / lineSize;
        tag = tagSetTemp / maxCacheIndex;
        set = tagSetTemp % maxCacheIndex;
        isHit = isHitOrMiss(testSet[i], tag, set);
        if (!isHit) {
            struct cacheLine *temp;
            //evict fifo if cache is filled
            if (itemsInCache() >= maxCacheIndex) {
                if(firstRow != NULL) {
                    temp = firstRow->next;
                    firstRow = temp;
                }
            }
            
            //add new data
            if(firstRow == NULL) {
                struct cacheLine *new = malloc(sizeof(struct cacheLine));
                new->valid = 1;
                new->tag = tag;
                new->set = set;
                new->next = NULL;
                
                firstRow = new;
            }
            else {
                temp = firstRow;
                while(temp->next != NULL) {
                    temp = temp->next;
                }
                struct cacheLine *new = malloc(sizeof(struct cacheLine));
                new->valid = 1;
                new->tag = tag;
                new->set = set;
                new->next = NULL;
                
                temp->next = new;
            }
            
            printf("%d: Miss (Tag/Set#/Offset: %d/%d/%d)\n", testSet[i], tag, set, offset);
        }
        else {
            printf("%d: Hit (Tag/Set#/Offset: %d/%d/%d)\n", testSet[i], tag, set, offset);
        }
    }
}

void fullyAssociative(int cacheSize, int lineSize) {
    int isHit;
    firstRow = NULL;
    maxCacheIndex = cacheSize/lineSize;
    
    int tag, set, tagSetTemp, offset, i;
    int loopControl = 39;
    isHit = 0;
    for(i=0; i<39; i++) {
        offset = testSet[i] % lineSize;
        tag = testSet[i] / lineSize;
        set = 0; //fully associative doesn't care about sets
        isHit = isHitOrMiss(testSet[i], tag, set);
        if (!isHit) {
            struct cacheLine *temp;
            //evict fifo if cache is filled
            if (itemsInCache() >= maxCacheIndex) {
                if(firstRow != NULL) {
                    temp = firstRow->next;
                    firstRow = temp;
                }
            }
            
            //add new data
            if(firstRow == NULL) {
                struct cacheLine *new = malloc(sizeof(struct cacheLine));
                new->valid = 1;
                new->tag = tag;
                new->set = set;
                new->next = NULL;
                
                firstRow = new;
            }
            else {
                temp = firstRow;
                while(temp->next != NULL) {
                    temp = temp->next;
                }
                struct cacheLine *new = malloc(sizeof(struct cacheLine));
                new->valid = 1;
                new->tag = tag;
                new->set = set;
                new->next = NULL;
                
                temp->next = new;
            }
            
            printf("%d: Miss (Tag/Set#/Offset: %d/%d/%d)\n", testSet[i], tag, set, offset);
        }
        else {
            printf("%d: Hit (Tag/Set#/Offset: %d/%d/%d)\n", testSet[i], tag, set, offset);
        }
    }
}

void nWaySetAssociative(int cacheSize, int lineSize, int n) {
    int isHit;
    firstRow = NULL;
    maxCacheIndex = cacheSize/lineSize;
    int k = maxCacheIndex / n;
    
    int tag, set, tagSetTemp, offset, i;
    int loopControl = 39;
    isHit = 0;
    for(i=0; i<39; i++) {
        offset = testSet[i] % lineSize;
        tagSetTemp = testSet[i] / lineSize;
        tag = tagSetTemp / k;
        set = tagSetTemp % k;
        isHit = isHitOrMiss(testSet[i], tag, set);
        if (!isHit) {
            struct cacheLine *temp;
            
            //evict fifo if cache size >= n
            if (itemsWithThisSetNumber(set) >= n) {
                temp = firstRow;
                struct cacheLine *prev;
                if(temp->set == set) {
                    firstRow = temp->next;
                }
                else {
                    while(temp->set != set) {
                        prev = temp;
                        temp = temp->next;
                    }
                    prev->next = temp->next;
                }
            }
            
            //add new data
            if(firstRow == NULL) {
                struct cacheLine *new = malloc(sizeof(struct cacheLine));
                new->valid = 1;
                new->tag = tag;
                new->set = set;
                new->next = NULL;
                
                firstRow = new;
            }
            else {
                temp = firstRow;
                while(temp->next != NULL) {
                    temp = temp->next;
                }
                struct cacheLine *new = malloc(sizeof(struct cacheLine));
                new->valid = 1;
                new->tag = tag;
                new->set = set;
                new->next = NULL;
                
                temp->next = new;
            }
            
            printf("%d: Miss (Tag/Set#/Offset: %d/%d/%d)\n", testSet[i], tag, set, offset);
        }
        else {
            printf("%d: Hit (Tag/Set#/Offset: %d/%d/%d)\n", testSet[i], tag, set, offset);
        }
    }
}

int isHitOrMiss(int k, int tag, int set) {
    if (firstRow == NULL) {
        return 0;
    }
    struct cacheLine *temp;
    temp = firstRow;
    
    if (temp->set == set && temp->tag == tag && temp->valid) {
        return 1;
    }
    
    while(temp->next != NULL) {
        temp = temp->next;
        if (temp->set == set && temp->tag == tag && temp->valid) {
            return 1;
        }
    }
    return 0;
}

int itemsInCache() {
    if (firstRow == NULL) {
        return 0;
    }
    int count = 1;
    struct cacheLine *temp = firstRow;
    while(temp->next != NULL) {
        count += 1;
        temp = temp->next;
    }
    return count;
}

int itemsWithThisSetNumber(int set) {
    int count = 0;
    
    if (firstRow == NULL) {
        return 0;
    }
    
    struct cacheLine *temp = firstRow;
    while(temp->next != NULL) {
        if (temp->set == set) {
            count += 1;
        }
        temp = temp->next;
    }
    
    return count;
}