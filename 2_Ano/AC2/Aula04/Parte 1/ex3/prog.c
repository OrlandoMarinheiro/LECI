#include <detpic32.h>

void wait(unsigned int cicles){

    resetCoreTimer();
    while(readCoreTimer() < cicles);
}

int main(void){

    // configurar os portos RE6 A RE3 como saída 
    TRISE = TRISE & 0xFF87;

    // iniciar contador
    int counter = 9;

    while(1) {
        wait(7407407);      // frequencia de 2.7Hz
        LATE = (LATE & 0xFF87) | counter << 3; // 1000 0111
        counter = (counter - 1);
        if(counter == -1) {
            counter = 9;
        }
        // counter = (counter + 9) % 10; alternativa ao codigo de decrementação
    }
    return 0;
}

