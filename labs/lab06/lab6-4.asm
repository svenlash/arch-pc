%include 'in_out.asm'
SECTION .data
msg: DB 'Введите x: ',0
result: DB 'Результат: ',0
SECTION .bss
x: RESB 10
SECTION .text
GLOBAL _start
_start:
    mov eax, msg
    call sprint
    
    mov eax, x
    call sread
    
    mov eax, x
    call atoi
    
    ; Вычисление f(x) = 10 + (31x - 5) = 31x + 5
    mov ebx, 31
    mul ebx
    add eax, 5
    
    mov edi, eax
    
    mov eax, result
    call sprint
    mov eax, edi
    call iprintLF
    
    call quit
