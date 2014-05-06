#include <iostream>

using namespace std;

// (2*a/b-1)/(a-28+c)

extern "C" {
    void lab1UB();
}

int a, b, c;
short nominator, denominator, res;

void lab1_C() {
    nominator = (2 * a / b - 1);
    denominator = (a - 28 + c);
    cout << "C: " << endl;
    cout << "\tNominator: " << nominator << endl;
    cout << "\tDenominator: " << denominator << endl;
    cout << "\tRes: " << nominator / denominator << endl;
}

void lab1_ASM() {
    lab1UB();
    cout << "ASM: " << endl;
    cout << "\tNominator: " << nominator << endl;
    cout << "\tDenominator: " << denominator << endl;
    cout << "\tRes: " << res << endl;
}

int main()
{
    cin >> a;
    cin >> b;
    cin >> c;
    lab1_C();
    lab1_ASM();
    return 0;
}

