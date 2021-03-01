program hello

  use RInside_interface
  implicit none

  type(SEXP) :: res

  call c_setupRinC()

  res = c_evalQuietlyInR("print('Hello, World')"//c_null_char)
  ! the result res is a c_null_ptr

  call c_teardownRinC()

end program