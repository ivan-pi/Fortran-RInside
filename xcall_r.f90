program xcall_r
! Demonstrate Fortran calling R, passing data with binary file
use RInside_interface
implicit none
integer :: iter
integer, parameter :: n = 100000000, bin_unit = 20, niter = 3
character (len=*), parameter :: bin_file = "double.bin"
logical, parameter :: call_r = .true.

type(SEXP), target :: x_R
real(kind=kind(1.0d0)), pointer :: x_ptr(:) => null()
integer, parameter :: REALSXP = 14
type(SEXP) :: dummy

call setupRinC()

x_R = Rf_protect(Rf_allocVector(REALSXP,n))
x_ptr => double_from_SEXP(x_R,n)

do iter = 1, niter
  call random_number(x_ptr)

  write (*,"(a,f11.7)") "mean = ",sum(x_ptr)/n

  call passToR(x_R,'x')
  dummy = evalInR('cat("from R: ",mean(x),"\n\n")')

end do

call Rf_unprotect(1)

call teardownRinC()

end program xcall_r