#include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

void send2displays (unsigned char value) {
    static const char display7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    static char displayFlag = 0;
    unsigned char digit_low = value & 0x0F;
    unsigned char digit_high = value >> 4;
    if (displayFlag == 0) {
        LATDbits.LATD5 = 1;
        LATDbits.LATD6 = 0;
        LATB = (LATB & 0x80FF) | display7Scodes[digit_low] << 8;
    } else {
        LATDbits.LATD5 = 0;
        LATDbits.LATD6 = 1;
        LATB = (LATB & 0x80FF) | display7Scodes[digit_high] << 8;
    }
    displayFlag = displayFlag ^ 1;
}

int main(void) {

    // definir RB8 a RB14 como portos de saída
    TRISB = (TRISB & 0x80FF);
    // definir RD5 E RD6 como portos de saída
    TRISD = TRISD & 0xFF9F;
    // definir ambos os displays ligados
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 1;

    unsigned int i = 0;
    int counter = 0;
    while (1) {
        send2displays(counter);
        delay(10);
        i = (i + 1) % 20;  // frequencia de atualização do contador 5Hz
        if (i == 0) {
            counter = (counter + 1) % 256;
        }
    }
    return 0;
}