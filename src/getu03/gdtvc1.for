C POMOCNA PROCEDURA PRO VYPIS CHARAKTERISTIK POLOHY
C=======================================================================
C         1. VERZE  /ZARI 1984/         VUGTK
C
      SUBROUTINE GDTVC1(LUN,TYP,CHAR,BOD1,BOD2)
C
$INCLUDE: 'GDTSOW.COM'
      INTEGER*1  TYP,CBOD1(13),CBOD2(13)
      REAL  CHAR(4)
      INTEGER  LUN,BOD1,BOD2
C
      CALL GDTEXT(BOD1,CBOD1)
      CALL GDTEXT(BOD2,CBOD2)
      IF(LUN.EQ.GSGDPT)  CALL GDSSTR(1,0)
      WRITE(LUN,88)  TYP,CHAR(1),CHAR(2),CBOD1,CHAR(3),CHAR(4),CBOD2
88    FORMAT(5X,A1,F10.1,F8.1,2X,13A1,F9.1,F8.1,2X,13A1)
C
      END
