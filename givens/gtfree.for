C ALOKACE VOLNEHO PROSTORU V PRACOVNI OBLASTI
C=======================================================================
C
      SUBROUTINE GTFREE(ALLOC,PTR,IMFREE,MAXM,IOUT)
C
C ALLOC   MNOZSTVI POZADOVANE PAMETI (MERENO V PRVCICH TYPU REAL),
C         PRIPOUSTI SE I NEGATIVNI HODNOTY.
C PTR     SMERNIK NA ZACATEK ALOKOVANE PAMETI (PRI NEUSPESNEM VOLANI
C         NENI JEHO HODNOTA DEFINOVANA)
C IMFREE  SMERNIK NA PRVNI VOLNY PRVEK V PRACOVNIM POLI
C MAXM    VOLNA KAPACITA PAMETI
C IOUT    VSTUPNI/VYSTUPNI PARAMETR:
C           IOUT =  0  ALOKACE PAMETI PROVEDENA
C           IOUT = -1  POZADOVANA PAMET NENI K DISPOZICI
C         NENI-LI HODNOTA IOUT PRED VOLANIM NASTAVEN NA 0, NEPROVADI
C         PROCEDURA ZADNOU CINNOST.
C-----------------------------------------------------------------------
C
      INTEGER  ALLOC, PTR, IMFREE, MAXM, IOUT, INTALL, GTINTR
C
      INTALL = ALLOC
100   IF(IOUT.NE.0)  RETURN
      IF(INTALL.EQ.0)  RETURN
      IF(INTALL.LE.0)  GOTO 200
      IF(INTALL.GT.MAXM)  GOTO 900
      PTR    = IMFREE
      IMFREE = IMFREE + INTALL
      MAXM   = MAXM   - INTALL
      RETURN
200   IF(IMFREE+INTALL.LE.0)  GOTO 900
      IMFREE = IMFREE + INTALL
      MAXM   = MAXM   - INTALL
      PTR    = IMFREE
      RETURN
C
900   IOUT = -1
      RETURN
C
C ALOKACE VOLNEHO PROSTORU (MERENO V PRVCICH TYPU INTEGER)
C-----------------------------------------------------------------------
C
      ENTRY GTFREI(ALLOC,PTR,IMFREE,MAXM,IOUT)
C
      INTALL = GTINTR(ALLOC)
      GOTO 100
C
      END
C POCET PRVKU TYPU INTEGER, KTERE LZE ULOZIT V POLI TYPU REAL
C=======================================================================
C
      INTEGER FUNCTION GTRINT(RDIM)
C
      INTEGER  RDIM
C
C     GTRINT = RDIM*2      INTEGER*2 REAL*4
C     GTRINT = RDIM        INTEGER*4 REAL*4
      GTRINT = RDIM*2
      RETURN
C
      END
C POCET PRVKU TYPU REAL, DO KTERYCH LZE ULOZIT POLE TYPU INTEGER
C=======================================================================
C
      INTEGER FUNCTION GTINTR(IDIM)
C
      INTEGER  IDIM
C
C     GTINTR = (IDIM+ISIGN(1,IDIM))/2      INTEGER*2  REAL*4
C     GTINTR =  IDIM                       INTEGER*4  REAL*4
      GTINTR = (IDIM+ISIGN(1,IDIM))/2
      RETURN
C
      END