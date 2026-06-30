g=GroebnerBasis[{x^2+y^2-4,x*y-1},
     {x,y},MonomialOrder->Lexicographic]
PolynomialReduce[x*y,g,{x,y}][[2]]  (* normalFormの計算 *)
