#include <detpic32.h>

int main(void) {
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

    while(1) {
        // esperar enquanto T3IF = 0
        while(IFS0bits.T3IF == 0);

        // reset T3IF
        IFS0bits.T3IF = 0;

        putChar('.');
    }
    return 0;
}