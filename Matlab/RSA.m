
Img=(imread("programmer.jpg"));
#figure, imshow(Img)

#Step 1: Find p and q, such that they are large prime numbers
p=floor(10000+(1000000-10000)*rand());
p;
q=floor(10000+(1000000-10000)*rand());
q;

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

N=zeros(1,200);
Totientfunc= zeros(1,200);
function [Result,length]= Multiplication(A,B,C,lp,lq)
  C=zeros(1,200);k=1;temp=0;
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
[N,ln]=Multiplication(P,Q,lp,lq);
disp("Totientfunc:")
[Totientfunc,ltf]=Multiplication(P1,Q1,Totientfunc,lp,lq,0,0);

#Totientfunc=[6,9,0,4,0,2,3,4,3,5,4,6]
#ltf=13;
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
E
le

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
    value=(x(k)+value);
    x(k++)=mod(value,10);
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

function [Qoutient,lk]= Division(D,Dl1,Dl2)
  b=[0,1];r=zeros(200,1);lr=1;lq=1;a=1;result=zeros(200,1);q=zeros(100,1);q2=zeros(100,1);flag=1;temp=0;value=0;
  i=0;
  while(i<Dl2-2)
    r(lr++)=D(1,Dl1-Dl2+2+i);
    i++;
  endwhile
  for i=0:Dl1-Dl2
    d=zeros(200,1);d2=zeros(200,1);ld=1;
    for j=1:2
      ld=j;
      [d,ld]=Mult(b,r,d,j,ld,lr);
    endfor
    [d,ld]=add(d,D(1,Dl1-Dl2-i+1),ld);
    j=ld-1;
    temp=0;
    for j=0:9
      a=1;
      for k=1:Dl2-1
        x=D(2,k)*(9-j)+temp;
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
  i=lq-1;
  disp("Q")
  while(i>=1)
    q(i--)
  endwhile
  Qoutient=q;
  lk=lq;
endfunction

function [Result,f]= Subtract(A,B,Z,n,flag)
  for i=1:n-1
    x=B(1,i)-A(1,i);
    if(x<0)
      if(flag==0 && i==(n-1))
        flag=1;
        break;
      endif
      x=x+10;
      B(1,i+1)=B(1,i+1)-1;
    endif
    Z(i)=x;
  endfor
  Result=Z;
 # disp("ZZZ")
  #Z
  f=flag;
endfunction

function [Result,l]=addArray(X,Y,n,Z)
  i=1;temp=0;x=0;
  while(i!=n)
    x=X(1,i)+Y(i)+temp;
    Z(i++)=mod(x,10);
    temp=floor(x/10);
  endwhile
  while(temp!=0)
    Z(i++)=mod(temp,10);
    temp=floor(temp/10);
  endwhile
  Result=Z;
  l=i;
endfunction

function [Result,l,Sign]=Sub(A,B,al,bl,Aneg,Bneg)
  A2=zeros(2,100);C=zeros(1,200);Cneg=0;
  [B,bl]=EliminateZeros(B,bl);
  if((Aneg(1)==1 && Bneg==0) || (Aneg(1)==0 && Bneg==1))
    if(Aneg(1)==1)
      if(al>=bl)
        [C,cl]=addArray(A,B,al,C);
      else
        [C,cl]=addArray(A,B,bl,C);
      endif
      Cneg=1;
    else
      if(al>=bl)
        [C,cl]=addArray(A,B,al,C);
      else
        [C,cl]=addArray(A,B,bl,C);
      endif
      Cneg=0;
    endif
  elseif(al==bl)
    flag=0;
    for i=1:al-1
      A2(1,i)=A(1,i);
    endfor
    if(flag==0)
      [C,flag]=Subtract(B,A2,C,al,flag);
      [C,cl]=EliminateZeros(C,al);
      #disp("ok")
      #C
      if(Aneg(1)==1 && Bneg==1)
        Cneg=1;
      else
        Cneg=0;
      endif
    endif
    if(flag)
      [C,flag]=Subtract(A,B,C,bl,1);
      #disp("ok2")
      #C
      [C,cl]=EliminateZeros(C,al);
      if(Aneg(1)==1 && Bneg==1)
        Cneg=0;
      else
        Cneg=1;
      endif
    endif
  elseif(al>bl)
    [C,flag]=Subtract(B,A,C,al,1);
    [C,cl]=EliminateZeros(C,al);
    Cneg=0;
  else
    [C,flag]=Subtract(A,B,C,bl,1);
    [C,cl]=EliminateZeros(C,bl);
    Cneg=1;
  endif  
  Result=C;
  l=cl;
  Sign=Cneg;
