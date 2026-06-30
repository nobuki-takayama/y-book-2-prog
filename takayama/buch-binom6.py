# buch-binom6.py
import numpy as np
import copy
N=6;
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
def pair_lcm(f,g):
    e=new_monom()
    for i in range(1,N+1):
        if (f[0][i]>g[0][i]):
            e[i]=f[0][i]
        else:
            e[i]=g[0][i] #LCM
    deg=0
    for i in range(1,N+1):
        deg = deg+e[i]
    return [deg,e]


def buchberger(f):
    nn=len(f)
    pairs=[]
    for i in range(nn-1,-1,-1):
        for j in range(nn-1,i-1,-1):
            pairs.insert(0,[pair_lcm(f[i],f[j]),[i,j]])
    g = copy.copy(f)
    while (len(pairs) > 0):
        pairs.sort()
        p=pairs[0][1]
        del pairs[0]
        sp = spolynomial(g[p[0]],g[p[1]])
        rem = reduce2(sp,g)
        if (rem != Zero):
            g.append(rem)
            for i in range(0,nn):
                pairs.insert(0,[pair_lcm(g[i],g[nn]),[i,nn]])
            nn=nn+1
    return to_minimal(g)



def is_reducible_by_set(f,set):
    n = len(set)
    for i in range(0,n):
        mon=is_reducible(f[0],set[i][0])
        if (mon != Zero):
            return [mon,i]
    return 0

def to_minimal(ss):
    s=copy.copy(ss)
    g=[]
    while (len(s) > 0):
        f=s[0]
        del s[0]
        mon = is_reducible_by_set(f,s+g)
        if (mon == 0):
            g.insert(0,f)
    return g

def eliminate1(g,m):
    if (g==Zero):
        return g
    for i in range(1,m+1):
        if (g[0][i] != 0):
            return Zero
    return g

def eliminate(g,m):
    g2=map(eliminate1,g,[m]*len(g))
    return [f for f in g2 if f != Zero]

def test4(m):
    N=6
    f=[[[1, 1,0, 0,0,0,0], [-1, 0,0, 1,0,0,0]],
       [[1, 1,1, 0,0,0,0], [-1, 0,0, 0,1,0,0]],
       [[1, 1,m, 0,0,0,0], [-1, 0,0, 0,0,1,0]],
       [[1, 1,m+1,0,0,0,0],[-1, 0,0, 0,0,0,1]]]
    g=buchberger(f)
    return eliminate(g,2)

t10=test4(3)
print(test4(3))
print("len=",len(t10))

            
"""
  test5(m,b) は A=[[1,1,1,1],[0,1,m,m+1]] できまる toric ideal をもとめ,
   Au=b, u>=0 をみたす u を一つ求める.
"""
def test5(m,b):
    bb=np.array(b)
    N=6
    f=[[[1, 1,0, 0,0,0,0], [-1, 0,0, 1,0,0,0]],
       [[1, 1,1, 0,0,0,0], [-1, 0,0, 0,1,0,0]],
       [[1, 1,m, 0,0,0,0], [-1, 0,0, 0,0,1,0]],
       [[1, 1,m+1,0,0,0,0],[-1, 0,0, 0,0,0,1]]]
    g=buchberger(f)
    b=[1,b[0],b[1],0,0,0,0]
    u=reduce2([b],g)
    u2=eliminate([u],2)
    a=np.matrix([[1,1,1,1],[0,1,m,m+1]])
    if (len(u2)==0):
        print("No solution for\n",a," u=", bb.T)
        return 0
    u=u2[0][0]
    u=np.array([u[3],u[4],u[5],u[6]])
    # check
#    print(a); print(u.T); print(bb.T)
    print("au-b=",a @ (u.T)-bb.T,", should be the 0 vector.")
    return u

print("m=2, b=[2,4]: ",test5(2,[2,4]))
print("m=5, b=[2,4]: ",test5(5,[2,4]))
print("m=5, b=[20,41]: ",test5(5,[20,41]))
    
