section .data
    stack    times 1000 dq 0     ; pila para almacenar los valores
    top      dq 0                ; apuntador al tope de la pila

section .bss
    input    resb 256            ; buffer de entrada para leer las instrucciones

section .text
    global _start

_start:
    ; Imprimir las instrucciones de uso
    mov eax, 4
    mov ebx, 1
    mov ecx, instrucciones
    mov edx, instrucciones_len
    int 0x80

    ; Loop principal
main_loop:
    ; Leer la entrada del usuario
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 256
    int 0x80

    ; Verificar si la entrada es un número
    mov eax, input
    call es_numero
    cmp eax, 1
    je .es_numero

    ; Si no es un número, entonces verificar si es una operación
    mov eax, input
    call es_operacion
    cmp eax, 1
    je .es_operacion

    ; Si no es un número ni una operación, entonces imprimir un mensaje de error y volver al inicio del loop
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, error_len
    int 0x80
    jmp main_loop

.es_numero:
    ; Convertir la cadena a un número y almacenarlo en la pila
    push input
    call atoi
    mov [stack + 8 * [top]], eax
    add [top], 8
    jmp main_loop

.es_operacion:
    ; Verificar si la operación es válida
    mov eax, input
    cmp byte [eax], '+'
    je .suma
    cmp byte [eax], '-'
    je .resta
    cmp byte [eax], '*'
    je .multiplicacion
    cmp byte [eax], '/'
    je .division

    ; Si la operación no es válida, imprimir un mensaje de error y volver al inicio del loop
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, error_len
    int 0x80
    jmp main_loop

.suma:
    ; Verificar si hay suficientes elementos en la pila para realizar la operación
    cmp [top], 16
    jl .faltan_elementos

    ; Obtener los dos valores superiores de la pila y sumarlos
    sub [top], 16
    fld qword [stack + [top]]
    fld qword [stack + [top] + 8]
    fadd st1, st0

    ; Almacenar el resultado en la pila y volver al inicio del loop
    fstp qword [stack + [top]]
    jmp main_loop

.resta:
   
