mnp=5 (* max number of persons at peak *)
(* mnp = 5 ~ 350.  mnp を大きくすると sharp になる. *)
x=Table[Floor[Exp[-(i- 75)^2/100]*mnp],{i,30,95}];
Plot[Exp[-(i-75)^2/100]*mnp,{i,30,95}]
n=Length[x]
xx={}; For[i=1,i<=n, i++, For[j=1,j<=x[[i]],j++,xx=Append[xx,i+29]]]; (*Print[xx]*)
nn=Length[xx]
z1=nn+1
mn=N[Total[xx]/z1]
vn=Total[xx^2]
mu=80
z2=N[mn+mu/(nn+1)]
z3=vn+mu^2
Plot[Exp[(-z1*(w-z2)^2-z3+z1*z2^2)/10000],{w,70,85}] 
(* 引数が大きくなりすぎないように 10000 で割ってる *)

(* wolfram cloud, 2024-04-27-bayes-graph.nb *)
