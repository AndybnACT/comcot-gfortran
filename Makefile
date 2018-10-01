######################################################################
# Makefile: GPU-Cornell Multigrid Coupled Tsunami (GPUCOMCOT) Model #
# LAST REVISED: TAO CHIU  MARCH 2018                                #
#####################################################################

### Plese specify your fortran compiler ##########################################
FC          = gfortran
FC_FLAGS    = -O2 #-fdefault-real-8 
##################################################################################


F90_MOD     = type_module.o
F90_OBJECTS = comcot.o initialization.o output.o\
              deform.o mass.o moment.o\
              boundaries.o all_grids.o hotstart.o\
              landslide.o wavemaker.o dispersion.o



.PHONY: cleandat cleanall cleanf90 cleancu clean
comcot: $(F90_OBJECTS)
	$(FC) $(FC_FLAGS) $(F90_OBJECTS) $(F90_MOD) -o comcot

cleandat:
	for file in *.[dt][ax]t ; do\
		if [[ "$$file" = z_[0-9][0-9]_*.dat ]] ||\
		   [[ "$$file" = arrival_*.dat ]] ||\
		   [[ "$$file" = M1Layer*.txt ]] ||\
		   [[ "$$file" = [fhijmnvz]max_layer*.dat ]] ||\
		   [[ "$$file" = layer*.dat ]] ||\
		   [[ "$$file" = ts_record*.dat ]] ||\
		   [[ "$$file" = zmin_layer*.dat ]] ||\
		   [[ "$$file" = deform_seg[0-9][0-9][0-9].dat ]] ||\
		   [[ "$$file" = *_[0-9][0-9]_*.dat ]]; then\
					$(RM) "$$file" ;\
			fi;\
	done
cleanf90:
	rm comcot $(F90_OBJECTS) $(F90_MOD)
clean:
	make cleanf90
cleanall:
	make clean
	make cleandat


################# RULES FOR FORTRAN #################
$(F90_MOD): type_module.f90
	$(FC) -c $(FC_FLAGS) type_module.f90
$(F90_OBJECTS): $(F90_MOD)
comcot.o: comcot.f90
	$(FC) -c $(FC_FLAGS) comcot.f90

initialization.o: initialization.f90
	$(FC) -c $(FC_FLAGS) initialization.f90

output.o: output.f90
	$(FC) -c $(FC_FLAGS) output.f90

deform.o: deform.f90
	$(FC) -c $(FC_FLAGS) deform.f90

mass.o: mass.f90
	$(FC) -c $(FC_FLAGS) mass.f90

moment.o: moment.f90
	$(FC) -c $(FC_FLAGS) moment.f90

boundaries.o: boundaries.f90
	$(FC) -c $(FC_FLAGS) boundaries.f90

all_grids.o: all_grids.f90
	$(FC) -c $(FC_FLAGS) all_grids.f90

hotstart.o: hotstart.f90
	$(FC) -c $(FC_FLAGS) hotstart.f90

landslide.o: landslide.f90
	$(FC) -c $(FC_FLAGS) landslide.f90

wavemaker.o: wavemaker.f90
	$(FC) -c $(FC_FLAGS) wavemaker.f90

dispersion.o: dispersion.f90
	$(FC) -c $(FC_FLAGS) dispersion.f90
####################################################
