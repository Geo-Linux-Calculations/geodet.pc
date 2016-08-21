C RESENI ROVNIC OPRAV
C======================================================================
C         1. VERZE  /SRPEN 1984/         VUGTK
C
      SUBROUTINE GDTRRO(AW)
C
$INCLUDE: 'GDTSOW.COM'
      REAL  AW,VYSTUP(ISREC),ACL,ZST,YST,XST
C*    VIRTUAL  AW(VIRDIM)
      DIMENSION  AW(VIRDIM)
      INTEGER   I,J,IND(3),IER
      INTEGER*4 K,POCET
      DOUBLE PRECISION  CP(CPDIM)
C  PROCEDURA PRO TISK PREHLEDU NOREM
      EXTERNAL  GDTTPN
45    FORMAT(/' NUMERICKA METODA: ALGORITMUS GSO')
46    FORMAT(/' RESENI SOUSTAVY ROVNIC OPRAV')
47    FORMAT(/
     /' POSTUP RESENI DOKUMENTUJE NASLEDUJICI VYPIS NOREM,'/
     /' ZISKANYCH ALGORITMEM  GSO  PRI POSTUPNE ORTOGONALIZACI'/
     /' SLOUPCU VSTUPNI MATICE'//' POCET SLOUPCU:',I5)
471   FORMAT(/' DOKONCEN 1. KROK  GSO')
C
      CALL TTZAHL(ITT,'RESENI ROVNIC OPRAV:')
      CALL GDSSTR(4,0)
      WRITE(GSGDPT,46)
      WRITE(GSGDPT,45)
      WRITE(ITT,45)
         WRITE(ITT,47)  NARED
C  INICIALIZACE TISKU PREHLEDU NOREM
      CALL GDTTP0
C
      CALL MTGSO2(AW,VIRDIM,POCPOZ,POCNEZ,1,POCORP,1,.TRUE.,6E-8,TOL,
     /            0,DEFEKT,GDTTPN,IER,INDX,INDS,CP)
C
C ULOZENI VYSLEDKU PRVNI ORTOGONALIZACE DO SOUBORU IS
      POCET = MARED
      POCET = POCET*NARED
C  CITAC POUZITYCH ZAZNAMU V SOUBORU IS
      J = SOWREC
C  CITAC PRVKU V POLI AW
      K = 0
320   DO 300 I=1,ISREC
      K = K + 1
      IF(K.GT.POCET)  GOTO 310
      VYSTUP(I) = AW(K)
300   CONTINUE
310   J = J + 1
      WRITE(GSGDIS,REC=J)  VYSTUP
      IF(K.LT.POCET)  GOTO 320
C
      CALL GDSSTR(2,0)
      WRITE(GSGDPT,471)
      WRITE(ITT   ,471)
      SS = 4
      RETURN
C
      END
