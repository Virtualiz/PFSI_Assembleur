SEUIL EQU 3
INA EQU 0xFFA0
OUTA EQU 0xFFA2
LOADA EQU 0xFFDC

    ORG LOADA
    START LOADA
DEBUT LDW R2,@INA //lire val dans paramètre (R2)
    JSR @DISTA
    STW R0,@OUTA //ecrire la sortie dans outa
    JMP #DEBUT-$-2

DISTA LDW R1,#SEUIL //charge le seuil dans R1
    SUB R2,R1,R2 // soustrait par le seuil
    JGE #POSIT-$-2
    NEG R2,R2
POSIT SRA R2,R0
    RTS
