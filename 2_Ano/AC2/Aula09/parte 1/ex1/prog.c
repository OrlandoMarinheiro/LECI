#include <detpic32.h>
#define VECTOR_TIMER1 4
#define VECTOR_TIMER3 12
#define VECTOR_ADC 27

volatile int voltage = 0;


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

void configureAll(){

    TRISB = TRISB & 0x80FF; // Configurar RB8 a RB14 como saída
    TRISD = TRISD & 0xFF9F; // Configurar RD5 e RD6 como saída
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 1;

    TRISE = TRISE & 0xFF00; // Configurar RE0 a RE7 como saída

    TRISC = TRISC & 0x0FFF; // Configurar RC14 como saída

    TRISB = (TRISB & 0xFFF1) | 0x0001; // Configurar RB0 como entrada


    // frequencia 5HZ - tipo A
    T1CONbits.TCKPS = 2; // 1:64 prescaler 
    PR1 = 62499; 
    TMR1 = 0; // Clear timer T1 count register
    T1CONbits.TON = 1; // Enable timer T1 (must be the last command of the
    // timer configuration sequence) 

    // frequencia de 100HZ - tipo B
    T3CONbits.TCKPS = 2; // 1:4 prescaler 
    PR3 = 49999; 
    TMR3 = 0; // Clear timer T3 count register
    T3CONbits.TON = 1; // Enable timer T3 (must be the last command of the
    // timer configuration sequence) 

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


    IPC1bits.T1IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T1IE = 1; // Enable timer T1 interrupts
    IFS0bits.T1IF = 0; // Reset timer T1 interrupt flag 

    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T3 interrupts
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag 

    IPC6bits.AD1IP = 2; // configure priority of A/D interrupts
    IFS1bits.AD1IF = 0; // clear A/D interrupt flag 
    IEC1bits.AD1IE = 1; // enable A/D interrupts
}

void _int_(VECTOR_TIMER1) isr_T1(void){

    AD1CON1bits.ASAM = 1; // start A/D conversion
    IFS0bits.T1IF = 0; // Reset timer T1 interrupt flag 
}   

void _int_(VECTOR_TIMER3) isr_T3(void){

    send2displays(toBcd(voltage));
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag 
}

void _int_(VECTOR_ADC) isr_adc(void){
    int average = 0;
    int i = 0;
    int *p = (int *)(&ADC1BUF0);

    for(i = 0; i < 8; i++) {
        // criar um espaço entre os algarismos
        average += p[i*4] / 8;
        voltage = (average * 33 + 511) / 1023;
    }
    printInt(voltage, 10 | 2 << 16);
    putChar('\r');
    LATE = LATE & 0xFF00 | toBcd(voltage);

    IFS1bits.AD1IF = 0; // clear A/D interrupt flag

}

int main(void) {

    configureAll();

    EnableInterrupts(); // Macro defined in "detpic32.h"

    while(1);
    return 0;
}
