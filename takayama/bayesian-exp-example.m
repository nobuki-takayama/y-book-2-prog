Integrate[
  Exp[-w*xsum]*Exp[-(w - 1/2)^2]*w^(-n/2), {w, -Infinity,Infinity}]/(Sqrt[Pi]^(n + 1))

Integrate[
 Exp[-w*xsum]*Exp[-(w - 1/2)^2]*w^(-(n+1)/2)*Exp[-x^2*w], {w, -Infinity,Infinity}]/(Sqrt[Pi]^(n+1))

(* データ数 n=100, xsum-1=100-1 での上記積分に出てくる 1F1 のグラフ *)
Plot[Hypergeometric1F1[(2 - 100)/4, 1/2, (x^2+(100-1)^2/4], {x, -2, 2}]

