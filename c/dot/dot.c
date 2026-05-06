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

static double my_dot(const int n, const double* x, const double* y);
static int main_dot(const int n, const int elements_type, const char* verbose);

int main(int argc, char** argv)
{
    fprintf(stdout, "dot: manual C program for dot product.\n");
    fputc('\n', stdout);

    if(argc != 4)
    {
        fprintf(stdout, "Use: dot <n:int> <0|1|2> <on|off>.\n");
        return EXIT_FAILURE;
    }

    main_dot(atoi(argv[1]), atoi(argv[2]), argv[3]);
    return EXIT_SUCCESS;
}

static double my_dot(const int n, const double* x, const double* y)
{
    double c = 0.0;
    int i = 0;

    for(i = 0; i < n; i++)
        c += x[i] * y[i];

    return c;
}

static int main_dot(const int n, const int elements_type, const char* verbose)
{
    double c = 0.0;
    double* x = NULL;
    double* y = NULL;
    struct timeval start, finish;
    double runtime = 0.0;

    assert(n > 0);
    assert(elements_type >= ZEROS && elements_type <= RAND);

    x = array_new(n, 1, elements_type);
    assert(x != NULL);

    y = array_new(n, 1, elements_type);
    assert(y != NULL);

    gettimeofday(&start, NULL);
    c = my_dot(n, x, y);
    gettimeofday(&finish, NULL);

    if(strcmp(verbose, "on") == 0)
    {
        array_show(n, 1, x, "x");
        array_show(n, 1, y, "y");
    }

    fprintf(stdout, "c = %lf\n", c);
    runtime = timeval_diff(&finish, &start);
    fprintf(stdout, "Data: %d %lf\n", n, runtime);

    free(x);
    free(y);

    return EXIT_SUCCESS;
}
