# buch-binom4.py
import numpy as np
import copy
N=5;
Verbose=True;
Zero=None;
def new_monom():
    return [0]*(N+1)

def comp(a,b):
    for i in range(1,N+1):
        if (a[i]>b[i]):
            return 1;
        if (a[i]<b[i]):
            return -1;
    return 0

def is_reducible(a,b):
    if (a==Zero):
        return Zero
    c=new_monom()
    c[0]=-a[0]//b[0];
    for i in range(1,N+1):
        c[i]=a[i]-b[i]
        if (c[i] < 0):
            return Zero;
    return c

# N=3
t1=[1,2,0,1];
t2=[1,1,2,3];
t3=[1,1,2,3];
t4=[1,2,0,1];
"""
print(is_reducible(t1,t2))
print(is_reducible(t3,t2))
print(is_reducible(Zero,t1))
"""

def mymul(a,b):
    if ((a==Zero) or (b==Zero)):
        return Zero
    c=new_monom()
    c[0]=a[0]*b[0]
    for i in range(1,N+1):
        c[i]=a[i]+b[i]
    return c

"""
print(mymul(t1,t2))
print(mymul(Zero,t2))
"""

def to_binom(a,b):
    r=comp(a,b)
    if (r==1):
        return [a,b]
    elif (r==-1):
        return [b,a]
    else:
        c=new_monom()
        c[0]=a[0]+b[0]
        if (c[0]==0):
            return Zero
        for i in range(1,N+1):
            c[i]=a[i];
        return [c]

def reduce(f,g):
    if (f == Zero):
        return f
    c=is_reducible(f[0],g[0])
    if (c == Zero):
        return f
    if (len(f)==1):
        return [mymul(c,g[1])]
    a=f[1]
    b=mymul(c,g[1])
    return to_binom(a,b)

t5=[[1,2,0,1],[-1,1,1,1]]
t6=[[1,1,0,1],[-1,0,0,1]]
"""
print(reduce(t5,t6))
print(reduce(t5,t5))
"""

def reduce2(f,g):
    reduced=True
    while (reduced):
        reduced=False
        for i in range(0,len(g)):
            if (f==Zero):
                return f
            c=is_reducible(f[0],g[i][0])
            if (c != Zero):
                reduced=True
                fnew=reduce(f,g[i]);
                if (Verbose):
                    print(f, " --> ",fnew," by ",g[i],"\n",end='')
                f=fnew

    ftop=f[0]
    if (len(f)==1):
        return f
    frest=reduce2([f[1]],g)
    if (frest==Zero):
        return f
    return [ftop,frest[0]]

# N=7
tset7=[
  [[1, 1,0, 0,0,0],[-1, 0,0, 1,0,0]],
  [[1, 1,1, 0,0,0],[-1, 0,0, 0,1,0]],
  [[1, 1,2, 0,0,0],[-1, 0,0, 0,0,1]]
]
t8=[[1, 2,2, 0,0,0],[-1, 0,0, 0,2,0]];
t9=[[1, 2,2, 0,0,0]]

# print(reduce2(t8,tset7))

def spolynomial(f,g):
    e=new_monom()
    e=np.array(e)
    for i in range(1,N+1):
        if (f[0][i]>g[0][i]):
            e[i]=f[0][i]; 
        else: 
            e[i]=g[0][i]; 
    # e is lcm
    print(e,"  ",f[0])
    e1=e-np.array(f[0])
    e1[0]=g[0][0]
    e2=e-np.array(g[0])
    e2[0]=f[0][0]
    e1=e1.tolist()
    e2=e2.tolist()
    
    a=mymul(e1,f[1])
    b=mymul(e2,g[1])
    b[0]=-b[0]
    return to_binom(a,b)

# print(spolynomial(tset7[0],tset7[1]))

def buchberger(f):
    nn=len(f)
    pairs=[]
    for i in range(nn-1,-1,-1):
        for j in range(nn-1,i-1,-1):
            pairs.insert(0,[i,j])
    g = copy.copy(f)
    while (len(pairs) > 0):
        p=pairs[0]
        del pairs[0]
        sp = spolynomial(g[p[0]],g[p[1]])
        rem = reduce2(sp,g)
        if (rem != Zero):
            g.append(rem)
            for i in range(0,nn):
                pairs.insert(0,[i,nn])
            nn=nn+1
    return g

print("GB is ",buchberger(tset7))
print("The input tset7 is ",tset7)
