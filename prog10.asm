SEUIL EQU 3
INA EQU 0xFF00
OUTA EQU 0xFF02
LOADA EQU 0xFF10
SP EQU R15
STACKA EQU 0x1000

    ORG LOADA
    START LOADA
DEBUT LDW SP,#STACKA
    LDW R2,@INA //lire val dans parametre (R2)
    JSR @DISTA
    STW R0,@OUTA //ecrire la sortie dans outa
    JMP #DEBUT-$-2

DISTA STW R1,-(SP) //PUSH R1
    LDW R1,#SEUIL //charge le seuil dans R1
    SUB R2,R1,R2 // soustrait par le seuil
    JGE #POSIT-$-2
    NEG R2,R2
POSIT SRA R2,R0
    LDW R1,(SP)+ // POP R1
    RTS
