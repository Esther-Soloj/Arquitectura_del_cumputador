; Abrir archivo
; Creador: ESther Soloj
; Fecha: 12/44/2023
; Apertura de archivos en modo lectura

%include 'stdio32.asm'

SECTION .data
        filename        db          'readme.txt', 0h

SECTION .bss
        linea       resb 255

SECTON .text
        global _start

_start:
        mov         ecx, 0              ; Bandera para acceso en modo 0_RDONLY
        mov         ebx, filename
        mov         eax, 5             ; invocar SYS_OPEN
        int         80h

        mov         edx, 12
        mov         ecx, linea
        mov         ebx, eax
        mov         eax, 3
        int 80h

        mov         eax, linea
        call        printStrLn

        mov         ebx, ebx
        mov         eax, 6
        int         80h

        call        salir