endfunction


function [key,l,Status]=private(A,B,le,ltf)
  X=zeros(2,100);
  X(1,1)=1; X(2,1)=0;
  Xl1=2; Xl2=2;
  Xneg=zeros(2);
  Y=zeros(2,100);
  Y(1,1)=0; Y(2,1)=1;
  Yl1=2; Yl2=2;
  Yneg=zeros(2);
  D=zeros(2,100);
  Dneg=zeros(2);
  for i=1:ltf-1
    D(1,i)=B(i);
  endfor
  Dl1=ltf;
  for i=1:le-1
    D(2,i)=A(i);
  endfor
  D
  Dl2=le;
  K=zeros(200,1);
  [K,lk]=Division(D,Dl1,Dl2);
  while(1)
    #A
    C=zeros(1,100);Cneg=0;
    temp=0;k=1;
    for i=1:Xl2-1
      k=i;
      for j=1:(lk-1)
        x=X(2,i)*K(j)+temp+C(k);
        C(k++)=mod(x,10);
        temp=floor(x/10);
      endfor
      while(temp!=0)
        C(k++)=mod(temp,10);
        temp=floor(temp/10);
      endwhile
    endfor
    if(Xneg(2)==1)
      Cneg=1;
    endif
    [C,lc,Cneg]=Sub(X,C,Xl1,k,Xneg,Cneg);
    i=lc-1;
    disp("X:C")
    Cneg
    lc
    while(i>=1)
      C(i)
      i=i-1;
    endwhile
    for i=1:Xl2-1
      X(1,i)=X(2,i);
    endfor
    Xl1=Xl2;
    Xneg(1)=Xneg(2);
    for i=1:lc-1
      X(2,i)=C(i);
    endfor
    Xl2=lc;
    Xneg(2)=Cneg;
    Xneg;
    Xl1;
    Xl2;
    X;
    
    #B
    C=zeros(1,100);Cneg=0;
    temp=0;k=1;
    for i=1:Yl2-1
      k=i;
      for j=1:(lk-1)
        x=Y(2,i)*K(j)+temp+C(k);
        C(k++)=mod(x,10);
        temp=floor(x/10);
      endfor
      while(temp!=0)
        C(k++)=mod(temp,10);
        temp=floor(temp/10);
      endwhile
    endfor
    if(Yneg(2)==1)
      Cneg=1;
    endif
    [C,lc,Cneg]=Sub(Y,C,Yl1,k,Yneg,Cneg);
    for i=1:Yl2-1
      Y(1,i)=Y(2,i);
    endfor
    Yl1=Yl2;
    Yneg(1)=Yneg(2);
    for i=1:lc-1
      Y(2,i)=C(i);
    endfor
    Yl2=lc;
    Yneg(2)=Cneg;
    Yneg;
    Yl1;
    Yl2;
    Y;
    
    #D
    C=zeros(1,200);Cneg=0;
    temp=0;k=1;
    for i=1:Dl2-1
      k=i;
      for j=1:(lk-1)
        x=D(2,i)*K(j)+temp+C(k);
        C(k++)=mod(x,10);
        temp=floor(x/10);
      endfor
      while(temp!=0)
        C(k++)=mod(temp,10);
        temp=floor(temp/10);
      endwhile
    endfor
    [C,lc,Cneg]=Sub(D,C,Dl1,k,Dneg,Cneg);
    for i=1:Dl2-1
      D(1,i)=D(2,i);
    endfor
    Dl1=Dl2;
    Dneg(1)=Dneg(2);
    for i=1:k
      D(2,i)=C(1,i);
    endfor
    Dl2=lc;
    Dneg(2)=Cneg;
    #D
    #Dl2
    
    #break 
    if((Dl2-1)==1 && D(2,1)==1)
     for i=1:Yl2-1
      Y(1,i)=Y(2,i);
     endfor
     Yl1=Yl2;
     Yneg(1)=Yneg(2);
     key=Y;
     l=Yl1;
     Status=Yneg
     break;
    endif
    
    #k
    [K,lk]=Division(D,Dl1,Dl2);
  endwhile
endfunction

[Dkey,Dl,Sign]=private(E,Totientfunc,le,ltf);
Dkey
i=Dl-1;
while(i>=1)
  Dkey(1,i)
  i--;
endwhile

#Check wheteher D is >Totient function or not. Or whether Dkey is negative or Positive.

if(Sign(1)==1)
  Sign(1)=0;
  #Sub(Dkey,Totientfunc,Dl,ltf,Sign,0);
  Dkey
elseif(Dl>=ltf)
  disp("ok")
endif

