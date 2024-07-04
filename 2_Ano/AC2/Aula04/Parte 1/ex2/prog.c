#include <detpic32.h>

void wait(unsigned int cicles){

    resetCoreTimer();
    while(readCoreTimer() < cicles);
}

int main(void){

    // configurar os portos RE6 A RE3 como saída 
    TRISE = TRISE & 0xFF87;

    // iniciar contador
    int counter = 0;

    while(1) {
        wait(4347826);
        LATE = (LATE & 0xFF87) | counter << 3; // 1000 0111
        counter = (counter + 1) % 10;

    }
    return 0;
}

