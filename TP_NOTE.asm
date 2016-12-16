SP EQU R15                   // initialisation de la  pile
STACKA EQU 0x1000            // base de la pile
CNTMA EQU 0xFF00             // adresse memoire a incrementer
INIT EQU 0x0000              // valeur d'initialisation de CNTMA
MAX EQU 0x006F               // si CNTMA > MAX, RAZ
INC EQU 0x0010               // valeur a ajouter a CNTMA
LOADA EQU 0xFF10
VECTA2 EQU 0x0088    // adresse du vecteur IRQ2 : 4x(32+2)=0x0088
VECTA3 EQU 0x008C    // adresse du vecteur IRQ3 : 4x(32+3)
ORG LOADA                    // chargement du programme
START LOADA                  // adresse de la premiere instruction

MAIN_PRGA LDW SP,#STACKA     // initialisation du stackpointer
    LDW R0,#INIT             // on charge la valeur d'init adns R0
    STW R0,@CNTMA            // initialisation de CNTMA
    LDW R1,#MAX              // on charge la valeur max dans R1
    LDW R2,#IT_PRGA          // intialisation table vecteur IRQ2
    STW R2, @VECTA2
    LDW R2,#NOV_PRGA         // intialisation table vecteur IRQ3
    STW R2, @VECTA3
    ENI                      //activation des interruptions
LOOP DSI                     // on interdit les interruptions
    LDW R0, @CNTMA           // on charge CNTMA dans R0
    ADQ INC, R0              // incrementation de R0
    TRP #34                  
    CMP R0, R1               // on compare R0 et R1
    BLE STORE-$-2            // si R0 <= MAX, on va a STORE
    LDW R0, #INIT            // sinon, on reinitialise R0 a 0
    STW R0, @CNTMA           // on charge R0 a l'adresse CNTMA
STORE STW R0, @CNTMA         // on charge R0 a l'adresse CNTMA
    ENI                      //activation des interruptions
    JMP #LOOP-$-2            // jump au debut de loop

CNTIA EQU 0xFF00             // adresse de cnti
INC2 EQU 0x0002              // valeur a ajouter a cnti

IT_PRGA STW R0, -(SP)        // sauve R0
    LDW R0, @CNTIA           // on copie cnti dans R0
    ADQ INC2, R0             // on ajoute INC2 a R0
    STW R0, @CNTIA           // on recopie R0 dans cnti
    LDW R0, (SP)+            // recupere R0
    ENI                      // reactive les interruptions
    RTI                      // sortie d'interruption

DIFF EQU 0x0001
NOV_PRGA STW R0, -(SP)
     LDW R0, @CNTMA // on copie cntm dans R0
     ADQ -DIFF, R0 // on soustraie DIFF de R0
     STW R0, @CNTMA // on recopie R0 dans cntm
     LDW R0, (SP)+
     ENI
     RTI
