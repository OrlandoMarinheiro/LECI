#include <detpic32.h>
#define VECTOR_TIMER3 12

int main(void) {

    // frequencia de 100HZ - tipo B
    T3CONbits.TCKPS = 2; // 1:4 prescaler 
    PR3 = 49999; 
    TMR3 = 0; // Clear timer T3 count register
    T3CONbits.TON = 1; // Enable timer T3 (must be the last command of the
    // timer configuration sequence) 

    OC1CONbits.OCM = 6; // PWM mode on OCx; fault pin disabled
    OC1CONbits.OCTSEL = 0;// Use timer T2 as the time base for PWM generation
    OC1RS = 12500; // Ton constant
    OC1CONbits.ON = 1; // Enable OC1 module

    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T3 interrupts
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    EnableInterrupts();

    while(1);

    return 0;
}

void _int_(VECTOR_TIMER3) isr_T3(void) {

    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag
 }