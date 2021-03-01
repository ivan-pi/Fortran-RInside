module RInside_interface

  use, intrinsic :: iso_c_binding, only: &
    SEXP => c_ptr, &
    c_int, &
    c_char, &
    c_null_char, &
    c_double, &
    c_f_pointer

  implicit none
  private

  ! Renamed c_ptr type
  public :: SEXP

  ! Functions from RInside.h
  public :: setupRinC, teardownRinC
  public :: evalInR, evalQuietlyInR
  public :: passToR

  ! Functions from Rinternals.h
  public :: Rf_PrintValue
  public :: Rf_protect, Rf_unprotect
  public :: Rf_allocVector

  public :: double_from_SEXP

  interface

    subroutine setupRinC() bind(C,name="setupRinC")
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

    subroutine teardownRinC() bind(C,name="teardownRinC")
    end subroutine

    subroutine Rf_PrintValue(x) bind(C,name="Rf_PrintValue")
      import SEXP
      type(SEXP), intent(in), value :: x
    end subroutine

    type(c_ptr) function SEXP2REAL(x) &
        bind(C,name="SEXP2REAL")
      use, intrinsic :: iso_c_binding, only: c_ptr
      import SEXP
      type(SEXP), intent(in), value :: x
    end function

    type(SEXP) function Rf_protect(x) bind(C,name="Rf_protect")
      import SEXP
      type(SEXP), intent(in), value :: x
    end function

    subroutine Rf_unprotect(n) bind(C,name="Rf_unprotect")
      use, intrinsic :: iso_c_binding, only: c_int
      integer(c_int), intent(in), value :: n
    end subroutine

    type(SEXP) function Rf_allocVector(type,n) bind(C,name="Rf_allocVector")
      import SEXP, c_int
      integer(c_int), intent(in), value :: type
      integer(c_int), intent(in), value :: n
    end function

  end interface

  interface double_from_SEXP
    module procedure double_from_SEXP_rank1
    module procedure double_from_SEXP_rank2
  end interface

contains

  type(SEXP) function evalInR(cmd)
    character(len=*), intent(in) :: cmd
    evalInR = c_evalInR(f_c_string(cmd))
  end function

  type(SEXP) function evalQuietlyInR(cmd)
    character(len=*), intent(in) :: cmd
    evalQuietlyInR = c_evalQuietlyInR(f_c_string(cmd))
  end function

  subroutine passToR(x,name)
    type(SEXP), intent(in), value :: x
    character(len=*), intent(in) :: name

    call c_passToR(x,f_c_string(name))
  end subroutine

  function double_from_SEXP_rank1(x,shape1) result(res)
    type(SEXP), intent(in), value :: x
    integer, intent(in) :: shape1
    real(c_double), pointer :: res(:)

    call c_f_pointer(SEXP2REAL(x),res,[shape1])
  end function
  function double_from_SEXP_rank2(x,shape1,shape2) result(res)
    type(SEXP), intent(in), value :: x
    integer, intent(in) :: shape1, shape2
    real(c_double), pointer :: res(:,:)

    call c_f_pointer(SEXP2REAL(x),res,[shape1,shape2])
  end function

  !> String with appended null character
  function f_c_string(string,asis)
    use, intrinsic :: iso_c_binding, only: c_char,c_null_char
    character(kind=c_char,len=*), intent(in) :: string
    logical, intent(in), optional :: asis

    character(kind=c_char,len=:), allocatable :: f_c_string
    ! character(kind=c_char,len = &
    !   merge(len(string) + 1, len_trim(string) + 1, &
    !     merge(asis,.false.,present(asis)))) :: f_c_string
    logical :: asis_

    asis_ = .false.
    if (present(asis)) asis_ = asis

    if (asis_) then
      f_c_string = string//c_null_char
    else
      f_c_string = trim(string)//c_null_char
    end if

  end function

end module

