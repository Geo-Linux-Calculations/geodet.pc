C+
C NGOOS1
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C NAZEV: Procedura pro orientaci osnovy smeru                         *
C AUTOR: Jaroslava Horejcova, VUGTK, nyni Geodezie, s. p., Praha,     *
C        Frantisek Charamza, VUGTK                                    *
C VERZE: 1.00                                                         *
C DATUM: 1989-06-30                                                   *
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	SUBROUTINE NGOOS1 (SIGMA,PSI,P,N,Z,QZ,M0,M0RED,INDEX,IER)
	DIMENSION  SIGMA(1),PSI(1),P(1)
	REAL       Z,QZ,M0,M0RED
	INTEGER    N,INDEX,IER	
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C FUNKCE: Procedura pocita orientacni posun osnovy smeru jako obecny  *
C    aritmeticky prumer rozdilu mezi smerniky volitelneho poctu N     *
C    (1 .LE. N .LE. 20) orientacnich bodu a jim odpovidajicimi mere-  *
C    nymi smery.                                                      *
C PREHLED PARAMETRU                                                   *
C VSTUPNI PARAMETRY:                                                  *
C    SIGMA  - smerniky v obloukove mire                               *
C    PSI    - smery v obloukove mire                                  *
C    P      - vahy merenych smeru                                     *
C    N      - pocet orientacnich bodu                                 *
C VYSTUPNI PARAMETRY:                                                 *
C    Z      - orientacni posun v obloukove mire                       *
C    QZ     - vahovy koeficient vypocteneho (vyrovnaneho) orientacni- *
C             ho posunu                                               *
C    M0     - jednotkova stredni chyba v obloukove mire               *
C    M0RED  - jednotkova stredni chyba (v obloukove mire) pro reduko- *
C             vanou osnovu smeru - minimalni stredni chyba, ktere lze *
C             dosahnout vypustenim jednoho orientacniho bodu          *
C    INDEX  - index "podezreleho" orientacniho bodu (smeru)           *
C    IER    - IER = 0  regularni uloha                                *
C             IER = 1  singularita - N lezi mimo definovany interval  *
C             IER =-1  nektera vaha nenabyva kladne hodnoty           *
C ARITMETIKA S JEDNODUCHOU DELKOU SLOVA                               *
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C-
	REAL       LP,L(20)
C
	IF(N.LT.1.OR.N.GT.20) GO TO 24
	PI=ATAN2(0.,-1.)
	PI2=PI+PI
	SUMAPL=0
	SUMAP=0
	L(1)=0
	DO 10 I=1,N
	LP=SIGMA(I)-PSI(I)
	IF(LP.LT.0.) LP=LP+PI2
	IF(LP-L(1).GT.PI) LP=LP-PI2
	L(I)=LP
	IF(P(I).LE.0.) GO TO 25
	SUMAPL=SUMAPL+P(I)*LP
	SUMAP=SUMAP+P(I)
10	CONTINUE
	INDEX=1
	IER=0
	Z=SUMAPL/SUMAP
	QZ=1./SUMAP
	IF(N.EQ.1) GO TO 21
	DELTA=0
	SUMPVV=0
	DO 20 I=1,N
	V2=P(I)*(L(I)-Z)**2
	DI=SUMAP-P(I)
	IF(DI.LT.1E-5*SUMAP) GO TO 20
	DI=SUMAP*V2/DI
	IF(DI.LE.DELTA) GO TO 15
	INDEX=I
	DELTA=DI
15	SUMPVV=SUMPVV+V2
20	CONTINUE
	M0=SQRT(SUMPVV/(N-1))
	IF(N.LE.2) GO TO 22
	M0RED=SQRT(AMAX1(SUMPVV-DELTA,0.)/(N-2))
	GO TO 23
21	M0=0
22	M0RED=0
23	IF(Z.LT.0.) Z=Z+PI2
	RETURN
24	IER=1
	RETURN
25	IER=-1
	RETURN
	END

