using Oscar
R, (θ1,θ2) = polynomial_ring(QQ, ['θ1', 'θ2']) #多項式環の宣言
θ=[θ1,θ2]
ν=rand(Int64,2)
s=rand(Int64)
z=rand(Int64,4)   #係数をランダムに選ぶ
Z_A = z[1]+z[2]*θ[1]+z[3]*θ[2]+z[4]*θ[1]*θ[2]   
eq = [-s*θ[i]*derivative(Z_A,θ[i])+ν[i]*Z_A for i=1:2]
o = lex([θ1])*lex([θ2]) #項順序の宣言
I=ideal(R,eq)
G=groebner_basis(I, ordering = o)#項順序oに関するGroebner基底






using HomotopyContinuation
n=2; @var θ[1:n]; @var s; @var ν[1:n]   #変数とパラメーターの宣言
z=rand(Float64,4)   #係数をランダムに選ぶ
Z_A = z[1]+z[2]*θ[1]+z[3]*θ[2]+z[4]*θ[1]*θ[2]               
logL = -s*log(Z_A)+sum([ν[i]*log(θ[i]) for i=1:2])   #対数尤度函数
sys = System(differentiate(logL,θ),parameters=[s;ν])   #尤度方程式
R=monodromy_solve(sys)  #monodromy法
start_pars=parameters(R)
start_sols=solutions(R)
R2=solve(sys, start_sols; start_parameters=start_pars, target_parameters=[s_goal;ν_goal]) #数値的解析接続
