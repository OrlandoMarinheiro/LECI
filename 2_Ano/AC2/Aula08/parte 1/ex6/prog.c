#include <detpic32.h>
#define VECTOR_TIMER1 4
#define VECTOR_TIMER3 12

int main(void){

    // configuração dos portos RE1 a RE3
    TRISE = TRISE & 0xFFF5;

    LATEbits.LATE1 = 0;
    LATEbits.LATE3 = 0;

//configure timer T1 (5Hz with interrupts disabled)
    T1CONbits.TCKPS = 6; // 1:64 prescaler (i.e. fout_presc = 312500HZ)

    // k_prescaler = f_PBCLK / (65535 + 1) * f_OUT
    // k_prescaler = 20 000 000 / (65536 * 5) = 61 => 64

    // PR1 = ((f_PBCLK / K_prescaler) / f_OUT ) - 1
    // PR1 = ((20 000 000 / 64) / 5) - 1
    // PR1 = 62499  
    PR1 = 62499; // Fout = 20MHz / (64 * (62499 + 1)) = 5 Hz
    TMR1 = 0; // Clear timer T1 count register
    T1CONbits.TON = 1; // Enable timer T1 (must be the last command of the
    // timer configuration sequence) 


//configure timer T3 (25Hz with interrupts disabled)

    T3CONbits.TCKPS = 4; // 1:16 prescaler (i.e. fout_presc = 1250000HZ)

    // k_prescaler = f_PBCLK / (65535 + 1) * f_OUT
    // k_prescaler = 20 000 000 / (65536 * 25) = 12 => 16

    // PR3 = ((f_PBCLK / K_prescaler) / f_OUT ) - 1
    // PR3 = ((20 000 000 / 16) / 25) - 1
    // PR3 = 49999  

    PR3 = 49999; // Fout = 20MHz / (16 * (49 999 + 1)) = 25 Hz
    TMR3 = 0; // Clear timer T3 count register
    T3CONbits.TON = 1; // Enable timer T3 (must be the last command of the
    // timer configuration sequence) 


//configure timer T3 (50HZ with interrupts disabled)
//    T3CONbits.TCKPS = 3; // 1:8 prescaler (i.e. fout_presc = 2500000HZ)

    // k_prescaler = f_PBCLK / (65535 + 1) * f_OUT
    // k_prescaler = 20 000 000 / (65536 * 50) = 6 => 8

    // PR3 = ((f_PBCLK / K_prescaler) / f_OUT ) - 1
    // PR3 = ((20 000 000 / 8) / 50) - 1
    // PR3 = 49999  
//    PR3 = 49999; // Fout = 20MHz / (16 * (49 999 + 1)) = 25 Hz
//    TMR3 = 0; // Clear timer T3 count register
//    T3CONbits.TON = 1; // Enable timer T3 (must be the last command of the
    // timer configuration sequence) 


    // configurar sistema de interrupção T3
    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T3 interrupts
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    // configurar sistema de interrupção T1
    IPC1bits.T1IP = 1; // Interrupt priority (must be in range [1..6])
    IEC0bits.T1IE = 1; // Enable timer T1 interrupts
    IFS0bits.T1IF = 0; // Reset timer T1 interrupt flag

    EnableInterrupts();
    // Start A/D conversion
    AD1CON1bits.ASAM = 1;
    while (1);

    return 0;

}

// Interrupt Handler

 void _int_(VECTOR_TIMER1) isr_T1(void) // Replace VECTOR by the timer T3 vector
 // number - see "PIC32 family data
 // sheet" (pages 74-76)
 {  
    LATEbits.LATE1 = !LATEbits.LATE1;
    putChar('1');
    
    IFS0bits.T1IF = 0;
}


// Interrupt Handler

 void _int_(VECTOR_TIMER3) isr_T3(void) // Replace VECTOR by the timer T3 vector
 // number - see "PIC32 family data
 // sheet" (pages 74-76)
 {  
    LATEbits.LATE3 = !LATEbits.LATE3;
    putChar('3');
    
    IFS0bits.T3IF = 0;
}



