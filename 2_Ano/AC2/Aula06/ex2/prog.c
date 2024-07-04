#include <detpic32.h>

int main(void) {

    // configurar o port de entrada lógica
    TRISBbits.TRISB4 = 1; // RBx digital output disconnected
    AD1PCFGbits.PCFG4 = 0; // RBx configured as analog input
    AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
    // mode an internal counter ends sampling and
    // starts conversion

    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    // interrupt is generated. At the same time,
    // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 1-1; // Interrupt is generated after N samples
    // (replace N by the desired number of
    // consecutive samples)
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
    // analog channel (0 to 15)
    AD1CON1bits.ON = 1; // Enable A/D converter
    // This must the last command of the A/D
    // configuration sequence

    // configurar RD11 como output
    TRISDbits.TRISD11 = 0;

    volatile int aux;

    while (1) {
        // começar conversão
        AD1CON1bits.ASAM = 1;
        // escrever em RD11
        LATDbits.LATD11 = 1;
        // esperar enquanto a conversão não estiver feita
        while (IFS1bits.AD1IF == 0);
        LATDbits.LATD11 = 0;
        // ler o resultado convertido para variavel "aux"
        aux = ADC1BUF0;
        // reset AD1IF
        IFS1bits.AD1IF = 0;
    }
    return 0;
}