$PARAM CL= 0.248, V= 0.636, SCR=0.7, AGE=2190, BW=22

$SET end=120, delta=0.1 

$CMT CENT 

$MAIN
D_CENT = 1;
$PKMODEL ncmt=1, trans=2
$TABLE
double DV = CENT/V;
$CAPTURE
DV CL V BW AGE SCR