section .data
row db 5 ; Fila en la que colocar el cursor (comenzando en 0)
col db 10 ; Columna en la que colocar el cursor (comenzando en 0)

section .text
global _start

extern initscr, endwin, move

_start:
    ; Inicializamos ncurses
    call initscr

    ; Movemos el cursor a la posición especificada
    mov al, [row]
    mov bl, [col]
    call move

    ; Esperamos a que el usuario presione una tecla
    call getch

    ; Finalizamos ncurses
    call endwin

    ; Salimos del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
