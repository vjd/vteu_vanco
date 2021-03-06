;; 1. Based on: 0
;; 2. Description: Estimation model for 200 subjects 
;; x1. Author: vijay

$PROBLEM    Vanc protocol prec analysis
$INPUT      ID TIME TAD EVID AMT CMT II ADDL GFR AGEYR NSAMP OID GID CENT=DROP 
DV OCLI OVI BW AGE SCR
$DATA      q6dosing.csv IGNORE=@ IGNORE(NSAMP.GT.200)

$MODEL NCOMP=2 COMP=(CENT) COMP=(AUC)

$PK
SCREFF = (0.48/SCR)**0.361
BWEFF  = (BW**0.75)
AGEEFF = (LOG(AGE)/7.8)**0.995

TVCL = THETA(1)*SCREFF*BWEFF*AGEEFF
CL = TVCL*EXP(ETA(1));

TVVc = THETA(2)*BW;
Vc = TVVc*ETA(2);


$DES
DADT(1) = - (CL/Vc)*A(1);
DADT(2) = A(1)/Vc

AUC24 = 0
IF(TIME.EQ.24) AUC24 = A(2)

AUC48 = 0
IF(TIME.EQ.48) AUC48 = A(2)

AUC24SS = AUC48-AUC24

$ERROR
IPRED = F	
IRES = DV-IPRED
PROP=SQRT(SIGMA(1,1))*IPRED
ADD=SQRT(SIGMA(2,2))
SD=SQRT(PROP*PROP + ADD*ADD)	
IWRES = IRES/SD
Y = IPRED+IPRED*EPS(1) + EPS(2)

$OMEGA
0.01 ; CL
0.01 ; Vc

$SIGMA 
0.01 ; PE
0.05 ; AE

$ESTIMATION METHOD=1 INTER PRINT=10 MAX=9999 NOABORT SIG=2
            MSFO=msfrun6200
$COVARIANCE PRINT=E
$TABLE      ID TIME TAD EVID AMT CMT II ADDL IPRED PRED AUC24 AUC48 AUSCSS
            WRES IWRES EWRES EPRED ECWRES CWRES CPREDI CRESI CWRESI
            NPDE NOAPPEND NOPRINT ONEHEADER FILE=sdtab6200
$TABLE      ID CL Vc ETA(1) ETA(2) NOPRINT ONEHEADER
            FILE=patab6200
$TABLE      ID AGEYR BW SCR GFR NOPRINT ONEHEADER FILE=cotab6200
$TABLE      ID  NOPRINT ONEHEADER FILE=catab6200






