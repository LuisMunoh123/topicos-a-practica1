#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#ifndef ARRAY_H
#include "../../cblas/array/array.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <sys/time.h>

static void my_mm_opt(const int m, const int n, const int k, const double* A, const double* B, double* C);
static int main_mm_opt(const int m, const int n, const int k, const int elements_type, const char* verbose);

int main(int argc, char** argv)
{
    fprintf(stdout, "mm_opt: optimized C program for matrix-matrix multiplication.\n");
    fputc('\n', stdout);

    if(argc != 6)
    {
        fprintf(stdout, "Use: mm_opt <m:int> <n:int> <k:int> <0|1|2> <on|off>.\n");
        return EXIT_FAILURE;
    }

    main_mm_opt(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), argv[5]);
    return EXIT_SUCCESS;
}

static void my_mm_opt(const int m, const int n, const int k, const double* A, const double* B, double* C)
{
    int i, j, p;

    for(i = 0; i < m; i++)
    {
        for(j = 0; j < n; j++)
            C[i * n + j] = 0.0;
    }

    for(i = 0; i < m; i++)
    {
        for(p = 0; p < k; p++)
        {
            double a_ip = A[i * k + p];
            int rowB = p * n;
            int rowC = i * n;

            for(j = 0; j < n; j++)
            {
                C[rowC + j] += a_ip * B[rowB + j];
            }
        }
    }
}

static int main_mm_opt(const int m, const int n, const int k, const int elements_type, const char* verbose)
{
    double* A = NULL;
    double* B = NULL;
    double* C = NULL;
    struct timeval start, finish;
    double runtime = 0.0;

    assert(m > 0);
    assert(n > 0);
    assert(k > 0);
    assert(elements_type >= ZEROS && elements_type <= RAND);

    A = array_new(m, k, elements_type);
    assert(A != NULL);

    B = array_new(k, n, elements_type);
    assert(B != NULL);

    C = array_new(m, n, ZEROS);
    assert(C != NULL);

    gettimeofday(&start, NULL);
    my_mm_opt(m, n, k, A, B, C);
    gettimeofday(&finish, NULL);

    if(strcmp(verbose, "on") == 0)
    {
        array_show(m, k, A, "A");
        array_show(k, n, B, "B");
    }

    array_show(m, n, C, "C");
    runtime = timeval_diff(&finish, &start);
    fprintf(stdout, "Data: %d %lf\n", m, runtime);

    free(A);
    free(B);
    free(C);

    return EXIT_SUCCESS;
}
