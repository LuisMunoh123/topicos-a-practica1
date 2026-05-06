function C = mm(m, n, r, A, B)
  if m <= 0 || n <= 0 || r <= 0
    error("arguments 1, 2 and 3 must be greater than zero.");
  endif

  [rowsA, colsA] = size(A);
  if rowsA < m
    error("rows of argument 4 is less than argument 1.");
  endif
  if colsA < r
    error("columns of argument 4 is less than argument 3.");
  endif

  [rowsB, colsB] = size(B);
  if rowsB < r
    error("rows of argument 5 is less than argument 3.");
  endif
  if colsB < n
    error("columns of argument 5 is less than argument 2.");
  endif

  C = zeros(m, n);

  for i = 1:m
    for j = 1:n
      for k = 1:r
        C(i, j) = C(i, j) + A(i, k) * B(k, j);
      endfor
    endfor
  endfor
endfunction
