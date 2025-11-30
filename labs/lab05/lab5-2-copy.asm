SECTION .data
    msg: DB 'Введите строку:', 0
    res: DB 'Ваша строка:', 0

SECTION .bss
    buf1: RESB 80

SECTION .text
    GLOBAL _start

_start:
    ; Вывод приглашения
    mov eax, msg
    call sprintLF

    ; Ввод строки
    mov eax, buf1
    call sread

    ; Вывод результата
    mov eax, res
    call sprintLF

    ; Вывод введенной строки
    mov eax, buf1
    call sprintLF

    ; Завершение
    mov eax, 1
    mov ebx, 0
    int 0x80

; Подпрограмма вычисления длины строки
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

; Подпрограмма вывода строки
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

; Подпрограмма вывода с переводом строки
sprintLF:
    call sprint
    push eax
    mov eax, 0Ah
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; Подпрограмма ввода строки
sread:
    push edx
    push ecx
    push ebx
    
    mov edx, 80
    mov ecx, eax
    mov ebx, 0
    mov eax, 3
    int 0x80
    
    ; Заменяем символ новой строки на нулевой байт
    mov esi, ecx
    add esi, eax
    dec esi
    mov byte [esi], 0
    
    pop ebx
    pop ecx
    pop edx
    ret
