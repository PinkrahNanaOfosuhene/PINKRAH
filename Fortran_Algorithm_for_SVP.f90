! Fortran Algorithm for Calculating Saturation Vapour Pressure

PROGRAM saturation_vapour_pressure
IMPLICIT NONE

REAL :: es
INTEGER :: t

! where t = temperature,  es = saturation vapour pressure

!creating a function 
OPEN(unit=1,file='data.txt',status='old')

!creating a do loop 
DO t = 22,40,2

! Using the magnus formular to calculate saturation vapour pressure
es = 6.107*10**((7.5*t)/(273+t))

WRITE(1,'(I5,5x,F5.2)')t,es

END DO
CLOSE(1)
END PROGRAM saturation_vapour_pressure


