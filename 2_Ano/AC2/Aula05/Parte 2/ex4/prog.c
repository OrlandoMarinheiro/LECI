#include <detpic32.h>

unsigned char toBcd(unsigned char value) {
    return ((value / 10) << 4) + (value % 10);
}

void delay(unsigned int ms) {
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms);
}

void send2displays(unsigned char value) {
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
    TRISB = TRISB & 0x80FF; // Configurar RB8 a RB14 como saída
    TRISD = TRISD & 0xFF9F; // Configurar RD5 e RD6 como saída
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 1;

    TRISE = TRISE & 0xFF00; // Configurar RE0 a RE7 como saída

    TRISC = TRISC & 0x0FFF; // Configurar RC14 como saída

    TRISB = (TRISB & 0xFFF1) | 0x0001; // Configurar RB0 como entrada

    unsigned int i = 0;
    int counter = 0;
    int cnt5sec = 1;
    while (1) {
        if (counter == 0) {
            if (cnt5sec > 0) {
                LATCbits.LATC14 = 1;
                cnt5sec = cnt5sec - 1;
            } else {
                LATCbits.LATC14 = 0;
                cnt5sec = 1;
            }  
        }
        if (PORTBbits.RB0 == 1) {
            LATE = (LATE & 0xFF00) | toBcd(counter);
            send2displays(counter);
            delay(10);  // refresh rate do contador de 100 Hz
            i = (i + 1) % 20; // 5Hz de incremento
            if (i == 0) {
                if(counter == 59) {
                    counter = 0;
                } else{
                    counter += 1;
                }
               // counter = (counter + 1) % 60;
            }
        } else {
            LATE = (LATE & 0xFF00) | toBcd(counter);
            send2displays(counter);
            delay(10);
            i = (i + 1) % 20;
            if (i == 0) {
                if (counter == 0) {
                    counter = 59;
                } else {
                    counter = (counter - 1);
                }
            }
        }
    }
    return 0;
}
