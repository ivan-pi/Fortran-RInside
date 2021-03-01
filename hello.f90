program hello

  use RInside_interface
  implicit none

  type(SEXP) :: res

  call setupRinC()

  res = evalQuietlyInR("print('Hello, World')")
  ! the result res is a c_null_ptr

  call teardownRinC()

end program