#include <detpic32.h>
#define VECTOR_TIMER2 8
#define VECTOR 7

int main(void)
 {
    TRISDbits.TRISD8 = 1;
    TRISEbits.TRISE0 = 0;

    IPC1bits.INT1IP = 2;      // Interrupt priority INT1
    IEC0bits.INT1IE = 1;      // Enable timer INT1 interrupts
    IFS0bits.INT1IF = 0;      // Reset timer INT1 interrupt flag

 // Configure ports , Timer T2, interrupts and external interrupt INT1
    //configure timer T2 (2Hz with interrupts disabled)
    T2CONbits.TCKPS = 7; // 1:256 prescaler (i.e. fout_presc = 78 125HZ)

    // k_prescaler = f_PBCLK / (65535 + 1) * f_OUT
    // k_prescaler = 20 000 000 / (65536 * 2) = 153 => 256

    // PR2 = ((f_PBCLK / K_prescaler) / f_OUT ) - 1
    // PR2 = ((20 000 000 / 256) / 2) - 1
    // PR2 = 39062  
    PR2 = 39062; // Fout = 20MHz / (32 * (39 999 + 1)) = 10 Hz
    TMR2 = 0; // Clear timer T2 count register
    T2CONbits.TON = 1; // Enable timer T2 (must be the last command of the
    // timer configuration sequence) 


    INTCONbits.INT1EP = 0;

    EnableInterrupts();
    while(1);
    return 0;
 }


 void _int_(VECTOR_TIMER2) isr_T2(void) {
    static int cnt = 0;
    // como não é possiver gerar interrupção pelo timer, ligar LED  a cada 6 icrementos 6* 0.33 hz = 1.98 hz => 2hz
    
    LATEbits.LATE0 = 1;
    
    if(cnt == 6) {

        // autorizar interrupões geradas
        IEC0bits.T2IE = 0;
        // desligar led
        LATEbits.LATE0 = 0;
        putChar('c');
        cnt = 0;
    } else {
        cnt++;
    }
    IFS0bits.T2IF = 0; // Reset timer T2 interrupt flag
 }
 
 void _int_(VECTOR) isr_INT1(void) {
    // configurar sistema de interrupção
    IPC2bits.T2IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T2IE = 1; // Enable timer T2 interrupts
    IFS0bits.T2IF = 0; // Reset timer T2 interrupt flag
    putChar('b');
    IFS0bits.INT1IF = 0;
 }