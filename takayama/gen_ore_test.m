<< RISC`HolonomicFunctions`
(* 以下は gen_ore.rr test_gaussHG(); で生成 *)
ann={OrePolynomial[{{x-1,{1,0}},{t^2-t,{0,1}},{(-a-b-c)*t+a,{0,0}}},OreAlgebraObject[{Der[x],Der[t]},Expand, #1 + #2 &, Expand[#1*#2] &,  None], DegreeLexicographic],OrePolynomial[{{-t+1,{1,0}},{t^3-t^2,{0,1}},{(-a-b-c)*t^2+(a+c)*t,{0,0}}},OreAlgebraObject[{Der[x],Der[t]},Expand, #1 + #2 &, Expand[#1*#2] &,  None], DegreeLexicographic],OrePolynomial[{{(t^3-t^2)*x-t^2+t,{0,1}},{((-a-b-c)*t^2+(a+c)*t)*x+(a+b)*t-a,{0,0}}},OreAlgebraObject[{Der[x],Der[t]},Expand, #1 + #2 &, Expand[#1*#2] &,  None], DegreeLexicographic]}

FindCreativeTelescoping[ann,{Der[t]}]
