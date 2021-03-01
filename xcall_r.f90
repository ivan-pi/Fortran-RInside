program xcall_r
! Demonstrate Fortran calling R, passing data with binary file
use RInside_interface
implicit none
integer :: iter
integer, parameter :: n = 100000, bin_unit = 20, niter = 3
real(kind=kind(1.0d0)) :: x(n)
character (len=*), parameter :: bin_file = "double.bin"
logical, parameter :: call_r = .true.

call setupRinC()

do iter = 1, niter
  call random_number(x)
  write (*,"(a,f11.7)") "mean = ",sum(x)/n
  if (call_r) then
    open (unit=bin_unit,file=bin_file,action="write",access="stream",form="unformatted",status="replace")
    write (bin_unit) x
    close (bin_unit)
    call xread_bin()
  end if
end do

call teardownRinC()

contains

  subroutine xread_bin()
    type(SEXP) :: res
    type(SEXP) :: inp, x
    res = evalInR('inp = file("double.bin","rb")')

    res = evalInR('x = readBin(inp, "double",n=100000)') ! n is max number of values to read -- can read fewer
    res = evalInR('cat("from R: ",mean(x),"\n\n")')
    res = evalInR('close(inp)')
  end subroutine

end program xcall_r