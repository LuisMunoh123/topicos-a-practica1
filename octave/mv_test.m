n_size = [];
t_mv = [];
t_op = [];

n = [2^3 2^4 2^5 2^6 2^7 2^8 2^9];
n_length = length(n);

for i = 1:n_length
  A = ones(n(i));
  x = ones(n(i), 1);

  sum_mv = 0;
  sum_op = 0;

  for j = 1:7
    tic;
    y = mv(n(i), n(i), A, x);
    sum_mv = sum_mv + toc;

    tic;
    y = A * x;
    sum_op = sum_op + toc;
  endfor

  n_size = [n_size; n(i)];
  t_mv = [t_mv; (sum_mv / 7)];
  t_op = [t_op; (sum_op / 7)];

  clear A x y;
endfor

data = [n_size t_mv t_op]
save "-ascii" "mv.dat" data;
clear all;
