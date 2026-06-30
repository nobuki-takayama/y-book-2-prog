load("era_parameters.mat")
[At,Bt,Ct,diags, Pt, Qt] = find_At_Bt_Ct(h1,h2,N,nin,nout);
Bt1 = Bt(1:N/2,:);
Bt2 = Bt(N/2+1:end,:);
save('svd.mat','At','Bt','Ct','diags', 'Pt', 'Qt')

display(At)
display(Bt)
display(Ct)
