SEUIL EQU 3
INA EQU 0xFF00
OUTA EQU 0xFF02
LOADA EQU 0xFF10
SP EQU R15 //tete de pile
BP EQU R14 //pointeur dans la pile
STACKA EQU 0x1000

    ORG LOADA
    START LOADA
DEBUT LDW SP,#STACKA
    LDW R2,@INA //lire val dans parametre (R2)
    STW R2, -(SP) //store R2
    STW SP,BP // BP <= SP (parameter address)
    LDW R2,#SEUIL
    STW R2, -(SP) // store seuil in stack
    JSR @DISTA
    ADQ 4,SP // downgrade stack pointer
    STW R0,@OUTA //ecrire la sortie dans outa
    JMP #DEBUT-$-2

DISTA STW R1,-(SP) //PUSH R1
    LDW R2,(BP) //Load R2 via BP
    LDW R1,-(BP) //charge le seuil dans R1 via BP
    SUB R2,R1,R0 // soustrait par le seuil
    JSR @ABSA
    SRA R0,R0 // div par 2
    LDW R1,(SP)+ // POP R1
    RTS

ABSA LDW R0,R0 // fonction abs, reload flag
    JGE #FABSA-$-2
    NEG R0,R0
FABSA RTS
