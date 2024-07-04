#include <detpic32.h>
#include <studsio.h>

void delay(unsigned int ms) 
{
    unsigned int wait = ms * 20000;
    resetCoreTimer();
    while(readCoreTimer() < wait);

}

void send2displays(unsigned char value)
 {
    unsigned int digit_low, digit_high;
    static const char display7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71}; // TODO
    static char displayFlag = 0; // static variable: doesn't loose its
    // value between calls to function
    digit_low = value & 0x0F;
    digit_high = value >> 4;
    // if "displayFlag" is 0 then send digit_low to display_low
    if (displayFlag == 0){
        LATD  = (LATD & 0xFF9F) | 0x0020; // bit 5 (menos significadtivos)
        LATB =  (LATB& 0x08FF) | (display7Scodes [digit_low] << 8 );
    else{
        LATD  = (LATD & 0xFF9F) |
    }


    }
    // else send digit_high to didplay_high
    // toggle "displayFlag" variable
 }

int main(void){ 
    // configure RB0-RB3 as inputs
    TRISB = TRISB | 0X000F;
    //configure RB8 - RB14 AS OUTPUTS
    TRISB = TRISB & 0x80FF;
    // configure RD5-RD6 as outputs
    TRISD = TRISD & 0xFF9F;    //1111 1111 1001 1111
    while(1)
    {
    send2displays(0x15);
    // wait 0.2s
    delay(200);
    }
 
}