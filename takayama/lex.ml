with(Groebner):
F:=[x^2+y^2-4,x*y-1]; Basis(F,plex(x,y));
NormalForm(x*y,F,plex(x,y));  # normalFormの計算
