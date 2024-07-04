#include <detpic32.h>


void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < ms * 20000);
}

void putc(char byte){
    // wait while UART2 UTXBF == 1
    while(U2STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
    
}

char getc(void){
    // Wait while URXDA == 0
    while(U2STAbits.URXDA == 0);
    // Return UxRXREG
    return U2RXREG;
} 

void putstr(char *str){
    // use putc() function to send each charater ('\0' should not be sent)
    while(*str != '\0') {
        putc(*str);
        str++;
    }
} 

int main(void) {
    // Configure UART2 (115200, N, 8, 1)
    U2BRG = 10;
    U2MODEbits.BRGH = 0; //16

    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;

    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;

    U2MODEbits.ON = 1;

    while(1){
        putc(getc());
    }
return 0;
}


