C ANALYZA A TISK SMERU/DELEK (MERENE VELICINY)
C=======================================================================
C         1. VERZE  /ZARI 1984/         VUGTK
C
      SUBROUTINE GDTAMV(AW)
C
$INCLUDE: 'GDTSOW.COM'
      REAL  AW
C*    VIRTUAL  AW(VIRDIM)
      DIMENSION  AW(VIRDIM)
      INTEGER  IOUT
      LOGICAL  TISK
C
      TISK = .TRUE.
0102  CONTINUE
      CALL GDTAN1(TISK,2,IOUT)
C TEST EMPIR.JEDN.STR.CHYBY M0'
      IF(IOUT.EQ.1)  CALL GDTM01
C PREHLED OPRAV, DETEKCE SLAB.MIST
      IF(IOUT.EQ.2)  CALL GDTTVO(AW)
C VYPIS VYROVNANYCH POZOROVANI
      IF(IOUT.EQ.3)  CALL GDTPVP(AW)
      IF(IOUT.EQ.-2)  GOTO 0199
      GOTO 0102
0199  CONTINUE
C
      END