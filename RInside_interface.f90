module RInside_interface

  use, intrinsic :: iso_c_binding, only: SEXP => c_ptr, c_char, c_null_char
  implicit none

  public

  interface

    subroutine c_setupRinC() bind(C,name="setupRinC")
    end subroutine

    subroutine c_passToR(x,name) bind(C,name="passToR")
      import SEXP, c_char
      type(SEXP), intent(in), value :: x
      character(kind=c_char), intent(in) :: name(*)
    end subroutine

    type(SEXP) function c_evalInR(cmd) bind(C,name="evalInR")
      import SEXP, c_char
      character(kind=c_char), intent(in) :: cmd(*)
    end function

    type(SEXP) function c_evalQuietlyInR(cmd) bind(C,name="evalQuietlyInR")
      import SEXP, c_char
      character(kind=c_char), intent(in) :: cmd(*)
    end function

    subroutine c_teardownRinC() bind(C,name="teardownRinC")
    end subroutine


    subroutine c_Rf_PrintValue(x) bind(C,name="Rf_PrintValue")
      import SEXP
      type(SEXP), intent(in), value :: x
    end subroutine

    type(c_ptr) function SEXP2REAL(x) &
        bind(C,name="SEXP2REAL")
      use, intrinsic :: iso_c_binding, only: c_ptr
      import SEXP
      type(SEXP), intent(in), value :: x
    end function

    subroutine print_in_C(x) &
        bind(C,name="print_in_C")
      import SEXP
      type(SEXP), intent(in), value :: x
    end subroutine

    type(SEXP) function c_Rf_protect(x) bind(C,name="Rf_protect")
      import SEXP
      type(SEXP), intent(in), value :: x
    end function

    subroutine c_Rf_unprotect(n) bind(C,name="Rf_unprotect")
      use, intrinsic :: iso_c_binding, only: c_int
      integer(c_int), intent(in), value :: n
    end subroutine

  end interface

contains

  ! type(SEXP) function evalQuietlyR(cmd) bind(C,name="evalQuietlyR")
  !   import SEXP, c_char
  !   character(kind=c_char,len=*), intent(in) :: cmd

  !   type(c_ptr)
  ! end function

end module

