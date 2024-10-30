!A Program to convert Temperatures in Degree Celsius to Kelvin
PROGRAM Air_Temperature

IMPLICIT NONE
REAL,DIMENSION(10) :: Kel,deg_cel
INTEGER :: i,k

OPEN(10,file='Air-Temperature.csv',status='old')
DO i = 1,10
READ(10,*)deg_cel(i)
Kel(i)=273.15+deg_cel(i)
END DO
close(10)

OPEN(10,file='4295120-Air-Temperature-Assignment.csv',status='new')
DO k=1,10
WRITE(10,'(F7.3)')Kel(k)
END DO
close(10)

END PROGRAM Air_Temperature

