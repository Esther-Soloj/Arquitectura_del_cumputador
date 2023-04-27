section .data
cadena db "CADENA EN MAYUSCULAS", 0

section .text
global _start

_start:
    ; Guardamos la dirección de memoria de la cadena en el registro rsi
    mov rsi, cadena

    ; Procesamos cada caracter de la cadena
    procesar_caracter:
        ; Cargamos el caracter en el registro al
        mov al, byte [rsi]

        ; Comprobamos si el caracter está en mayúsculas (entre 'A' y 'Z')
        cmp al, 'A'
        jl no_es_mayuscula
        cmp al, 'Z'
        jg no_es_mayuscula

        ; Convertimos el caracter a minúsculas (sumando 32)
        add al, 32

    no_es_mayuscula:
        ; Escribimos el caracter en la posición correspondiente de la cadena
        mov byte [rsi], al

        ; Incrementamos la dirección de memoria de la cadena para procesar el siguiente caracter
        inc rsi

        ; Comprobamos si hemos llegado al final de la cadena
        cmp byte [rsi], 0
        jne procesar_caracter

    ; Mostramos la cadena convertida a minúsculas en la consola
    mov eax, 4 ; Número de llamada al sistema para write
    mov ebx, 1 ; Descriptor de archivo para stdout
    mov ecx, cadena ; Dirección de memoria de la cadena
    mov edx, len ; Longitud de la cadena
    int 0x80

    ; Salimos del programa
    mov eax, 1 ; Número de llamada al sistema para exit
    xor ebx, ebx ; Código de salida 0
    int 0x80

section .bss
len resb 1 ; Longitud de la cadena
