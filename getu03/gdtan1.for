C PRIPRAVA PRO ANALYZU NEMERENYCH NEZNAMYCH
C=======================================================================
C         1. VERZE  /ZARI 1984/         VUGTK
C
      SUBROUTINE GDTAN1(TISK,ITYP,IOUT)
C
C TISK  POZADAVEK NA TISK HLAVICKY OPERACE DO PROTOKOLU
C ITYP  2 ... ANALYZA SMERU/DELEK
C       3 ... ANALYZA NEZNAMYCH A JEJICH FUNKCI
C IOUT  VYSTUPNI PARAMETR, TYP POZADOVANE CINNOSTI (VIZ GDTWTT)
C
$INCLUDE: 'GDTSOW.COM'
      LOGICAL  TISK
      INTEGER  ITYP,IOUT
C
      IF(.NOT.TISK)  GOTO 100
      CALL GDSSTR(0,0)
      IF(ITYP.EQ.2)  CALL GDTTHL(GSGDPT,
     /'VYSLEDKY VYROVNANI A JEJICH HODNOCENI (MERENE VELICINY):')
      IF(ITYP.EQ.3)  CALL GDTTHL(GSGDPT,
     /'VYSLEDKY VYROVNANI A JEJICH HODNOCENI '//
     /'(NEZNAME A JEJICH FUNKCE):')
      TISK = .FALSE.
      CALL GDTA49
      IF(ITYP.EQ.3)  CALL GDT712(GSGDPT)
100   CONTINUE
      CALL GDTWTT(ITYP,IOUT)
C
      END
