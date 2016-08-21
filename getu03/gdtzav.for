C TISK ZAVERU ANALYZY VYSLEDKU 1. KROKU GSO
C=======================================================================
C         1. VERZE  /ZARI 1984/         VUGTK
C
      SUBROUTINE GDTZAV
C
$INCLUDE: 'GDTSOW.COM'
      INTEGER*1  TEXT(100),BOD(20)
      INTEGER  TTLENF,I,J,K,JJ
      LOGICAL  WAIT
      CHARACTER*(*) RET
      PARAMETER  (RET='ZAKLADNI PARAMETRY RESENI ULOHY:')
481   FORMAT(
     /' POCET ROVNIC OPRAV      :',I5,12X,'POCET NEZNAMYCH:',I5/
     /' POCET NADBYT. POZOROVANI:',I5,12X,'DEFEKT SITE    :',I5)
4811  FORMAT(
     /' M0''[MM/CC]              :',E12.5,5X,'[PVV]          :',E12.5)
482   FORMAT(1X,70A1)
483   FORMAT(' BYLO NALEZENO  TAKOVE RESENI  VOLNE  SITE, PRO',
     /' KTERE  ZUSTAVAJI ZADANE'/' SOURADNICE URCOVANYCH BODU')
4831  FORMAT(' ZACHOVANY JAKO PEVNE (AUTOMAT. REGULARIZACE).  DALSI',
     /'  RESENI LZE NAJIT'/' PROHLASENIM NEKTERYCH URCOVANYCH BODU',
     /' ZA  O P E R N E . SIT BUDE POTOM'/' PRI ZACHOVANI VYROVNANYCH',
     /' HODNOT  SMERU/DELEK  TRANSFORMOVANA  TAK, ZE'/' DOJDE K MAX.',
     /' UHRNNEMU POKLESU  SOUCTU CTVERCU KOREKCI I STR. CHYB SOU-'/
     /' RADNIC TECHTO BODU.')
484   FORMAT(
     /' DOPORUCUJI NEJPRVE ANALYZOVAT VYSLEDKY VYROVNANI SMERU/DELEK')
C                    12345678901234567890
      CALL PPMOV1(1,'  ************* (*),',1,BOD,1,20)
      CALL GDSSTR(2,16)
      CALL GDTTHL(GSGDPT,RET)
      CALL GDTTHL(ITT   ,RET)
      WRITE(GSGDPT,481)  POCPOZ,POCNEZ,NADBPO,DEFEKT
      WRITE(ITT   ,481)  POCPOZ,POCNEZ,NADBPO,DEFEKT
0103  IF(NADBPO.LE.0)  GOTO 0199
         CALL GDSSTR(1,0)
         WRITE(GSGDPT,4811)  M01,PVV
         WRITE(ITT   ,4811)  M01,PVV
0199  CONTINUE
      CALL PPMOV1(1,
     /'ZADANE PEVNE BODY NESTACI K JEDNOZNACNE LOKALIZACI SITE'C,1,
     /TEXT,1,70)
C      12345678901234567890123245
C*    IF(DEFEKT.LE.0)  CALL PPINI1(' ',2,TEXT(19))
      IF(DEFEKT.LE.0) THEN
         TEXT(19) = ' '
	 TEXT(20) = ' '
      END IF
      CALL GDSMEZ(TEXT,TTLENF(TEXT),I)
      CALL GDSSTR(1,0)
      WRITE(GSGDPT,482)  (TEXT(J),J=1,I)
      WRITE(ITT   ,482)  (TEXT(J),J=1,I)
0203  IF(DEFEKT.LE.0)  GOTO 0299
         WAIT = .TRUE.
         CALL GDTPAU(WAIT)
         CALL GDSSTR(2,6)
         WRITE(GSGDPT,483)
         WRITE(ITT   ,483)
         CALL GDTBU1(.TRUE.,.TRUE.)
         DO 0250 I=1,DEFEKT
            JJ = INDS(I)
            IF(JJ.LT.0)  JJ = ABS(JJ) - 1
            CALL GDTSTB(JJ,J,BOD(18))
            CALL GDTEXT(J,BOD(3))
            CALL GDTBUF(BOD,20)
0250     CONTINUE
         CALL GDTBU2(1)
         CALL GDSSTR(5,0)
         WRITE(GSGDPT,4831)
         WRITE(ITT   ,4831)
         WAIT = .TRUE.
         CALL GDTPAU(WAIT)
         WRITE(ITT,484)
0299  CONTINUE
C
      END
