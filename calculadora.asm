BITS 64
extern  printf  ; Para imprimir enteros
extern  scanf   ; Para escribir del teclado

%macro  imprimir 2
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, %1 ; Direccion de memoria de la cadena
    mov     rdx, %2 ; Longitud de la cadena
    syscall
%endmacro

%macro  imp_entero_1 1
    mov     rdi, result ; Formato 1
    mov     rsi, %1
    call    printf      ; Imprimir
%endmacro

%macro  imp_entero_2 1
    mov     rdi, formato    ; Formato 2
    mov     rsi, %1
    call    printf          ; Imprimir
%endmacro

%macro  capturar 1
    mov     rdi, formato    ; Formato 1
    mov     rsi, %1
    call    scanf           ; Teclado
%endmacro

section .data
    dvoy        db      "Aqui voy",10
    ldvoy       equ     $-dvoy

    menu        db      "Calculadora",10,"1. Suma",10,"2. Resta",10,"3. Multiplicación",10,"4. Division",10,"5.Salir",10,10,"Ingresa la opcion que deseas: "
    lmenu       equ     $-menu

    nu1         db      "Ingresa el Primer Numero: "
    lu1         equ     $-nu1

    nu2         db      "Ingresa el Segundo Numero: "
    lu2         equ     $-nu2

    error       db      "El numero que ingresaste no es valido",10
    lero        equ     $-error

    result      db      "El resultado es = %d",10,0
    lresult     equ     $-result

    separa      db      "-----------------------------------",10
    lsep        equ     $-separa

    sepa2       db      "| | | | | | | | | | | | | | | | | |",10,10
    lsepa2      equ     $-sepa2

    formato     db      "%d"

section .bss
    num1        resq 1  ; Numero 1
    num2        resq 1  ; Numero 2
    resul       resq 1  ; Resultado
    op          resq 1  ; Opcion

section .text
    global      _start

_start:
    imprimir    sepa2, lsepa2
    imprimir    menu, lmenu
    call        opcion
    imprimir    separa, lsep
    mov         al,[op]

    cmp         al,1
    je          suma

    cmp         al,2
    je          resta

    cmp         al,3
    je          multi

    cmp         al,4
    je          divid

    cmp         al,5
    je          salir

    imprimir    separa, lsep
    imprimir    error,lero
    imprimir    separa, lsep

    jmp         main

tope:
    mov         rax,[rsp+0]
    mov         [num1],rax
    imprimir    [num1],10
    ret

entero1:
    mov         rdi, formato
    mov         rsi, [num1]
    call        printf

opcion:
    capturar    op
    ret

parametros:
    imprimir    nu1,lu1     ; Texto numero 1
    capturar    num1
    mov         r15d, [num1]
    imprimir    separa, lsep
    imprimir    nu2, lu2
    capturar    num2
    mov         r14d,[num2]
    imprimir    separa,lsep

    ret

resu:
    imp_entero  [resul]
    imprimir    separa,lsep

    ret

suma:
    call        parametros
    call        fsum
    call        resu
    jmp         main

fsum:
    add         r15d, r14d
    mov         [resul],r15d

    ret

resta:
    call        parametros
    call        frest
    call        resu
    jmp         main

frest:
    sub         r15d,r14d
    mov         [resul],r15d

    ret

multi:
    call        parametros

    mov         rax,r15
    mov         r10,r14

    call        fmul
    call        resu
    jmp         main

fmul:
    imul        r10
    mov         [resul],rax

    ret

divid:
    call        parametros

    mov         rax,r15         ; Numerador
    mov         r10,r14         ; Denomidador
    mov         rdx,0           ; Residuo

    call        fdiv
    call        resu
    jmp         main

fdiv:
    idiv        r10
    mov         [resul],rax
    ret

salir:
    mov         rax,60
    mov         rdi,0
    syscall

main:
    jmp         _start