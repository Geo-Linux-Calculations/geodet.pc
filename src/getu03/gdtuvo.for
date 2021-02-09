C UVODNI DIALOG A INICIALIZACE PROMENNYCH
C=====================================================================
C         1. VERZE  /CERVEN 1984/         VUGTK
C       * 5. VERZE      /ZARI 1989/             VUGTK      ALES CEPEK
C
C KK = 1  NEEXISTUJE SOUBOR INFORMACI O SITI
C KK = 2  UKONCENI PROGRAMU
C KK = 3  EXISTUJE SOUBOR INFORMACI O SITI
C
      SUBROUTINE GDTUVO
C
$INCLUDE: 'GDTSOW.COM'
      INTEGER  IER,IOUT
      CHARACTER*40 CJMENO
C
C PROLOG / OTEVRENI DATOVE ZAKLADNY POUZE PRO CTENI
C RETEZEC SOTEXT IDENTIFIKUJICI PROGRAM JE PO PROLOGU VYMAZAN
0102  CALL GDDPG3(SOTEXT(7),SOUBT,.FALSE.,IER)
         SOTEXT(7) = 0
         PRASDZ = IER.EQ.0
         IF(IER.EQ.1)  GOTO 9990
         IF(IER.EQ.0)  GOTO 0199
         GOTO 0102
0199  CONTINUE
0503  IF(PRASDZ) GOTO 0504
         ISEZT = 1
         GOTO 0599
0504  CONTINUE
0202     CALL TTASKN(ITT,
     /   '/1/CISLO SEZNAMU DATOVE ZAKLADNY : ',IOUT,ISEZT,1)
            IF(IOUT.EQ.-2)  GOTO 9990
            IF(IOUT.EQ.1.AND.ISEZT.GE.1.AND.ISEZT.LE.8)  GOTO 0299
            GOTO 0202
0299    CONTINUE
0599  CONTINUE
0302  CALL TTASKS(ITT,'JMENO SOUBORU INFORMACI O SITI: ',IOUT,JMENO,38)
         IF(IOUT.EQ.-2)  GOTO 9990
         IF(IOUT.LE.0)   GOTO 0302
         JMENO(IOUT+1) = 0
         CALL GDSJMS(JMENO,CJMENO)
C*       OPEN(UNIT=GSGDIS,NAME=JMENO,ACCESS='DIRECT',RECORDSIZE=ISREC,
C*   /        ERR=0350,TYPE='OLD')
	 OPEN(UNIT=GSGDIS,FILE=CJMENO,ACCESS='DIRECT',RECL=ISREC*4,
     /        ERR=0350,STATUS='OLD')
         CALL GDTICZ('CTENI')
C  SOUBOR EXISTUJE
         GOTO 9910
C*0350   OPEN(UNIT=GSGDIS,NAME=JMENO,ACCESS='DIRECT',RECORDSIZE=ISREC,
C*   /        ERR=0302,TYPE='NEW')
0350     OPEN(UNIT=GSGDIS,FILE=CJMENO,ACCESS='DIRECT',RECL=ISREC*4,
     /        ERR=0302,STATUS='NEW')
         CALL GDTICZ('INICIALIZACE')
0399  CONTINUE
      SS = 0
0402  CALL TTASKS(ITT,'NAZEV ULOHY [SITE]: ',IOUT,ULOHA,43)
         IF(IOUT.EQ.-2)  GOTO 9980
         IF(IOUT.GE.0)   GOTO 0499
         GOTO 0402
0499  CONTINUE
      ULOHA(IOUT+1) = 0
C*    IF(IOUT.EQ.0)  CALL CONCAT('SIT 'C,JMENO,ULOHA,38)
      IF(IOUT.EQ.0)  CALL CONCAT('SIT 'C,JMENO,ULOHA)
C
C DEFINICE A ULOZENI POSTUPOVEHO KLICE A SYSTEMOVYCH PARAMETRU
      CALL GDTDSP
      IF(KK.EQ.2)  GOTO 9990
C
C TISK LEGENDY
      CALL GDTTLE
C
      KK = 1
      RETURN
C
9910  KK = 3
      RETURN
C
C*9980  CLOSE(UNIT=GSGDIS,DISPOSE='DELETE')
9980  CLOSE(UNIT=GSGDIS,STATUS='DELETE')
      PRASIS = .FALSE.
9990  KK = 2
      RETURN
C
      END
