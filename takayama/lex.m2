clearAll
R=QQ[x,y,MonomialOrder=>Lex]
I=ideal(x^2+y^2-4,x*y-1)
G=gb I
gens G
J=eliminate({x},I)
remainder(matrix{{x*y}},G) -- normalFormの計算
