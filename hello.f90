program hello

  use RInside_interface
  implicit none

  type(SEXP) :: res

  call setupRinC()

  res = evalQuietlyInR("print('Hello, World')"//c_null_char)
  ! the result res is a c_null_ptr

  call teardownRinC()

end program