      VERZE(2:3) = '01'
      OPEN (UNIT=ITT,FILE='CON')
      OPEN (UNIT=GSGDPT,FILE=' ',STATUS='UNKNOWN',
     /  ACCESS='SEQUENTIAL',FORM='FORMATTED')
