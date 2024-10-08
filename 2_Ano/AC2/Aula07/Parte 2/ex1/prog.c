#include <detpic32.h>
#define VECTOR 27

int main(void){

    TRISD = TRISD & 0xF7FF;
    
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
    AD1CON2bits.SMPI = 0; // Interrupt is generated after N samples
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
    // Start A/D conversion
    AD1CON1bits.ASAM = 1;
    while (1);

    return 0;

}


// Interrupt Handler

 void _int_(VECTOR) isr_adc(void) // Replace VECTOR by the A/D vector
 // number - see "PIC32 family data
 // sheet" (pages 74-76)
 {
    volatile int adc_value;
    // Reset RD11 (LATD11 = 0)
    LATDbits.LATD11 = 0;
    // Read ADC1BUF0 value to "adc_value"   
    adc_value = ADC1BUF0;
    
    AD1CON1bits.ASAM = 1; // Start A/D conversion

    // Set RD11 (LATD11 = 1)
    LATDbits.LATD11 = 1;

    IFS1bits.AD1IF = 0; // Reset AD1IF flag
 } 


// medição do tempo durante o qual o porto RD11 permanece a valor logico 1 -> 3,93 picossegundos
