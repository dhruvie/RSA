
Img=(imread("p.jpg"));
#figure, imshow(Img)
#format long

#Step 1: Find p and q, such that they are large prime numbers
p=floor(1000000+(100000000-1000000)*rand());
p
q=floor(1000000+(100000000-1000000)*rand());
q

#if p is even, increase by 1 and if q is even increase by 1
if(mod(p,2)==0)
  p=p+1;
endif
if(mod(q,2)==0)
  q=q+1;
endif

#check if p is prime or not.. find prime no!
while(1)
  sqr=floor(sqrt(p));
  flag=0;
  for i = 2:sqr
    if(mod(p,i)==0)
      flag=1;
      break
    endif
  endfor
  if(flag==0)
    break
  endif
  p=p+2;
endwhile
p

#check if q is prime or not.. find prime no!
while(1)
  sqr=floor(sqrt(q));
  flag=0;
  for i = 2:sqr
    if(mod(q,i)==0)
      flag=1;
      break
    endif
  endfor
  if(flag==0)
    break
  endif
  q=q+2;
endwhile
q

lp=1;
P=[];
while(p!=0)
  P(lp)=mod(p,10);
  lp++;
  p=floor(p/10);
endwhile
  
Q=[];
lq=1;
while(q!=0)
  Q(lq)=mod(q,10);
  lq++;
  q=floor(q/10);
endwhile
P
Q

P1=P;
P1(1)=P1(1)-1;
Q1=Q;
Q1(1)=Q1(1)-1;

#Step 2:Calculate The Value of n and Euler Totient Function

N=zeros(200,1);
Totientfunc= zeros(200,1);
function [Result,length]= Multiplication(A,B,C,lp,lq,k,temp)
  for i=1:(lp-1)
    k=i;
    for j=1:(lq-1)
      x=A(i)*B(j)+temp+C(k);
      C(k)=mod(x,10);
      k++;
      temp=floor(x/10);
    endfor
    while(temp!=0)
      C(k)=mod(temp,10);
      k++;
      temp=floor(temp/10);
    endwhile
  endfor
  Result=C;
  length=k;
  i=k-1;
  while(i>=1)
    C(i)
    i=i-1;
  endwhile
endfunction

disp("N:")
[N,ln]=Multiplication(P,Q,N,lp,lq,0,0);
disp("Totientfunc:")
[Totientfunc,ltf]=Multiplication(P1,Q1,Totientfunc,lp,lq,0,0);


#Step 3: Set e such that 1 < e < Totientfunc  and gcd(e,Totientfunc)=1
# i.e., e should be co-prime.

e=floor(1000+(100000-1000)*rand());
function result= gcd(A,B,ltf)
  while(
    
    
    
  
endfunction

while(1)
  if(e!=p && e!=q e<Totientfunc && gcd(e,Totientfunc,ltf-1)==1)
    break
   endif
   e=e+1;
endwhile
e
