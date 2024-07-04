#include <detpic32.h>
#define VECTOR_UART2 32

void putc(char byte){
    // wait while UART2 UTXBF == 1
    while(U2STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
    
}

void _int_(VECTOR_UART2) isr_uart2(void){
    
    if (IFS1bits.U2RXIF == 1)
    {
        // Read character from FIFO (U2RXREG)
        char a = U2RXREG;

        if (a == 'T') {
            LATCbits.LATC14 = 1;
        } else if (a == 't'){
            LATCbits.LATC14 = 0;
        }
        putc(a);


        // Clear UART2 Rx interrupt flag
        IFS1bits.U2RXIF == 0;
    }
}

int main(void){
    TRISCbits.TRISC14 = 0;

    // Configure UART2: 115200, N, 8, 1

    U2BRG = 10;
    U2MODEbits.BRGH = 0; //16

    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;

    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;

    U2MODEbits.ON = 1;
    // Configure UART2 interrupts, with RX interrupts enabled
    // and TX interrupts disabled:

    // enable U2RXIE, disable U2TXIE (register IEC1)
    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;
    // set UART2 priority level (register IPC8)
    IPC8bits.U2IP = 1;
    // clear Interrupt Flag bit U2RXIF (register IFS1)
    IFS1bits.U2RXIF = 0;
    // define RX interrupt mode (URXISEL bits)
    U2STAbits.URXISEL = 0;
    // Enable global Interrupts

    EnableInterrupts();

    while(1);
    return 0;
} 