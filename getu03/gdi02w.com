C
C COMMON /GDI02W/ - RADEK POZOROVANI - NEKOMPRIMOVANA FORMA
C=======================================================================
C SMER    SMER (OBLOUKOVA MIRA, INTERVAL <0,2PI))
C DELKA
C CHSMER  CHARAKTERISTIKA SMERU (STR. CHYBA V CC)
C CHD     CHARAKTERISTIKA DELKY (STR. CHYBA V MM)
C CSTAN   CISLO STANOVISKA
C CCILE   CISLO CILE
C CSEZ    CISLO SEZNAMU
C CHRAD   CHARAKTERISTIKA RADKU POZOROVANI
      DOUBLE PRECISION  SMER,DELKA
      REAL  CHSMER,CHD
      INTEGER  CSTAN(3),CCILE(3)
      INTEGER*1  CSEZ,CHRAD
      COMMON/GDI02W/SMER,DELKA,CHSMER,CHD,CSTAN,CCILE,CSEZ,CHRAD
