// To Check If a Given Number is Prime or Not By Miller Rabin Primality Test
#include<bits/stdc++.h>
using namespace std;
#define int long long
int power(int a, int d, int Mod)
{
	int result=1;
	a=a%Mod;
	while(d!=0)
	{
		if(d&1)
			result=((result%Mod)*(a%Mod))%Mod;
		a=((a%Mod)*(a%Mod))%Mod;
		d>>=1;
	}
	return result;
}
bool MillerRabin(int n, int d)
{
	int a; // which is choosen randomly between 2 to n-2
	//  for learning purpose we are choosing a from 1 to n-2;
	for(a=2; a<n-1; ++a)
	{
		int x=power(a,d,n);
		if(x==1 || x==n-1)
			return true;
		else
		{
			int y=d,flag=1;
			while(y!=n-1) // This loop runs r-1 times, which is same if we increase (d*2) d by 2. Therefore, it's not important to find r.
			{
				x=((x%n)*(x%n))%n;
				if(x==1)
					return false;
				if(x==n-1)
					return true;
				y<<=1;
			}
		}
	}
	return false;
}
bool isPrime(int n,int k)
{
	if(n<=1 || n==4)
		return false;
	if(n<=3)
		return true;

// Find d and r such that d*(2^r)=n-1;
	int d=n-1;
	while(d%2==0)
		d>>=1;
	cout<<"d:"<<d<<endl;
	for(int i=0; i<k; ++i)
	{
		if(!(MillerRabin(n,d)))
			return false;
	}
	return true;
}
signed main()
{
	int n,k=1; // k is used for accuracy puropse.
	cout<<"Enter Any Number:\n";
	cin>>n;
	if(isPrime(n,k))
		cout<<"Prime\n";
	else
		cout<<"Composite\n";
}