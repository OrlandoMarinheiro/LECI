void delay(unsigned int ms){
    resetCoreTimer();
    while (readCoreTimer() < ms * 20000);
}

int main(void){
    int cnt1 = 0;
    int cnt5 = 0;
    int cnt10 = 0;
while (1)
{
    delay(100);         // 100ms delay 10Hz
    putChar('\r');
    printInt(cnt10, 10 | 5 << 16);
    cnt10++;

    if (cnt10 % 2 == 0)
    {
        cnt5++;
    }
    
    if (cnt10 % 10 == 0)
    {
        cnt1++;
    }

    putChar(' ');
    printInt(cnt5, 10 | 5 << 16);
    putChar(' ');
    printInt(cnt1, 10 | 5 << 16);
}

return 0;

}