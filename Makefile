# Make file (Use EXECUTABLE or EXECUTABLE) 
FC			=	gfortran
FFLAGS		=	-O3 -Wall -Wextra -g -fopenmp -std=legacy 
LINALG		=	-L/usr/lib -lblas -llapack
SRC			=	$(wildcard *.f90)
OBJ			=	${SRC:.f90=.o}					# Obj files: file1.o file2.o ... filen.o
EXECUTABLE	=	MurrelSorbie

#default:
#	@echo "compiling Bisection Program using" $(FC)

%.o: %.f90								# compile without linking
	$(FC) $(FFLAGS) -o $@ -c $<	$(LINALG)

%mod: %.f90					  	# No mod file in this case!
	$(FC) $(FFLAGS) -o $@ -c $<	$(LINALG)

$(EXECUTABLE): $(OBJ)						# final executable is 
	@echo "-------------------------------"
	@echo "Creating executable for program"
	@echo "-------------------------------"
	@$(FC) $(FFLAGS) -o $@ $(OBJ) $(LINALG)
	@echo " "
	@echo "executable file = " $(EXECUTABLE)
	@echo " "
	@echo "-------------------------------"
clean:
	@rm -f *.o *.mod $(EXECUTABLE)

