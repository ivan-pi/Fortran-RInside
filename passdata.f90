program passdata

  use, intrinsic :: iso_c_binding, only: c_double, c_loc, c_f_pointer, c_ptr
  use RInside_interface
  implicit none

  type(SEXP) :: res
  type(SEXP), target :: vec
  real(c_double), pointer :: fvec(:) => null()

  call c_setupRinC()
  res = c_evalQuietlyInR("y <- 3"//c_null_char)
  res = c_evalQuietlyInR("z <- 2.5"//c_null_char)
  res = c_evalQuietlyInR("print(y*z)"//c_null_char)
  res = c_evalQuietlyInR("y <- rnorm(10)"//c_null_char)
  res = c_evalQuietlyInR("print(y)"//c_null_char)

  vec = c_Rf_protect(c_evalInR("y"//c_null_char))

  call c_Rf_PrintValue(vec)

  call c_f_pointer(SEXP2REAL(vec),fvec,[10])
  print *, fvec

  call c_Rf_unprotect(1)

  call c_teardownRinC()

end program