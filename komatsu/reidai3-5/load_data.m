function d = load_data(in_vec)
cd ./ode
d = generate_data_set(in_vec);%(X,N,dx,T,p,f);
cd ../
end