SECTION .data
    msg: DB 'Введите строку:', 0
    res: DB 'Ваша строка:', 0

SECTION .bss
    buf1: RESB 80

SECTION .text
    GLOBAL _start

_start:
    mov eax, msg
    call sprint

    mov eax, buf1
    call sread

    mov eax, res
    call sprint

    mov eax, buf1
    call sprint

    mov eax, 1
    mov ebx, 0
    int 0x80

slen:
    push ebx
    mov ebx, eax
nextchar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextchar
finished:
    sub eax, ebx
    pop ebx
    ret

sprint:
    push edx
    push ecx
    push ebx
    push eax
    call slen

    mov edx, eax
    pop eax

    mov ecx, eax
    mov ebx, 1
    mov eax, 4
    int 0x80

    pop ebx
    pop ecx
    pop edx
    ret

sread:
    push edx
    push ecx
    push ebx
    push eax

    mov edx, 80
    mov ecx, eax
    mov ebx, 0
    mov eax, 3
    int 0x80

    mov esi, ecx
    add esi, eax
    dec esi
    mov byte [esi], 0

    pop eax
    pop ebx
    pop ecx
    pop edx
    ret
