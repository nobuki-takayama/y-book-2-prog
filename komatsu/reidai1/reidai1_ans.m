%シンボリック変数の定義
syms T32 T34 T42 T44
p = sym("p", [1,3]);
q = sym("q", [1,3]);

%Ap, Aq, Tstarの定義
Ap = [
    0.1 p(1)*p(2) 0 p(3)+p(2);
    0 0 -0.1 0.2;
    p(3)-p(2) -0.2 -0.1 p(1)*p(2)*p(3);
    0.1 0 0.5 0.3
    ];
Tstar = [
    1 0 0 0;
    0 1 0 0;
    0 T32 1 T34;
    0 T42 0 T44
    ];

display(Ap)
display(Tstar)

%
eq = inv(Tstar)*Ap*Tstar - Ap;
answer = solve(eq,[T32, T34, T42, T44]);
Tstar_solved = subs(Tstar,[T32, T34, T42, T44],[answer.T32, answer.T34, answer.T42, answer.T44]);
display([answer.T32, answer.T34, answer.T42, answer.T44])
if eval(Tstar_solved) == eye(4)
    display("structurally identifiable")
else
    display("structurally unidentifiable")
end

