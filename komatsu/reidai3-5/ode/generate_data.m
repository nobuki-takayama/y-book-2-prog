function out = generate_data(tspan,hit,f,A, B)
global N
y0 = zeros(N,1);
x = discrete_fun(y0,A,B,hit,f,tspan);
out = x;
end

