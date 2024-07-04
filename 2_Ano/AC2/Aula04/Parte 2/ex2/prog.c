#include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

int main(void) {
    // configurar os portos RB8 a RB14 como saída 
    TRISB = TRISB & 0x80FF;
    // configurar os portos RD5 e RD6 como saída
    TRISD = (TRISD & 0xFF9F);
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;
    while(1) {
        int segmento = 1;
        int i;
        for (i = 0; i < 7; i++) {
            LATB = (LATB & 0x80FF) | segmento << 8;
            delay(500);
            segmento = segmento << 1;
        }
        LATDbits.LATD5 = !LATDbits.LATD5;
        LATDbits.LATD6 = !LATDbits.LATD6;
    }
    return 0;
}