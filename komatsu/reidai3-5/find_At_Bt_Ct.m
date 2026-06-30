function [At, Bt, Ct,diags, Pt, Qt] = find_At_Bt_Ct(h1,h2,r,nin,nout)
[U, S, V] = svd(h1);
diags = diag(S);
St = S(1:r, 1:r);
Ut = U(:,1:r);
Vt = V(:,1:r);
Pt = Ut*sqrt(St);
P = U*sqrt(S);
Qt = (sqrt(St)*Vt');%sqrt(St)*Vt';
Q = sqrt(S)*V';
At =inv(sqrt(St))*Ut.'*h2*Vt*inv(sqrt(St));
Bt = Qt(:,1:nin);
Ct = Pt(1:nout,:);
norm(h1 - Ut*St*Vt');
end