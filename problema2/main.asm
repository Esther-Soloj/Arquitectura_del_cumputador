section .data
    mensaje db 'Ingrese la base y el exponente separados por un espacio: ',0
    resultado db 'El resultado es: ',0

section .bss
    base resd 1
    exponente resd 1
    resultado_final resd 1

section .text
    global _start

exp:
    push ebp
    mov ebp, esp
    
    push ebx
    push ecx
    push edx
    
    mov ebx, [ebp+8] ; base
    mov ecx, [ebp+12] ; exponente
    mov edx, 1
    mov eax, ebx
    
    ciclo:
        cmp ecx, 0
        je salir
        
        test ecx, 1
        jz no_multiplicar
        
        imul edx, eax
        no_multiplicar:
        imul eax, eax
        shr ecx, 1
        jmp ciclo
        
    salir:
        mov [ebp+16], edx
    
    pop edx
    pop ecx
    pop ebx
    
    mov esp, ebp
    pop ebp
    ret

_start:
    ; Pedir al usuario la base y el exponente
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, base
    mov edx, 4
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, exponente
    mov edx, 4
    int 0x80
    
    ; Convertir los argumentos a números enteros
    mov eax, [base]
    mov ebx, 10
    mov ecx, 0
    mov edx, 0
    call convertir_a_entero
    mov [base], eax
    
    mov eax, [exponente]
    mov ebx, 10
    mov ecx, 0
    mov edx, 0
    call convertir_a_entero
    mov [exponente], eax
    
    ; Llamar a la función exp para calcular el resultado
    push dword [base]
    push dword [exponente]
    call exp
    
    ; Imprimir el resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, resultado_len
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, [resultado_final]
    mov edx, 4
    int 0x80
    
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

convertir_a_entero:
    push ebp
    mov ebp, esp
    
    push ebx
    push ecx
    push edx
    
    xor eax, eax
    mov esi, [ebp+8]
    
    siguiente_digito:
        cmp byte [esi], 0
        je convertido
        
        movzx ebx, byte [esi]
        cmp ebx, '0'
        jl convertido
        cmp ebx, '9'
        jg convertido
        
        imul eax, 10
        sub ebx, '0'
        add eax, ebx
        
        inc esi
        jmp siguiente_digito
        
    convert
