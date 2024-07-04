#include <detpic32.h>

int main(void) {

    // lista dos codigos dos caracteres
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};

    // configurar as portas RB3 a RB0 como entrada
    // configurar as portas RE8 a RE14 como saída
    TRISB = (TRISB & 0x80FF) | 0x000F;
    // configurar output no display menos significativo
    TRISD = (TRISD & 0xFF9F);
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;

    while(1) {
        LATB = (LATB & 0x80FF) | (disp7Scodes[PORTB & 0x000F] << 8);
    }
    return 0;
}