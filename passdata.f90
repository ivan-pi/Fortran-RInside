program passdata

  use, intrinsic :: iso_c_binding, only: c_double

  use RInside_interface

  implicit none

  type(SEXP) :: res
  type(SEXP), target :: vec
  real(c_double), pointer :: fvec(:) => null()

  call setupRinC()

  res = evalQuietlyInR("y <- 3")
  res = evalQuietlyInR("z <- 2.5")
  res = evalQuietlyInR("print(y*z)")
  res = evalQuietlyInR("y <- rnorm(10)")
  res = evalQuietlyInR("print(y)")

  ! The protect is added to prevent R from doing garbage collection
  vec = Rf_protect(evalInR("y"))

  call Rf_PrintValue(vec)

  ! fvec is a pointer to the underlying SEXP memory
  fvec => double_from_SEXP(vec,10)
  print *, fvec

  ! modifying fvec, changes the value in vec
  fvec(4) = 42
  call Rf_PrintValue(vec)

  ! We need to unprotect before teardown
  call Rf_unprotect(1)

  call teardownRinC()

end program