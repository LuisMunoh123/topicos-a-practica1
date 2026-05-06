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

static void my_mv_lu(const int m, const int n, const double* A, const double* x, double* y);
static int main_mv_lu(const int m, const int n, const int elements_type, const char* verbose);

int main(int argc, char** argv)
{
    fprintf(stdout, "mv_lu: manual C program for matrix-vector multiplication with loop unrolling.\n");
    fputc('\n', stdout);

    if(argc != 5)
    {
        fprintf(stdout, "Use: mv_lu <m:int> <n:int> <0|1|2> <on|off>.\n");
        return EXIT_FAILURE;
    }

    main_mv_lu(atoi(argv[1]), atoi(argv[2]), atoi(argv[3]), argv[4]);
    return EXIT_SUCCESS;
}

static void my_mv_lu(const int m, const int n, const double* A, const double* x, double* y)
{
    int i, j;
    int limit = n - (n % 4);

    for(i = 0; i < m; i++)
    {
        double sum = 0.0;
        int base = i * n;

        for(j = 0; j < limit; j += 4)
        {
            sum += A[base + j]     * x[j]
                 + A[base + j + 1] * x[j + 1]
                 + A[base + j + 2] * x[j + 2]
                 + A[base + j + 3] * x[j + 3];
        }

        for(j = limit; j < n; j++)
        {
            sum += A[base + j] * x[j];
        }

        y[i] = sum;
    }
}

static int main_mv_lu(const int m, const int n, const int elements_type, const char* verbose)
{
    double* A = NULL;
    double* x = NULL;
    double* y = NULL;
    struct timeval start, finish;
    double runtime = 0.0;

    assert(m > 0);
    assert(n > 0);
    assert(elements_type >= ZEROS && elements_type <= RAND);

    A = array_new(m, n, elements_type);
    assert(A != NULL);

    x = array_new(n, 1, elements_type);
    assert(x != NULL);

    y = array_new(m, 1, ZEROS);
    assert(y != NULL);

    gettimeofday(&start, NULL);
    my_mv_lu(m, n, A, x, y);
    gettimeofday(&finish, NULL);

    if(strcmp(verbose, "on") == 0)
    {
        array_show(m, n, A, "A");
        array_show(n, 1, x, "x");
    }

    array_show(m, 1, y, "y");
    runtime = timeval_diff(&finish, &start);
    fprintf(stdout, "Data: %d %lf\n", m, runtime);

    free(A);
    free(x);
    free(y);

    return EXIT_SUCCESS;
}
