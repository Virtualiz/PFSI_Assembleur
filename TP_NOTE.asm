SP EQU R15 // initialisation de la  pile
CNTMA EQU 0xFF00 // adresse memoire a incrementer
INIT EQU 0x0000 // valeur d'initialisation de CNTMA
MAX EQU 0x006F // si CNTMA > MAX, RAZ
INC EQU 0x0010 // valeur a ajouter a CNTMA
MAIN_PRGA EQU 0xFF10
STACKA EQU 0x1000 // base de la pile

ORG MAIN_PRGA // chargement du programme
START DEBUT // adresse de la premiere instruction

DEBUT LDW SP,#STACKA // initialisation du stackpointer
    LDW R0,#INIT // on charge la valeur d'init adns R0
    STW R0,@CNTMA // initialisation de CNTMA
    LDW R1,#MAX // on charge la valeur max dans R1
LOOP LDW R0, @CNTMA // on charge CNTMA dans R0
    ADQ INC, R0 // incrementation de R0
    CMP R0, R1 // on compare R0 et R1
    BLW STORE-$-2 // si R0 <= MAX, on va a STORE
    LDW R0, #INIT // sinon, on reinitialise R0 a 0
    STW R0, @CNTMA // on charge R0 a l'adresse CNTMA
STORE STW R0, @CNTMA // on charge R0 a l'adresse CNTMA
    JMP #LOOP-$-2 // jump au debut de loop
