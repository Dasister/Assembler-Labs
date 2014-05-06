#include <iostream>

using namespace std;

extern "C" {
    void Lab2UW();
}

int a, b;
int res;

void Lab2_C() {
    cout << "C: " << endl;
    if (a < b)
        res = a / b - 1;
    else if (a > b)
        res = (a - 10) / b;
    else
        res = -300;
    cout << "\tRes: " << res << endl;
}

void Lab2_Asm() {
    Lab2UW();
    cout << "Asm: " << endl;
    cout << "\tRes: " << res << endl;
}


int main()
{
    cin >> a;
    cin >> b;
    Lab2_C();
    Lab2_Asm();
    return 0;
}

