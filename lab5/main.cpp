#include <iostream>
using namespace std;

extern "C" {
  void lab5();
}

double a, b;
int c;
double nominant, determinant, res;

void lab5_cpp() {
  cout << "C: " << endl;
  nominant = (double)(2 * a / b - 1);
  determinant = (double)(a - 28 + c);
  cout << "\tNumenator: " << fixed << nominant << endl;
  cout << "\tDeterminant: " << determinant << endl;
  cout << "\tRes: " << (double)(nominant / determinant) << endl;
}

void lab5_asm() {
  nominant = 0;
  determinant = 0;
  res = 0;
  lab5();
  cout << "Asm: " << endl;
  cout << "\tNumenator: " << nominant << endl;
  cout << "\tDeterminant: " << determinant << endl;
  cout << "\tRes: " << res << endl;  
}

int main(){
  cout << "Input a, b: ";
  cin >> a >> b;
  cout << "Input c: ";
  cin >> c;
  lab5_cpp();
  lab5_asm();
  return 0;
}
