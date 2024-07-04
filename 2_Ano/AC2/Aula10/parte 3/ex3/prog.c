#include <detpic32.h>

void putc(char byte){
    // wait while UART2 UTXBF == 1
    while(U2STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
    
}

void putstr(char *str){
    // use putc() function to send each charater ('\0' should not be sent)
    while(*str != '\0') {
        putc(*str);
        str++;
    }
} 

int main(void){

    // Configure UART2 (19200, N, 8, 1)
    U2BRG = 64;
    U2MODEbits.BRGH = 0; //16

    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;

    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;

    U2MODEbits.ON = 1;

    // config RD11 as output
    TRISDbits.TRISD11 = 0;

    while(1)
    {
    // Wait while TRMT == 0
    //while(U2STAbits.TRMT == 0);
    // Set RD11
    LATDbits.LATD11 = 1;
    putstr("12345");
    // Reset RD11
    LATDbits.LATD11 = 0;
    }
 return 0;
} 