function d = generate_data_set(in_vec)
global X N dx T fs p f A B nin 
fset = f*ones(1,N/2);
hitset = in_vec;
hitidx = 1:nin;
tspan = linspace(0,T,T/(1/fs));
tspan = [tspan tspan(end)+tspan(2)];
x0 = zeros(N,1);

d.params = struct('X', X, 'N',N, 'dx',dx, 'T',T, 'f',f,'fset',fset, 'hitset', hitset,'tspan', tspan, 'x0', x0);
d.p = p;
d.Fs = fs;
for i = 1:nin
    uv = generate_data(tspan,hitidx(i),fset(i),A, B);
    d = setfield(d, strcat('key',num2str(hitset(i),'%02d')), uv(:,:));
end

end

