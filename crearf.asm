; Creación de archivos de texto
; Creador: Esther Soloj
; Fecha: 31/03/2023

%include        'stdio32.asm'

SECTION .data
        filename        db      'leame.txt', 0h

SECTION .text
        global _start

_start:
        mov     ecx,0754o           ; permisos otorgados sobre el archivo rwx
        mov     ebx,filename
        mov     eax, 8
        int     80h

        call    salir