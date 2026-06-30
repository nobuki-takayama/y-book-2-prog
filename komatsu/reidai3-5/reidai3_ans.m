global N T fs f A B nin
global n k sample_flag

N = 4; 
T = 0.01; 
fs = 1e5; 
p1 = 0.2;
p2 = -0.5;
p3 = -0.9; 
f = 1; 
estimation = 1; 
sample_flag = 1;
n = 50; 
k = 50; 

A = zeros(N,N);
A = [0.1 p1*p2 0 p3+p2;
    0 0 -0.1 0.2;
    p3-p2 -0.2 -0.1 p1*p2*p3;
    0.1 0 0.5 0.3];

B = [1 0;
    0 0;
    0 1;
    0 0];

C = [1 0 0 0;
    0 1 0 0];

save_flag = 1; %save:1, do not save:else

in_vec = mod(find(B),N);%1:d.params.N;
out_vec = round(find(C)/(N/2));%1:d.params.N;
hitkey = in_vec;

vec = [in_vec out_vec];
nin = length(in_vec);
nout = length(out_vec);
graphs = out_vec;

if nout*k ~= nin*n
    disp('=== Hankel matrix must be square ===')
    return
end
d = load_data(in_vec);
[ts, te, dt] = calc_ts_te_dt;
distance = d.params.X;

ys = generate_ys_test(nin, nout, n,k,ts, te, dt, d,vec);

h1 = zeros(nout*k, nin*n); % p*k, q*n
h2 = zeros(nout*k, nin*n); % p*k, q*n
if nout*k ~= nin*n
    disp('=== hankel matrix must be square ===')
    quit
end
for row = 1:k
    for col = 1:n
        rid = nout*(row-1)+1;
        cid = nin*(col-1)+1;
        int1 = col+row-1;
        int2 = col+row;
        h1(rid:rid+nout-1,cid:cid+nin-1) = select_block(int1,ys(:,3:end),nin);
        h2(rid:rid+nout-1,cid:cid+nin-1) = select_block(int2,ys(:,3:end), nin);
    end
end
if C*B ~= h1(nout,nin)
    disp('=== ERA is not correctly computed ===');
end

clear L d
if save_flag == 1
    save('./era_parameters.mat');
end

imagesc(h1, [min(h1(:)), max(h1(:))]);
colorbar;
display(h1)

function y = select_block(integer, ys, nin)
y = ys(:,(integer-1)*nin+1:(integer-1)*nin+nin);
end
