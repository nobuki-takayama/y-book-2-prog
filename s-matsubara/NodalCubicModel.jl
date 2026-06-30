using HomotopyContinuation

#Elliptic curve model
@var x
@var y
@var λ
@var z
@var ν
@var μ
@var s

f=(y-0.1)^2-x*(x-1)^2
S=[ν-s*x*z-λ*x*differentiate(f,x);μ-s*y*z-λ*y*differentiate(f,y);f;1-z*(1+x+y)]#likelihood equations combined with Lagrange multiplier
SS=System(S,parameters=[ν,μ,s])
#v=rand(Float64,2)
v=[0.783,0.745]
#a random parameter which gives two positive solutions with s=-1-sum(v)
sol=solve(SS,target_parameters=[v;-1-sum(v)])
sols=real_solutions(sol)#four solutions, two of which are negative
#variable order is x,y,z,λ, which can be checked by "variables(SS)"
function ispositive(x)
    x[1]>=0 && x[2]>=0
end
positive_sols=filter(ispositive,sols)
#two positive solutions

h=log(x^v[1]*y^v[2]*(1+x+y)^(-1-sum(v)))#log likelihood function
fx=differentiate(f,x)
fy=differentiate(f,y)
fxx=differentiate(f,x,2)
fxy=differentiate(fx,y)
fyy=differentiate(f,y,2)
gx=-fx/fy
gxx=-(fy^2*fxx-2*fx*fy*fxy+fx^2*fyy)/fy^3
hxx=differentiate(h,x,2)+2*differentiate(differentiate(h,y),x)*gx+differentiate(h,y,2)*gx^2+differentiate(h,y)*gxx
#second order derivative of h as a function of x derived from implicit function theorem

w1=positive_sols[1]
w2=positive_sols[2]
[hxx(x=>w1[1],y=>w1[2]);hxx(x=>w2[1],y=>w2[2])]
#both of them are negative

[h(x=>w1[1],y=>w1[2]);h(x=>w2[1],y=>w2[2]);h(x=>1,y=>0.1)]
#finding the maximum of h
