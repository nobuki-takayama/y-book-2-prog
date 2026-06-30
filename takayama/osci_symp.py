h=0.01
q=1.0;p=0.0;k=2.0;

##Ref: Hailer 常微分方程式の数値解法I p.303, II.16 (16.5d). k^2 -> k.
for i in range(100):
    print((k*q**2+p**2)/2)
    d=1/4*k*h**2+1;
    p1= p*(-1/4*k*h**2+1)/d+q*(-k*h)/d;
    q1= p*h/d + q*(-1/4*k*h**2+1)/d;
    p=p1; q=q1

