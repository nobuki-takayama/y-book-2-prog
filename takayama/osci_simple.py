h=0.01
q=1.0;p=0.0;k=2.0;

for i in range(100):
    print((k*q**2+p**2)/2)
    p1= p - h*k*q
    q1= q + h*p
    p=p1; q=q1

