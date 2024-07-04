#include <detpic32.h>
#define VECTOR 12

int main(void){

    //configure timer T3 (2Hz with interrupts disabled)
    T3CONbits.TCKPS = 7; // 1:256 prescaler (i.e. fout_presc = 78 125HZ)

    // k_prescaler = f_PBCLK / (65535 + 1) * f_OUT
    // k_prescaler = 20 000 000 / (65536 * 2) = 153 => 256

    // PR2 = ((f_PBCLK / K_prescaler) / f_OUT ) - 1
    // PR2 = ((20 000 000 / 256) / 2) - 1
    // PR2 = 39062  
    PR3 = 39062; // Fout = 20MHz / (32 * (39 999 + 1)) = 10 Hz
    TMR3 = 0; // Clear timer T2 count register
    T3CONbits.TON = 1; // Enable timer T2 (must be the last command of the
    // timer configuration sequence) 


    // configurar sistema de interrupção
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T3 interrupts
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    EnableInterrupts();
    // Start A/D conversion
    AD1CON1bits.ASAM = 1;
    while (1);

    return 0;

}


// Interrupt Handler

 void _int_(VECTOR) isr_T3(void) // Replace VECTOR by the timer T3 vector
 // number - see "PIC32 family data
 // sheet" (pages 74-76)
 {

    putChar('.');

    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag
 } 
