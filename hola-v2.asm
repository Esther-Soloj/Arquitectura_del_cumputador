; Hola mundo, version 2
; creador: Esther Soloj
; fecha: 03/03/2023
; Ejemplo #1 de ensambaldor

SECTION .data
        msg    db   'Hola Arquitectura I', 0Ah  ; msg es la cadena


SECTION .text
global _start

_start:
        mov     ebx, msg           ; mueve la direccion de la cadena ebx
        mov     eax, ebx           ; eax = ebx

sigChar:
        cmp     byte[eax],0        ; if msg[eax] == 0
        jz      final              ; saltar al final
        inc     eax                ; eax++
        jmp     sigChar

final:
        sub     eax, ebx

        mov     exd, 20     ; edx = longitud de cadena
        mov     ecx, msg    ; ecx = cadena
        mov     ebx, 1      ; STDOUT file
        mov     eax, 4      ; funcion de sistema SYS_WRITE
        int     80h

        mov     ebx, 0      ; return 0
        mov     eax, 1      ; llamar a SYS_EXIT (kernel opcode 1)
        int     80h
