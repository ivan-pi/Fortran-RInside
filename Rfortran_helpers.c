#include <Rinternals.h>


void print_in_C(SEXP vec) {
  printf("%f\n", REAL(vec)[4]);
}

double *SEXP2REAL(SEXP x) {
  double *ptr = REAL(x);
  return ptr;
}