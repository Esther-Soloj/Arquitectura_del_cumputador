section .data
    str db '12345'  ; Cadena a convertir
    len equ $-str   ; Longitud de la cadena
    num resd 1      ; Variable para almacenar el número entero convertido

section .text
    global _start
_start:
    ; Inicializar registros
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    
    ; Recorrer la cadena y convertir los caracteres a números
    mov ecx, len
    mov esi, str
    mov edi, num
    mov ebx, 10  ; Base decimal
convert_loop:
    movzx eax, byte [esi] ; Cargar un caracter en eax
    sub eax, 48  ; Convertir de ASCII a valor numérico
    imul ebx     ; Multiplicar el número parcial por la base
    add dword [edi], eax ; Agregar el número parcial a num
    inc esi      ; Mover el puntero a la siguiente posición en la cadena
    loop convert_loop ; Repetir hasta que se hayan convertido todos los caracteres
    
    ; El número convertido ahora está en [num]
    
    ; Terminar el programa
    mov eax, 1    ; Cargar el número de la llamada al sistema para salir
    xor ebx, ebx  ; Cargar el código de salida (0 en este caso)
    int 0x80      ; Llamar al sistema para salir
