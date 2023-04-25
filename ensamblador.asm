SECTION .text
        global _start

_start
        mov     ecx, 0              ; ecx = 0

        mov     eax, ecx            ; eax = ecx
        add     eax, 48             ; eax = ecx + 48 = chr(eax)
        push    eax                 ; coloca el contenido de eax en pila
        mov     eax, esp            ; eax = posicion actual de la pila
        call    printStrLn

        pop     eax
        inc     ecx
        cmp     ecx, 9              ; if (ecx == 9)
        jne     nextNum

        call    endP