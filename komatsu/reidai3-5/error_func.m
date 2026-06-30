function out = error_func(tp, At,Ct, Bt1,Bt2)
global A N

%{
Constract 
[
Tt(3,3) Tt(3,4);
Tt(4,3) Tt(4,4)
]
%}
function mat = vec2mat_t1(tp,M)
mat = zeros(M,M);
for i =1:M
   mat(i,:) = tp((i-1)*M+1:i*M);
end
end

t3 = vec2mat_t1(tp(1:(N^2)/4),N/2);
Tt = [Ct; t3 ([0 1;0 0]-t3*Bt1)*inv(Bt2)];
Ah = Tt*At*inv(Tt);
Th = [1 0 0 0;
    0 1 0 0;
    0 tp(end) 1 tp(end-2);
    0 tp(end-1) 0 tp(end-3)];
Af = Th*Ah*inv(Th);
res1 = [Af(1:2,1) - A(1:2,1);Af(4,1)-A(4,1)];
res2 = Af(2:4,2) - A(2:4,2);
res3 = Af(:,3)-A(:,3);
res4 = [Af(2,4)-A(2,4); Af(4,4)-A(4,4)];
res5 = Af(1,2)*Af(1,4)+Af(1,2)*Af(3,1)-2*Af(3,4); %G1
out = [res1;res2; res3;res4; res5];
end

