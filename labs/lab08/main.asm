%include 'in_out.asm'

SECTION .data
msg_func db 'Функция: f(x)=7+2x', 0h
msg_result db 'Результат: ', 0h

SECTION .text
global _start

_start:
    pop ecx
    pop edx
    dec ecx
    cmp ecx, 0
    jz .no_args
    
    mov eax, msg_func
    call sprintLF
    
    mov esi, 0
    
.process_args:
    pop ebx
    mov eax, ebx
    call atoi
    mov edi, eax
    shl eax, 1
    add eax, 7
    add esi, eax
    loop .process_args
    
    mov eax, msg_result
    call sprint
    mov eax, esi
    call iprintLF
    jmp .exit

.no_args:
    mov eax, msg_func
    call sprintLF
    mov eax, msg_result
    call sprint
    mov eax, 0
    call iprintLF

.exit:
    call quit
