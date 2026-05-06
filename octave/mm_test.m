n_size = [];
t_mm = [];
t_op = [];

n = [2 4 8 16 32 64];
n_length = length(n);

for i = 1:n_length
  A = ones(n(i));
  B = ones(n(i));

  sum_mm = 0;
  sum_op = 0;

  for j = 1:7
    tic;
    C = mm(n(i), n(i), n(i), A, B);
    sum_mm = sum_mm + toc;

    tic;
    C = A * B;
    sum_op = sum_op + toc;
  endfor

  n_size = [n_size; n(i)];
  t_mm = [t_mm; (sum_mm / 7)];
  t_op = [t_op; (sum_op / 7)];

  clear A B C;
endfor

data = [n_size t_mm t_op]
save "-ascii" "mm.dat" data;
clear all;
