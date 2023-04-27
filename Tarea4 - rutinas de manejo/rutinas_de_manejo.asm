section .data
cursor_pos db 0, 0 ; Almacena la posición actual del cursor en pantalla

section .bss
buffer resb 128 ; Espacio para almacenar los datos que se escribirán en pantalla

section .text
global _start

_start:
    ; Configuramos el modo de la consola
    mov eax, 0x00000003 ; Número de llamada al sistema para ioctl
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, 0x00000004 ; Código para configurar el modo de la consola
    mov edx, 0x00000001 ; Habilitar el modo de la consola
    int 0x80

    ; Escribimos un mensaje en pantalla
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, buffer ; Dirección de memoria del mensaje
    mov edx, 13 ; Longitud del mensaje
    mov byte [buffer], 'H' ; Escribimos el mensaje en el buffer
    mov byte [buffer+1], 'o'
    mov byte [buffer+2], 'l'
    mov byte [buffer+3], 'a'
    mov byte [buffer+4], ' '
    mov byte [buffer+5], 'M'
    mov byte [buffer+6], 'u'
    mov byte [buffer+7], 'n'
    mov byte [buffer+8], 'd'
    mov byte [buffer+9], 'o'
    mov byte [buffer+10], '!'
    mov byte [buffer+11], 10 ; Añadimos un salto de línea al final
    mov byte [buffer+12], 0 ; Añadimos un terminador nulo al final
    int 0x80

    ; Obtenemos la posición actual del cursor en pantalla
    mov eax, 0x00000004 ; Número de llamada al sistema para ioctl
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, 0x00000003 ; Código para obtener la posición del cursor
    mov edx, cursor_pos ; Dirección de memoria para almacenar la posición del cursor
    int 0x80

    ; Movemos el cursor a una nueva posición
    mov eax, 0x00000004 ; Número de llamada al sistema
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, 0x00000002 ; Código para mover el cursor a una nueva posición
    mov edx, 0x00010001 ; Nueva posición del cursor (fila 1, columna 1)
    int 0x80

    ; Escribimos otro mensaje en pantalla en la nueva posición del cursor
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, buffer ; Dirección de memoria del mensaje
    mov edx, 13 ; Longitud del mensaje
    mov byte [buffer], 'H' ; Escribimos el mensaje en el buffer
    mov byte [buffer+1], 'o'
    mov byte [buffer+2], 'l'
   
