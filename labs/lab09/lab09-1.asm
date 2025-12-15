%include 'in_out.asm'

SECTION .data
msg: DB 'Введите x: ',0
result: DB 'f(g(x)) = 2*(3x-1)+7 = ',0

SECTION .bss
x: RESB 80
final_result: RESD 1

SECTION .text
GLOBAL _start

_start:
    mov eax, msg
    call sprint
    
    mov ecx, x
    mov edx, 80
    call sread
    
    mov eax, x
    call atoi
    
    call _calcul
    
    mov eax, result
    call sprint
    mov eax, [final_result]
    call iprintLF
    
    call quit

_calcul:
    push eax
    call _subcalcul
    
    mov ebx, 2
    mul ebx
    add eax, 7
    
    mov [final_result], eax
    ret

_subcalcul:
    mov eax, [esp+4]
    mov ebx, 3
    mul ebx
    sub eax, 1
    ret
