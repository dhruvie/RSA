
Img=(imread("programmer.jpg"));
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
E=[];
le=1;
while(e!=0)
  E(le)=mod(e,10);
  le++;
  e=floor(e/10);
endwhile


function [X,i]= Mult(b,y,z,j,n,m)
  temp=0;x=0;
  for k=1:m-1
    x=b(j)*y(k)+temp;
    z(n++)=mod(x,10);
    temp=floor(x/10);
  endfor
  while(temp!=0)
    z(n++)=mod(temp,10);
    temp=floor(temp/10);
  endwhile
  i=n;
  X=z;
endfunction

function [Y,i] = add(x,value,n)
  k=1;
  while(value!=0)
    x(k++)=mod((x(k)+value),10);
    value=floor(value/10);
  endwhile
  if(k>n)
    n=k;
  endif
  i=n;
  Y=x;
endfunction

function Z= Copy(X,Y,n)
  for k=1:n-1
    X(k)=Y(k);
  endfor
  Z=X;
endfunction

function [Z,i]= EliminateZeros(X,n)
  k=0;i=n-1;
  while(i>=1)
    if(X(i)==0)
      k++;
    else
      break;
    endif
    i--;
  endwhile
  Z=X;
  i=n-k;
endfunction
    

function GCD= gcd(A,B,le,ltf)
  while(1)
    b=[0,1];r=zeros(200,1);lr=1;lq=1;a=1;result=zeros(200,1);q=zeros(100,1);q2=zeros(100,1);flag=1;temp=0;value=0;
    i=0;
    while(i<le-2)
      r(lr++)=B(ltf-le+2+i);
      i++;
    endwhile
    for i=0:ltf-le
      d=zeros(200,1);d2=zeros(200,1);ld=1;
      for j=1:2
        ld=j;
        [d,ld]=Mult(b,r,d,j,ld,lr);
      endfor
      [d,ld]=add(d,B(ltf-le-i+1),ld);
      temp=0;
      for j=0:9
        a=1;
        for k=1:le-1
          x=A(k)*(9-j)+temp;
          result(a++)=mod(x,10);
          temp=floor(x/10);
        endfor
        while(temp!=0)
          result(a++)=mod(temp,10);
          temp=floor(temp/10);
        endwhile
        d2=Copy(d2,d,ld);
        k=1; flag=1;
        t=a;
        if(ld<a)
          [result,a]=EliminateZeros(result,a);
          t=ld;
        endif
        while(k<t)
          if(a>ld)
            flag=0;
            break;
          endif
          x=d2(k)-result(k);
          if(x<0)
            if(k==(ld-1))
              flag=0;
              break;
            endif
            x=x+10;
            d2(k+1)=d2(k+1)-1;
          endif
          r(k++)=x;
        endwhile
        if(flag)
          Beta=9-j;
          lr=k;
          [r,lr]=EliminateZeros(r,k);
          break;
        endif
      endfor
      q2=Copy(q2,q,lq);
      temp=0;
      for j=1:2
        lq2=j;
        [q2,lq2]=Mult(b,q,q2,j,lq2,lq);
        lq=lq2;
      endfor
      q=Copy(q,q2,lq);
      [q,lq]=add(q,Beta,lq);
      [q,lq]=EliminateZeros(q,lq);
    endfor
    #Break Condition
    rem=0;
    i=lr;
    while(i>=1)
      if(r(i)==0)
        rem++;
      endif
      i--;
    endwhile
    if(rem==lr)
      i=le-1;
      value=0;
      while(i>=1)
        if(i!=1)
          value=A(i)*10+value;
        else
          value=A(i)+value;
        endif
        i--;
      endwhile
      GCD=value;
      GCD
      break;
    endif
    B=Copy(B,A,le);
    ltf=le;
    A=Copy(A,r,lr);
    le=lr;
  endwhile  
endfunction

while(1)
  if(gcd(E,Totientfunc,le,ltf)==1)
    break
  endif
  [E,le]=add(E,1,le);
  E
endwhile
E

