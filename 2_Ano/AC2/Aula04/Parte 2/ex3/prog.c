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

    LATD = (LATD & 0xFFBF) | 0x0020;
    while(1) {
        int segmento = 1;
        int i;
        for (i = 0; i < 7; i++) {
            LATB = (LATB & 0x80FF) | segmento << 8;
            delay(500);               // ex4: alterar a frequencia para 10Hz (100ms), 50Hz(20ms), 100Hz(10ms)
            segmento = segmento << 1;
        }
        LATD = LATD ^ 0x0060;
    }
    return 0;
}