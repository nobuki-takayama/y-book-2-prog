function out = discrete_fun(y0,A,B,hit,f,tspan)
global N nin
out = zeros(length(tspan),N);
out(1,1:N) = y0.'
u = zeros(nin,1); % [x(1) x(3)]
u(hit) = f;
for i = 2:length(tspan)
    if i == 2
        out(i,:) = (A*out(i-1,:)'+B*u)';
    else
       out(i,:) = (A*out(i-1,:)')'; 
    end
end
end