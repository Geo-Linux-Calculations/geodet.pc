C HLEDANI PRVKU V SEZMER
C=======================================================================
C         1. VERZE  /RIJEN 1984/         VUGTK
C
      SUBROUTINE GDTHPR(ISTA,ICIL,TYP,IPRV,IPOR)
C
C ISTA  VSTUPNI PARAMETER, INTERNI CISLO STANOVISKA
C ICIL  VSTUPNI PARAMETR, INTERNI CISLO CILE
C TYP   VSTUPNI PARAMETR, TYP PRVKU (S/D)
C IPRV  VYSTUPNI PARAMETR
C       IPOR<=0  POCET TOTOZNYCH PRVKU (DUPLICITA)
C       IPOR> 0  INDEX PRVKU V SEZMER (IPRV=0 PRVEK NEEXISTUJE)
C IPOR  PORADOVE CISLO DUPLICITNIHO PRVKU RESP. POZADAVEK NA
C       TEST DUPLICITY
C
$INCLUDE: 'GDTSOW.COM'
      INTEGER  ISTA,ICIL,IPRV,IPOR,I,J
      INTEGER*1  TYP
C
      IPRV = 0
      IF(SMPOC.LE.0)  RETURN
      J = 0
      DO 100 I=1,SMPOC
         IF(CST(I).NE.ISTA)  GOTO 100
         IF(CCI(I).NE.ICIL)  GOTO 100
         IF(TYPP(I).NE.TYP)  GOTO 100
         J = J + 1
         IF(J.NE.IPOR)  GOTO 100
            IPRV = I
            RETURN
100   CONTINUE
      IPRV = 0
      IF(IPOR.LE.0)  IPRV = J
      RETURN
C
      END
