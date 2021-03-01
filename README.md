# Fortran-RInside

Demonstration of Fortran interface to [RInside](https://github.com/eddelbuettel/rinside)

To install RInside, open an R console and run the command:

```
install.packages("RInside")
```

The two example programs `hello` and `passdata` replicate the examples from the [`rinside/inst/examples/c_interface/`](https://github.com/eddelbuettel/rinside/tree/master/inst/examples/c_interface) folder.

A Makefile is provided to build the example. The Makefile requires some more work.

The RInside package is described in the book chapter:

> Eddelbuettel D. (2013) RInside. In: Seamless R and C++ Integration with Rcpp. Use R!, vol 64. Springer, New York, NY. https://doi.org/10.1007/978-1-4614-6868-4_9 [(download PDF)](https://link.springer.com/content/pdf/10.1007%2F978-1-4614-6868-4.pdf)