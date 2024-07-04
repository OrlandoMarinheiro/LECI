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

int main(void){
    // Configure UART2:
    // 1 - Configure BaudRate Generator
    // UxBRG = (F_PBCLK / 16 * baudrate)-1
    // UxBRG = (20000000 / (16 * 115200)) - 1
    U2BRG = 10;
    U2MODEbits.BRGH = 0; // 16
    // 2 – Configure number of data bits, parity and number of stop bits
    // (see U2MODE register)
    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1;
    // 4 – Enable UART2 (see register U2MODE)
    U2MODEbits.ON = 1;

    while(1) {
        putc('+');
        delay(1000);
    }
    return 0;
} 
 