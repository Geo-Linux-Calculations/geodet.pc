C GLOBALNI ZMENY STREDNICH CHYB
C=======================================================================
C         2. VERZE      /RIJEN 1985/         VUGTK      ALES CEPEK
C
      SUBROUTINE GDTGZS
C
$INCLUDE: 'GDTSOW.COM'
      LOGICAL  ZMENA,ZMENAD,CHYBA
      INTEGER  I,IOUT,JOUT,KOUT
      REAL  RPOM,K1,K2,C,PAR
      CHYBA(PAR) = PAR.LT.1E-4.OR.PAR.GT.1E4
36    FORMAT(' AKTUALIZOVANE PRVKY: STREDNI CHYBY SMERU/DELEK')
361   FORMAT(
     /' STREDNI CHYBY DELEK BYLY URCENY VYPOCTEM'/
     /' - KONSTANTNI SLOZKA CHYBY       :',F8.2,' [MM]'/
     /' - PROMENLIVA SLOZKA (PS) CHYBY  :',F8.2,' [MM/KM]'/
     /' - MOCNINA DELKY, S NIZ ROSTE PS :',F8.2)
C
      ZMENA = .FALSE.
0103  IF(POCSME.LE.0)  GOTO 0199
         CALL GDSDAN('/A/MENI SE STREDNI CHYBY SMERU? (A/N): ',IOUT)
         IF(IOUT.NE.1)  GOTO 0199
         CALL GDSDAN(
     /   '/A/MAJI MIT VSECHNY SMERY STEJNOU CHYBU? (A/N): ',IOUT)
0203     IF(IOUT.NE.1)  GOTO 0204
0302        CALL TTASKR(ITT,'STREDNI CHYBA SMERU [CC]: ',JOUT,RPOM,1)
            IF(JOUT.EQ.-2) GOTO 0199
            IF(JOUT.EQ.0)  GOTO 0204
            IF(JOUT.LE.0)  GOTO 0302
            IF(CHYBA(RPOM))  GOTO 0302
            DO 0300 I=1,SMPOC
0300        IF(TYPP(I).EQ.'S')  STRCH(I) = RPOM
            ZMENA = .TRUE.
            GOTO 0299
0204     IF(IOUT.NE.2) GOTO 0299
            CALL GDSDAN('/A/MAM NASOBIT STAVAJICI HODNOTY VOLITELNYM'//
     /' KOEFICIENTEM? (A/N): ',JOUT)
            IF(JOUT.NE.1)  GOTO 0199
0402        CALL TTASKR(ITT,
     /      'KOEFICIENT PRO NASOBENI CHYB SMERU: ',JOUT,RPOM,1)
            IF(JOUT.EQ.0.OR.JOUT.EQ.-2)  GOTO 0199
            IF(JOUT.LE.0)  GOTO 0402
            IF(CHYBA(RPOM))  GOTO 0402
            DO 0400 I=1,SMPOC
0400        IF(TYPP(I).EQ.'S')  STRCH(I) = STRCH(I)*RPOM
            ZMENA = .TRUE.
0299     CONTINUE
0199  CONTINUE
      CALL TTROL1(ITT,1)
      ZMENAD = .FALSE.
0503  IF(POCDEL.LE.0)  GOTO 0599
         CALL GDSDAN('/A/MENI SE STREDNI CHYBY DELEK? (A/N): ',IOUT)
         IF(IOUT.NE.1)  GOTO 0599
         CALL GDSDAN(
     /   '/A/MAJI MIT VSECHNY DELKY STEJNOU CHYBU? (A/N): ',IOUT)
0603     IF(IOUT.NE.1)  GOTO 0604
0702        CALL TTASKR(ITT,'STREDNI CHYBA DELEK [MM]: ',JOUT,RPOM,1)
            IF(JOUT.EQ.-2) GOTO 0599
            IF(JOUT.EQ.0)  GOTO 0604
            IF(JOUT.LE.0)  GOTO 0702
            IF(CHYBA(RPOM))   GOTO 0702
            DO 0700 I=1,SMPOC
0700        IF(TYPP(I).EQ.'D')  STRCH(I) = RPOM
            ZMENA = .TRUE.
            GOTO 0699
0604     IF(IOUT.NE.2)  GOTO 0699
            CALL GDSDAN('/A/MAM NASOBIT STAVAJICI HODNOTY VOLITELNYM'//
     /' KOEFICIENTEM? (A/N): ',JOUT)
0803        IF(JOUT.NE.1)  GOTO 0804
0902           CALL TTASKR(ITT,'KOEFICIENT PRO NASOBENI CHYB DELEK: ',
     /         KOUT,RPOM,1)
               IF(KOUT.EQ.-2) GOTO 0599
               IF(KOUT.LE.0)  GOTO 0902
               IF(CHYBA(RPOM))  GOTO 0402
               DO 0900 I=1,SMPOC
0900           IF(TYPP(I).EQ.'D')  STRCH(I) = STRCH(I)*RPOM
               ZMENA = .TRUE.
               GOTO 0899
0804        IF(JOUT.NE.2)  GOTO 0899
0800           CALL GDSDAN(
     /         '/A/BUDOU ZADANY PARAMETRY MODELU CHYB? (A/N): ',KOUT)
               IF(KOUT.NE.1)  GOTO 0899
1502           CALL TTASKR(ITT,
     /         'SLOZKA CHYBY NEZAVISLA NA DELCE [MM]: ',KOUT,K1,1)
               IF(KOUT.EQ.-2) GOTO 0899
               IF(KOUT.LE.0)  GOTO 1502
               IF(K1.LT.0)  GOTO 1502
1002           CALL TTASKR(ITT,'PROMENLIVA SLOZKA (PS) CHYBY'//
     /' ROSTE S C-TOU MOCNINOU DELKY. C: ',KOUT,C,1)
               IF(KOUT.EQ.-2) GOTO 0899
               IF(KOUT.LE.0)  GOTO 1002
               IF(C.LT.0)  GOTO 1002
1102           CALL TTASKR(ITT,'NA UHRNNE CHYBE DELKY D=1000M SE   PS'//
     /'  PODILI HODNOTOU [MM]: ',KOUT,K2,1)
               IF(KOUT.EQ.-2) GOTO 0899
               IF(KOUT.LE.0)  GOTO 1102
               IF(K2.LT.0)  GOTO 1102
               IF(CHYBA(K1+K2))  GOTO 0800
               DO 1100 I=1,SMPOC
1100           IF(TYPP(I).EQ.'D')
     /         STRCH(I) = K1 + K2*(PRVEK(I)/1000)**C
               ZMENA = .TRUE.
               ZMENAD = .TRUE.
0899        CONTINUE
0699     CONTINUE
0599  CONTINUE
      IF(.NOT.ZMENA)  RETURN
      SS = MIN(SS,3)
      CALL GDSSTR(1,4)
      WRITE(GSGDPT,36)
      IF(.NOT.ZMENAD)  RETURN
      CALL GDSSTR(4,0)
      WRITE(GSGDPT,361)  K1,K2,C
      RETURN
C
      END
