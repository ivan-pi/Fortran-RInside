# Fortran-RInside

Demonstration of Fortran interface to [RInside](https://github.com/eddelbuettel/rinside)

To install RInside, open an R console and run the command:

```
install.packages("RInside")
```

The programs `hello` and `passdata` are replicates of the original example programs in the [`rinside/inst/examples/c_interface/`](https://github.com/eddelbuettel/rinside/tree/master/inst/examples/c_interface) folder.

A Makefile is provided to build the examples. The Makefile is not very elegant and would require more attention.

The RInside package is described in the book chapter:

> Eddelbuettel D. (2013) RInside. In: Seamless R and C++ Integration with Rcpp. Use R!, vol 64. Springer, New York, NY. https://doi.org/10.1007/978-1-4614-6868-4_9

A full-text PDF of the book can be downloaded from SpringerLink by clicking [here](https://link.springer.com/content/pdf/10.1007%2F978-1-4614-6868-4.pdf)).

