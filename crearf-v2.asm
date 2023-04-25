; Creacion y escritura a archivo
; Creador: Esther Soloj
; Fecha: 12/04/2023
; Creacion de archivo y escritura de contenido

%include            'stdio32.asm'

SECTION .data
        filename        db          'readme.txt', 0h
        contenido       db          'Hola mundo!', 0h

SECTION .text
        global      _start

_start:
        mov     ecx, 0754o
        mov     ebx, filename
        mov     eax, 8
        int     80h

        mov     edx, 12
        mov     ecx, contenido
        mov     ebx, eax                ; Colocar el descriptor devuelto en eax
        mov     eax, 4
        int     80h

        call    salir
