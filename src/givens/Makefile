#
#
# -----------------------------------------------------------------------

PNAME=gt4lsa
PVER=`awk '/$(PNAME)  v./{ print $$6 }' $(PNAME).for`
#FORTRAN=g77
FORTRAN=gfortran
OBJ=$(shell ls *.for | sed s-sources/--g | sed s/.for/.o/g )

$(PNAME): $(OBJ)
	$(FORTRAN) -o $(PNAME) $(OBJ)

%.o: %.for; $(FORTRAN) -O -c $<

# -----------------------------------------------------------------------

clean:
	rm -f *.o *~ $(PNAME) GT4LSA.TMP GT4LSA.WC

archive:
	make clean
	tar czf $(PNAME)-$(PVER).tgz * --exclude=*.tgz
