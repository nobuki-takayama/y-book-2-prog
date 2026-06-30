import numpy as np
from scipy.special import beta
import matplotlib.pyplot as plt
a=0.5; b=0.1; n=100
def bprob(mu):
  z=np.zeros(n)
  z[0]=mu**a*(1-mu)**b/beta(a+1,b+1)
  for m in range(0,n-1):
    z[m+1]=z[m]*mu*(1-mu)*(a+m+1+b+m+2)*(a+m+1+b+m+1)/((a+m+1)*(b+m+1))
  return z
#
z1=bprob(0.5)
z2=bprob(0.4)
z3=bprob(0.7)
fig, ax = plt.subplots()
ax.plot(z1,label="mu=0.5")
ax.plot(z2,label="mu=0.4")
ax.plot(z3,label="mu=0.7")
ax.legend()
plt.show()
