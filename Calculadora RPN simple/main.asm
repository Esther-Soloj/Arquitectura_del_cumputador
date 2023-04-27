section .data
    input db "%lf", 0 ; formato de entrada para scanf
    output db "%lf", 10, 0 ; formato de salida para printf
    stack_size equ 10 ; tamaño máximo de la pila

section .bss
    stack resq stack_size ; reserva espacio para la pila

section .text
    global _start

_start:
    ; muestra el mensaje de bienvenida y las instrucciones de uso
    mov eax, 4 ; llamada al sistema para imprimir en pantalla
    mov ebx, 1 ; descriptor de archivo para stdout
    mov ecx, welcome_msg ; dirección del mensaje de bienvenida
    mov edx, welcome_len ; longitud del mensaje de bienvenida
    int 0x80 ; realiza la llamada al sistema

    ; inicializa el puntero de la pila
    mov edi, stack
    ; inicializa el contador de la pila
    xor ecx, ecx

loop:
    ; muestra el prompt
    mov eax, 4 ; llamada al sistema para imprimir en pantalla
    mov ebx, 1 ; descriptor de archivo para stdout
    mov ecx, prompt_msg ; dirección del mensaje de prompt
    mov edx, prompt_len ; longitud del mensaje de prompt
    int 0x80 ; realiza la llamada al sistema

    ; lee la entrada del usuario y la coloca en la pila
    mov eax, 0 ; llamada al sistema para leer desde stdin
    mov ebx, 0 ; descriptor de archivo para stdin
    mov edx, input_size ; tamaño de la entrada
    mov esi, edi ; dirección donde se almacena la entrada
    int 0x80 ; realiza la llamada al sistema

    ; convierte la entrada en un número de punto flotante
    fld qword [edi]
    ; incrementa el puntero de la pila y el contador de la pila
    add edi, 8
    inc ecx

    ; verifica si la pila está llena
    cmp ecx, stack_size
    jg stack_full

    ; lee la operación del usuario
    mov eax, 0 ; llamada al sistema para leer desde stdin
    mov ebx, 0 ; descriptor de archivo para stdin
    mov edx, 2 ; tamaño de la entrada (1 para el operador y 1 para la nueva línea)
    mov esi, operator ; dirección donde se almacena el operador
    int 0x80 ; realiza la llamada al sistema

    ; realiza la operación correspondiente
    cmp byte [operator], '+' ; suma
    je add
    cmp byte [operator], '-' ; resta
    je sub
    cmp byte [operator], '*' ; multiplicación
    je mul
    cmp byte [operator], '/' ; división
    je div
    cmp byte [operator], 'q' ; salir
    je quit
    ; si no es ninguna de las operaciones anteriores, muestra un mensaje de error
    jmp invalid_op

add:
    ; verifica si hay al menos dos elementos en la pila
    cmp ecx, 2
    jl invalid_op
    ; saca los dos primeros elementos de la pila y los suma
    fadd qword [edi-16]
    ; decrementa el puntero de la pila y el contador de la pila
    sub edi, 8
    dec ecx
    ; muestra
