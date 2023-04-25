; Abrir archivo
; Creador: ESther Soloj
; Fecha: 12/44/2023
; Apertura de archivos en modo lectura

%include 'stdio32.asm'

SECTION .data
        filename        db          'readme.txt', 0h

SECTON .text
        global _start

_start:
        mov         ecx, 0              ; Bandera para acceso en modo 0_RDONLY
        mov         ebx, filename
        mov         eax, 5             ; invocar SYS_OPEN
        int         80h

        call printIntLn