n_size = [];
t_dot = [];
t_op = [];

n = [2^10 2^11 2^12 2^13 2^14 2^15 2^16 2^17 2^18 2^19 2^20];
n_length = length(n);

for i = 1:n_length
  x = ones(n(i), 1);
  y = ones(n(i), 1);

  sum_dot = 0;
  sum_op = 0;

  for j = 1:7
    tic;
    c = dot(n(i), x, y);
    sum_dot = sum_dot + toc;

    tic;
    c = x' * y;
    sum_op = sum_op + toc;
  endfor

  n_size = [n_size; n(i)];
  t_dot = [t_dot; (sum_dot / 7)];
  t_op = [t_op; (sum_op / 7)];

  clear x y;
endfor

data = [n_size t_dot t_op]
save "-ascii" "dot.dat" data;
clear all;
