#include <detpic32.h>
#define VECTOR 27

volatile unsigned char voltage = 0;

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

unsigned char toBcd(unsigned char value) {
    return ((value / 10) << 4) + (value % 10);
}


void delay(unsigned int ms) {
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

int main(void){
    int cnt = 0;

    // configurar displays
    TRISB = TRISB & 0x80FF; // configurar RB8 a RB14 como saída
    TRISD = TRISD & 0xFF9F; // configurar RD5 a RD6



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
    AD1CON2bits.SMPI = 8-1; // Interrupt is generated after N samples
    // (replace N by the desired number of
    // consecutive samples)
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
    // analog channel (0 to 15)
    AD1CON1bits.ON = 1; // Enable A/D converter
    // This must the last command of the A/D
    // configuration sequence


    // configurar sistema de interrupção
    IPC6bits.AD1IP = 2; // configure priority of A/D interrupts
    IFS1bits.AD1IF = 0; // clear A/D interrupt flag
    IEC1bits.AD1IE = 1; // enable A/D interrupts 

    EnableInterrupts();
    while (1) {

        if(cnt % 20 == 0){
            // Start A/D conversion
            AD1CON1bits.ASAM = 1;
        }
        send2displays(toBcd(voltage));
        cnt++;
        delay(10);
    }

    return 0;

}


// Interrupt Handler

 void _int_(VECTOR) isr_adc(void)
 {
    int i = 0;
    // Read 8 samples (ADC1BUF0, ..., ADC1BUF7) and calculate average
    int *p = (int *)(&ADC1BUF0);

    for (i = 0; i < 8; i++)   // i < 8 pois são o numero de amostras definidas
    {
        voltage = (p[i*4] * 33 + 511) / 1023;
        //printInt(p[i*4], 10 | 4 << 16);

        printInt(voltage, 10 | 2 << 16);
        putchar('\r');

    }

    // Reset AD1IF flag
    IFS1bits.AD1IF = 0;
    


    

 // Calculate voltage amplitude
 // Convert voltage amplitude to decimal and store the result in the global variable "voltage"

 } 
