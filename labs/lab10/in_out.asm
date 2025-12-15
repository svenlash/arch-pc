; ===============================================
; Библиотека in_out.asm (основные функции)
; ===============================================

; --- Подпрограмма вычисления длины строки ---
; Вход:  EAX = адрес строки
; Выход: EAX = длина строки
slen:
    push ebx
    mov ebx, eax
    
.nextchar:
    cmp byte [eax], 0
    jz .finished
    inc eax
    jmp .nextchar
    
.finished:
    sub eax, ebx
    pop ebx
    ret

; --- Подпрограмма печати строки ---
; Вход:  EAX = адрес строки
sprint:
    push edx
    push ecx
    push ebx
    push eax
    
    call slen          ; получаем длину строки
    
    mov edx, eax       ; длина
    pop ecx            ; адрес строки
    mov ebx, 1         ; stdout
    mov eax, 4         ; sys_write
    int 0x80
    
    pop ebx
    pop ecx
    pop edx
    ret

; --- Подпрограмма печати строки с переводом строки ---
; Вход:  EAX = адрес строки
sprintLF:
    call sprint
    
    push eax
    mov eax, 0Ah       ; символ новой строки
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; --- Подпрограмма чтения строки ---
; Вход:  ECX = адрес буфера, EDX = длина буфера
; Выход: EAX = количество прочитанных байт
sread:
    push ebx
    
    mov ebx, 0         ; stdin
    mov eax, 3         ; sys_read
    int 0x80
    
    ; Убираем символ новой строки
    cmp eax, 0
    jle .done
    dec eax
    mov byte [ecx+eax], 0
    
.done:
    pop ebx
    ret

; --- Подпрограмма преобразования строки в число ---
; Вход:  EAX = адрес строки
; Выход: EAX = число
atoi:
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, eax
    xor eax, eax
    xor ecx, ecx
    
.convert_loop:
    movzx ebx, byte [esi+ecx]
    cmp bl, 0
    je .done
    
    cmp bl, '0'
    jl .error
    cmp bl, '9'
    jg .error
    
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    
    inc ecx
    jmp .convert_loop

.error:
    xor eax, eax

.done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

; --- Подпрограмма печати числа ---
; Вход:  EAX = число
iprint:
    push eax
    push ecx
    push edx
    push esi
    
    xor ecx, ecx
    
.divide_loop:
    inc ecx
    xor edx, edx
    mov esi, 10
    div esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz .divide_loop
    
.print_loop:
    dec ecx
    mov eax, esp
    call sprint
    pop eax
    cmp ecx, 0
    jnz .print_loop
    
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; --- Подпрограмма печати числа с переводом строки ---
; Вход:  EAX = число
iprintLF:
    call iprint
    
    push eax
    mov eax, 0Ah
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; --- Подпрограмма завершения программы ---
quit:
    mov ebx, 0
    mov eax, 1
    int 0x80
    ret
