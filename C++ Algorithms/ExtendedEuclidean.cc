// C++ program to demonstrate working of 
// extended Euclidean Algorithm 

// This Algorithm is only meant to calculate private key (d), therefore if gcd(eulerTotient,E)!=1. 
// The program will not work.


#include <bits/stdc++.h> 
using namespace std; 
#define int long long 
// Function for extended Euclidean Algorithm 
int gcdExtended(int E, int eulerTotient) 
{ 
	int a1=1,a2=0,b1=0,b2=1,d1=eulerTotient,d2=E,temp;

	while(d2!=1)
	{
		//k
		int k=(d1/d2);

		//a
		temp=a2;
		a2=a1-(a2*k);
		a1=temp;

		//b
		temp=b2;
		b2=b1-(b2*k);
		b1=temp;

		//c
		temp=d2;
		d2=d1-(d2*k);
		d1=temp;

	}
	cout<<"X:"<<a2<<"\nY:"<<b2<<endl;
	// b2 i.e, Y is our private key d
	int d=b2;
	// d=b2 (d is our private Key)
	// And there are two conditions which d must satisfy if they occur.
	// 1. if d>eulerTotient   d=dMod(eulerTotient)
	// 2. if d<0   d=d+eulerTotient

	if(d>eulerTotient)
		d=d%eulerTotient;
	else if(d<0)
		d=d+eulerTotient;

	cout<<"Private Key is:"<<d<<endl;
} 

// Driver Code 
signed main() 
{ 
	int E,eulerTotient;
	cout<<"Enter eulerTotient:\n";
	cin>>eulerTotient;
	cout<<"Enter E:\n";
	cin>>E;
	gcdExtended(E,eulerTotient);
	return 0; 
} 
