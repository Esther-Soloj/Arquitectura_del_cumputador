; Contador de 0 a 10 con impresion en pantalla
; Creador: Esther
; Fecha: 22/03/2023

%include        'stdio32.asm'

SECTION .text
        global _start

_start:
        mov         ecx, 0
nextNum:
        mov         eax, ecx
        call        printIntLf
        inc         ecx
        cmp         ecx, 10
        jne         nextNum
        call        endP