#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

void saveMaps();

int main() {
    saveMaps();
}

void saveMaps() {
    char fileLoc[15] = "/proc/self/maps";
    int mapsFile = open(fileLoc, O_RDONLY);
    int mapsStorage = open("checkpoint.ckpt", O_WRONLY);
    
    char buffer[100];
    while(read(mapsFile, buffer, 100) != 0) {
        write(mapsStorage, buffer, 100);
    }
    close(mapsFile);
    close(mapsStorage);
}