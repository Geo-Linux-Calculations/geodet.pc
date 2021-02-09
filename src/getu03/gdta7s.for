C ZMENA NAZVU ULOHY/UKONCENI VYPOCTU/ZRUSENI SOUBORU IS
C=======================================================================
C         1. VERZE  /RIJEN 1984/         VUGTK
C       * 5. VERZE      /ZARI 1989/             VUGTK      ALES CEPEK
C
      SUBROUTINE GDTA7S(TISK,IOP)
C
$INCLUDE: 'GDTSOW.COM'
      LOGICAL  TISK
      INTEGER  IOP,IOUT,LENF
1     FORMAT(/)
2     FORMAT(' ZMENA NAZVU ULOHY')
3     FORMAT(' SOUBOR INFORMACI O SITI ZRUSEN')
7     FORMAT(
     /' 7 ... ZMENA NAZVU ULOHY (SITE)'/
     /' 8 ... UKONCENI VYPOCTU'/
     /' 9 ... ZRUSENI SOUBORU IS'/)
37    FORMAT('0AKTUALIZACE NEPORUSILA KONZISTENCI DAT')
35    FORMAT('0VSECHNY INFORMACE O ULOZE ',70A1)
C
      IF(.NOT.TISK)  RETURN
      WRITE(ITT,7)
0102  CALL TTASK(ITT,'ZVOL TYP OPERACE (1-9): ',IOP)
      IF(IOP.EQ.-2) GOTO 0199
      IF(IOP.LE.0)  GOTO 0102
0199  CONTINUE
      WRITE(ITT,1)
C ZMENA NAZVU ULOHY (SITE)
0203  IF(IOP.NE.7)  GOTO 0299
0302     CALL TTASKS(ITT,'NOVY NAZEV ULOHY [SITE]: ',IOUT,ULOHA,43)
         IF(IOUT.LT.0)  GOTO 0302
         ULOHA(IOUT+1) = 0
C*       IF(IOUT.EQ.0)  CALL CONCAT('SIT 'C,JMENO,ULOHA,43)
         IF(IOUT.EQ.0)  CALL CONCAT('SIT 'C,JMENO,ULOHA)
C*       CALL PPINI1(' ',25,NAZVAR)
         DO 9981 II81=1,25
9981        NAZVAR(II81) = ' '	
         CALL GDSSTR(1,0)
         WRITE(GSGDPT,2)
         RETURN
0299  CONTINUE
C UKONCENI VYPOCTU
0403  IF(IOP.NE.8.AND.IOP.NE.-2)  GOTO 0499
0503     IF(POCBOD.GT.0)  GOTO 0504
           SS = 0
           GOTO 0599
0504     CONTINUE
0603        IF(POCPOZ.GT.0)  GOTO 0604
               SS = 1
               GOTO 0699
0604        CONTINUE
0703           IF(SS.NE.4)  GOTO 0704
                  CALL GDSSTR(2,0)
                  WRITE(GSGDPT,37)
                  WRITE(ITT   ,37)
                  GOTO 0799
0704           CONTINUE
C                 V PROM.  POB  JE ULOZENA PUVODNI HODNOTA SS
C                 (VIZ PROCEDURA GDTASI)
                  IF(POB.EQ.4)  CALL GDSSTR(0,0)
0799           CONTINUE
0699        CONTINUE
0599     CONTINUE
         KK = 1
         IF(IOP.EQ.8)  KK = 2
         IOP = -2
         RETURN
0499  CONTINUE
C ZRUSENI SOUBORU IS
0803  IF(IOP.NE.9)  GOTO 0899
         WRITE(ITT,35)  (ULOHA(I),I=1,LENF(ULOHA))
         CALL TTASK(ITT,'/A/BUDOU NENAVRATNE ZTRACENY.'//
     /' TRVAS NA PROVEDENI OPERACE? (A/N): ',IOUT)
         IF(IOUT.NE.1)  GOTO 0899
C*       CLOSE(UNIT=GSGDIS,DISPOSE='DELETE')
         CLOSE(UNIT=GSGDIS,STATUS='DELETE')
         PRASIS = .FALSE.
         CALL GDSSTR(1,0)
         WRITE(GSGDPT,3)
         IOP = -2
         KK = 2
         RETURN
0899  CONTINUE
C
      END
