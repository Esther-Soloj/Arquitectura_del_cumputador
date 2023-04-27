section .data
mensaje db "MENSAJE DESPLAZÁNDOSE CÍCLICAMENTE EN LA PANTALLA"
longitud equ $-mensaje

section .text
global _start

_start:
    ; Establecemos la velocidad de desplazamiento en caracteres por segundo
    mov ecx, 20 ; 20 caracteres por segundo

    ; Convertimos la velocidad a ticks por segundo (100 ticks por segundo)
    mov eax, 100
    div ecx
    mov ecx, eax

    ; Inicializamos el contador de ticks a 0
    xor ebx, ebx

    ; Mostramos el mensaje desplazándose cíclicamente en la consola
    mostrar_mensaje:
        ; Calculamos el desplazamiento del mensaje en caracteres
        mov eax, ebx
        xor edx, edx
        div longitud
        mov esi, edx

        ; Escribimos el mensaje en la consola
        mov eax, 4 ; Número de llamada al sistema para write
        mov ebx, 1 ; Descriptor de archivo para stdout
        lea ecx, [mensaje+esi] ; Dirección de memoria del mensaje
        mov edx, longitud-esi ; Longitud del mensaje desde el desplazamiento
        int 0x80

        ; Esperamos el tiempo de desplazamiento
        mov eax, 0 ; Número de llamada al sistema para nanosleep
        mov ebx, 0 ; Tipo de reloj (0 para CLOCK_REALTIME)
        mov ecx, 0 ; Estructura timespec (segundos)
        mov edx, ecx ; Estructura timespec (nanosegundos)
        mov esi, ecx ; Puntero a la estructura timespec de entrada
        lea edi, [espacio] ; Puntero a la estructura timespec de salida
        mov dword [espacio], ecx ; Segundos
        mov dword [espacio+4], ecx ; Nanosegundos
        add dword [espacio+4], ecx ; Nanosegundos = 1000000000 / 100
        mov dword [espacio+8], ecx ; Espacio de alineación
        mov esi, espacio ; Puntero a la estructura timespec de entrada
        syscall

        ; Incrementamos el contador de ticks
        add ebx, ecx

        ; Volvemos al inicio del mensaje
        cmp esi, 0
        jne mostrar_mensaje

    ; Salimos del programa
    mov eax, 1 ; Número de llamada al sistema para exit
    xor ebx, ebx ; Código de salida 0
    int 0x80

section .bss
espacio resb 16 ; Espacio para la estructura timespec