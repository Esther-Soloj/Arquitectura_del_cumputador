section .data
mensaje1 db "Introduce tu nombre: "
mensaje2 db "Introduce tu edad: "
saludo db "¡Hola, "
salto db 10 ; Carácter de salto de línea
longitud1 equ $-mensaje1
longitud2 equ $-mensaje2

section .bss
nombre resb 100 ; Espacio para almacenar el nombre introducido por el usuario
edad resb 3 ; Espacio para almacenar la edad introducida por el usuario

section .text
global _start

_start:
    ; Solicitamos el nombre del usuario
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, mensaje1 ; Dirección de memoria del mensaje
    mov edx, longitud1 ; Longitud del mensaje
    int 0x80

    ; Leemos el nombre del usuario
    mov eax, 3 ; Número de llamada al sistema para read
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, nombre ; Dirección de memoria para almacenar los datos leídos
    mov edx, 100 ; Longitud máxima a leer
    int 0x80

    ; Solicitamos la edad del usuario
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, mensaje2 ; Dirección de memoria del mensaje
    mov edx, longitud2 ; Longitud del mensaje
    int 0x80

    ; Leemos la edad del usuario
    mov eax, 3 ; Número de llamada al sistema para read
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, edad ; Dirección de memoria para almacenar los datos leídos
    mov edx, 3 ; Longitud máxima a leer
    int 0x80

    ; Mostramos un saludo al usuario
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, saludo ; Dirección de memoria del mensaje
    mov edx, 6 ; Longitud del mensaje
    int 0x80

    ; Mostramos el nombre introducido por el usuario
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, nombre ; Dirección de memoria del nombre
    xor edx, edx
    mov bl, byte [edx+nombre] ; Longitud del nombre introducido
    inc edx
    add edx, ebx
    mov byte [edx], ',' ; Añadimos una coma después del nombre
    inc edx
    mov byte [edx], ' ' ; Añadimos un espacio después de la coma
    inc edx
    mov byte [edx+1], 0 ; Añadimos un terminador nulo al final del mensaje
    add edx, 2 ; Añadimos 2 al puntero para saltar sobre la coma y el
