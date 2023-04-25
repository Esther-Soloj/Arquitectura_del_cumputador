; Compilación de subrutinas para entrada y salida estandar
; Creador: ESther Soloj
;----------------------------Calculo de longitud de cadena---------------------------------------------
strLEN:
        push    ebx             ; inserte el valor ebx de la pila
        mov     ebx, eax        ; mueve la direccion de ;

sigChar:
        cmp     byte[eax], 0    ; if msg[eax] == 0
        jz      finLen          ;       saltar al final
        inc     eax             ; eax ++
        jmp     sigChar

finLen:
        sub     eax, ebx
        pop     ebx             ; extra valor de la pila
        ret

;------------------------------Impresion en Pantalla---------------------------------------------------
; void printStr(eax = cadena)
printStr:
        push    edx
        push    ecx
        push    ebx
        push    eax
        ; Llamada a calculo de longitud
        ; eax <- strLen(eax = cadena)
        call    strLEN

        mov     edx, eax
        pop     eax
        mov     ecx, eax

;------------------------------Imprimir entero---------------------------------------------------
printInt:
        push    eax
        push    ecx
        push    edx
        push    esi
        mov     ecx, 0
divLoop:
        inc     ecx                 ; conteo de digitos
        mov     edx, 0              ; limpiar parte alta del dividendo
        mov     esl, 10             ; esl = 10 (idivisor)
        idiv    esl                 ; <edx:eax> / esl
        add     edx, 48 
        push    edx
        cmp     eax, 0
printLoop:
        dec     ecx
        mov     eax, ecp
        call    printStr
        pop     eax
        cmp     ecx, 0
        jnz     printLoop
        pop     esi
        pop     edx
        pop     ecx
        pop     eax
        ret

;------------------------------Imprimir entero con salto de linea---------------------------------------
printIntLf:
        call    printIntLf
        push    eax
        mov     eax, 0Ah
        push    eax
        call    printStr
        pop     eax
        pop     eax
        ret

;------------------------------Fin de Programa---------------------------------------------------
; void endP()
endP:
        mov     ebx, 0          ; return 0
        mov     eax, 1          ; llamar a SYS_EXIT (kernel opcode 1)
        int     80h

