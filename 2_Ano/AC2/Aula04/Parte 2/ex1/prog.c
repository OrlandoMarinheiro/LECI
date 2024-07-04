#include <detpic32.h>

int main(void) {
    // configurar RB8 a RB14 como saída
    TRISB = TRISB & 0x80FF;
    // configurar RD5 e RD6 como saída (RD5 = 1 E RD6 = 0)
    TRISD = (TRISD & 0xFF9F);
    LATDbits.LATD5 = 0;
    LATDbits.LATD6 = 1;

    char letra;
    while(1) {
        letra = getChar();
        if(letra >= 'a' && letra <= 'g'){
            // colocar letra em maiscula
            letra = letra - 0x0020;
        }
        if(letra >= 'A' && letra <= 'G') {
            // descobrir o indice da letra correspondente, ex: 'B' -> 66, 'A' -> 65, logo 'B' - 'A' = 1, ou seja 'A' está na posição 0 e 'B' na posição 1
            int indice = letra - 'A';
            // deslocamento x(indice) vezes do bit 1 a iniciar em 0x0100 (0000 0001 0000 0000) 
            LATB = (LATB & 0x80FF) | 0x0100 << indice;
        }
    }
    
    return 0;
}