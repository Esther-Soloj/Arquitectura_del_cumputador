section .data
num1 db '0' ; Primer número de la operación
num2 db '0' ; Segundo número de la operación
op db '+' ; Operador de la operación
result db '0' ; Resultado de la operación

section .bss
input resb 16 ; Espacio para almacenar la entrada del usuario

section .text
global _start

_start:
    ; Pedimos el primer número
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, msg1 ; Dirección de memoria del mensaje
    mov edx, 23 ; Longitud del mensaje
    int 0x80

    mov eax, 3 ; Número de llamada al sistema para read
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, input ; Dirección de memoria para almacenar la entrada del usuario
    mov edx, 16 ; Longitud máxima de la entrada
    int 0x80

    mov eax, [input] ; Convertimos la entrada a número
    sub eax, '0'
    mov [num1], al

    ; Pedimos el segundo número
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, msg2 ; Dirección de memoria del mensaje
    mov edx, 24 ; Longitud del mensaje
    int 0x80

    mov eax, 3 ; Número de llamada al sistema para read
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, input ; Dirección de memoria para almacenar la entrada del usuario
    mov edx, 16 ; Longitud máxima de la entrada
    int 0x80

    mov eax, [input] ; Convertimos la entrada a número
    sub eax, '0'
    mov [num2], al

    ; Pedimos el operador
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, msg3 ; Dirección de memoria del mensaje
    mov edx, 23 ; Longitud del mensaje
    int 0x80

    mov eax, 3 ; Número de llamada al sistema para read
    mov ebx, 0 ; Descriptor de archivo para stdin
    mov ecx, input ; Dirección de memoria para almacenar la entrada del usuario
    mov edx, 16 ; Longitud máxima de la entrada
    int 0x80

    mov al, [input] ; Convertimos la entrada a operador
    mov [op], al

    ; Realizamos la operación
    cmp byte [op], '+' ; Suma
    je suma
    cmp byte [op], '-' ; Resta
    je resta
    cmp byte [op], '*' ; Multiplicación
    je multiplicacion
    cmp byte [op], '/' ; División
    je division
    ; Si no se reconoce el operador, terminamos el programa
    jmp fin

suma:
    mov al, [num1]
    add al, [num2]
    mov [result], al
    jmp desplegar_resultado

resta:
    mov al, [
