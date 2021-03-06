C SYMBOLICKY CHOLESKYHO ROZKLAD
C=======================================================================
C
      SUBROUTINE GTSCHR(POCNEZ,XADJ,ADJNCY,PERM,INVP,XRNZ,XNZSUB,NZSUB,
     /                  MAXNZS,POCNEP,IOUT)
C
C POCNEZ  POCET NEZNAMYCH
C (XADJ, ADJNCY) STRUKTURA SOUSEDNOSTI MATICE TRANS(A)*A - VIZ SPARSPAK
C PERM    VEKTOR PERMUTACE NEZNAMYCH
C INVP    INVERZNI PERMUTACE
C XRNZ    VEKTOR ADRES (INDEXU) SEZNAMU NENULOVYCH PRVKU ROZKLADU
C (XNZSUB, NZSUB) VEKTORY KOMPRIMOVANEHO ULOZENI INDEXU - VIZ SPARSPAK
C MAXNZS  NA VSTUPU DIMENZE POLE NZSUB,
C         NA VYSTUPU POCET OBSAZENYCH PRVKU V POLI NZSUB
C POCNEP  POCET NENULOVYCH PRVKU V CHOLESKYHO ROZKLADU
C IOUT    VYSTUPNI PARAMETR:
C         IOUT =  0  V POLI NZSUB JSOU ULOZENY KOMPRIMOVANE INDEXY 
C         IOUT = -1  NEDOSTATECNA KAPACITA PAMETI (MAXNZS)
C
      INTEGER  POCNEZ, XADJ(1), ADJNCY(1), PERM(1), INVP(1), XRNZ(1),
     /         XNZSUB(1), NZSUB(1), MAXNZS, POCNEP, IOUT
C
      INTEGER  I, INMRG, INRCH, INMAR, FLAG
C
C     -------------------------------------------------
C     ALOKACE PAMETI PRO PRACOVNI POLE PROCEDURY SMBFCT
C     -------------------------------------------------
      IOUT = 0
      INMRG  = MAXNZS - POCNEZ
      INRCH  = INMRG  - POCNEZ
      INMAR  = INRCH  - POCNEZ
      MAXNZS = INMAR  - 1
      IF(MAXNZS.LE.0)  IOUT = -1
      IF(IOUT.LT.0)  RETURN
C     ----------------------------------------
C     SYMBOLICKY CHOLESKYHO ROZKLAD - SPARSPAK
C     ----------------------------------------
      CALL SMBFCT(POCNEZ, XADJ, ADJNCY, PERM, INVP,
     /            XRNZ, POCNEP, XNZSUB, NZSUB, MAXNZS,
     /            NZSUB(INRCH), NZSUB(INMRG), NZSUB(INMAR), FLAG)
      IOUT = -FLAG
      RETURN
C
      END
