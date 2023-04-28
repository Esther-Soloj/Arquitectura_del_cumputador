section .data
    str1 db 'Esta es la',0
    str2 db 'cadena de ejemplo',0
    result db 100 dup(0)

section .text
    global _start

strCat:
    push ebp
    mov ebp, esp
    
    push edi
    push esi
    
    mov edi, result
    mov esi, [ebp+8]
    movsb
    mov esi, [ebp+12]
    movsb
    
    pop esi
    pop edi
    
    mov esp, ebp
    pop ebp
    ret

_start:
    ; Pedir al usuario las dos cadenas de caracteres
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje1
    mov edx, mensaje1_len
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, str1
    mov edx, 100
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje2
    mov edx, mensaje2_len
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, str2
    mov edx, 100
    int 0x80
    
    ; Llamar a la función strCat para concatenar las cadenas
    push dword str1
    push dword str2
    call strCat
    
    ; Imprimir la cadena resultante
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 100
    int 0x80
    
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

mensaje1 db 'Escriba la cadena 1 a utilizar: ',0
mensaje1_len equ $-mensaje1

mensaje2 db 'Escriba la cadena 2 a utilizar: ',0
mensaje2_len equ $-mensaje2

resultado db 'Cadena copiada: ',0
