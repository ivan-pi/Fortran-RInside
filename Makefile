# Basic R extensions info
R_HOME := $(shell R RHOME)
RLDFLAGS := $(shell $(R_HOME)/bin/R CMD config --ldflags)

# Header files required by Rcpp
RCPPFLAGS := $(shell $(R_HOME)/bin/R CMD config --cppflags)

# Location of RInsideC.h
RINSIDECINCL := $(shell echo 'RInside:::CFlags()' | $(R_HOME)/bin/R --vanilla --slave)

# Location of RInsideC library
RINSIDECLIBS := $(shell echo 'RInside:::LdFlags()'  | $(R_HOME)/bin/R --vanilla --slave)

# C compiler
CC := $(shell $(R_HOME)/bin/R CMD config CC)

# Fortran compiler
FC := $(shell $(R_HOME)/bin/R CMD config FC)

FLAGS := $(RLDFLAGS) $(RCPPFLAGS) $(RINSIDECLIBS) $(RINSIDECINCL)


Rfortran_helpers.o:
	$(CC) Rfortran_helpers.c $(FLAGS) -c

hello: Rfortran_helpers.o
	$(FC) hello.f90 RInside_interface.f90 Rfortran_helpers.o $(FLAGS) -o hello
	./hello

passdata: Rfortran_helpers.o
	$(FC) passdata.f90 RInside_interface.f90 Rfortran_helpers.o $(FLAGS) -o passdata
	./passdata

.phony.: clean

clean:
	rm hello passdata *.o