function out = fun(t,y,N, A,hit,inpt_param,dt)
out = zeros(N,1);
out = A*y;
if hit > 0
   out(hit) = out(hit)+(t==0)*inpt_param;
   %out(N+hit) = out(N+hit)+(t==0)*inpt_param*dt;
   %{
   if t > 0.0008 && t < 0.0015
       [f, 1/area, mygaussian(t,inpt_param), f*(1/area)*mygaussian(t,inpt_param)]
   end
   %}
end

end

