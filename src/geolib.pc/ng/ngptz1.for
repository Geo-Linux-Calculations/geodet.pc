C+
C NGPTZ1
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C NAZEV: Procedura pro vypocet souradnic bodu protinanim zpet         *
C AUTOR: Frantisek Charamza, VUGTK,                                   *
C        Eliska Valkova, VUGTK, nyni RIS hl. m. Prahy                 *
C VERZE: 1.00                                                         *
C DATUM: 1989-06-30                                                   *
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
        SUBROUTINE NGPTZ1 (Y,X,SMER,IER)
        DIMENSION Y(4),X(4),SMER(3)
        INTEGER IER
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C FUNKCE: Procedura vypocte souradnice bodu protinanim zpet ze tri    *
C    smeru metodou Cassiniho.                                         *
C PREHLED PARAMETRU                                                   *
C VSTUPNI PARAMETR:                                                   *
C    SMER   - pole pro ulozeni urcujicich smeru (v obloukove mire)    *
C VYSTUPNI PARAMETR:                                                  *
C    IER    - IER = 0  regularni uloha                                *
C             IER = 1  singularita - prusecik urcujicich smeru je ne- *
C                                    jisty                            *
C             IER =-1  singularita - hledany bod lezi blizko nebez-   *
C                                    pecne kruznice                   *
C VSTUPNI/VYSTUPNI PARAMETRY:                                         *
C    Y,X    - pole pro ulozeni souradnic; souradnice danych bodu musi *
C             byt pred vyvolanim procedury ulozeny do pozic Y(1),     *
C             X(1), Y(2), X(2), Y(3), X(3); vypoctene souradnice ulo- *
C             zi procedura do promennych Y(4), X(4)                   *
C ARITMETIKA S JEDNODUCHOU DELKOU SLOVA                               *
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C-
      IER=0
      DO 1 I=1,3
      J=MOD(I,3)+1
      K=MOD(J,3)+1
      SIN1=SIN(SMER(J)-SMER(I))
      SIN2=SIN(SMER(K)-SMER(I))
      IF  ((ABS(SIN1).GT.0.15).AND.(ABS(SIN2).GT.0.15)) GO TO 2
    1 CONTINUE
      IER=1
      RETURN
    2 DYIJ=Y(J)-Y(I)
      DXIJ=X(J)-X(I)
      DYIK=Y(K)-Y(I)
      DXIK=X(K)-X(I)
      COTGIJ=COS(SMER(J)-SMER(I))/SIN1
      COTGIK=COS(SMER(K)-SMER(I))/SIN2
      F1=COTGIJ*DYIJ-DXIJ
      F2=COTGIJ*DXIJ+DYIJ
      DX=F1-COTGIK*DYIK+DXIK
      DY=F2-COTGIK*DXIK-DYIK
      D2=DX*DX+DY*DY
      IF (D2.LT.100) GO TO 3
      FAKTOR=(F2*DX-F1*DY)/D2
      Y(4)=Y(I)+FAKTOR*DX
      X(4)=X(I)+FAKTOR*DY
      RETURN
    3 IER=-1
      END
