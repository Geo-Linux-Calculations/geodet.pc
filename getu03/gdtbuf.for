C SPOJOVANI TEXTOVYCH RETEZCU V RAMCI TISKOVEHO RADKU
C=======================================================================
C         1. VERZE  /ZARI 1984/         VUGTK
C
      SUBROUTINE GDTBUF(TXT,INTXT)
C
$INCLUDE: 'GDTSOW.COM'
      INTEGER*1  TXT(1),TEXT(140)
      INTEGER  INTXT,TTLENF,ITXT,I,J,IDEL,ID
      LOGICAL  LUNPT,LUNTT
      SAVE  TEXT,IPOC
1     FORMAT(1X,70A1)
C
      ITXT = INTXT
      IF(INTXT.LE.0)  ITXT = TTLENF(TXT)
      CALL PPMOV1(1,TXT,1,TEXT,IPOC+1,ITXT)
      J = IPOC
      CALL GDSMEZ(TEXT,IPOC+ITXT,IPOC)
      IF(IPOC.LE.70)  RETURN
      IF(LPT)  CALL GDSSTR(1,0)
      IF(LPT)  WRITE(GSGDPT,1) (TEXT(I),I=1,J)
      IF(LTT)  WRITE(ITT   ,1) (TEXT(I),I=1,J)
      CALL PPMOV1(1,TXT,1,TEXT,1,ITXT)
      CALL GDSMEZ(TEXT,ITXT,IPOC)
      RETURN
C
C INICIALIZACE INTERNICH PROMENNYCH
      ENTRY GDTBU1(LUNPT,LUNTT)
C
C POZADUJE SE TISK DO PROTOKOLU
      LPT  = LUNPT
C POZADUJE SE TISK NA OBRAZOVKU
      LTT  = LUNTT
C POCET ZNAKU V POLI TEXT
      IPOC = 0
      RETURN
C
C TISK ZBYVAJICIHO TEXTU
      ENTRY GDTBU2(IDEL)
C                          POSLEDNICH IDEL ZNAKU SE NETISKNE
      IF(IPOC.LE.0)  RETURN
      ID = MAX0(0,IDEL)
      IPOC = IPOC - ID
      IF(LPT)  CALL GDSSTR(1,0)
      IF(LPT)  WRITE(GSGDPT,1) (TEXT(I),I=1,IPOC)
      IF(LTT)  WRITE(ITT   ,1) (TEXT(I),I=1,IPOC)
      RETURN
C
      END
