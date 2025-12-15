; Подпрограмма вычисления длины строки
slen:
    push ebx
    mov ebx, eax
    
slen_nextchar:
    cmp byte [eax], 0
    jz slen_finished
    inc eax
    jmp slen_nextchar
    
slen_finished:
    sub eax, ebx
    pop ebx
    ret

; Подпрограмма печати строки
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
    int 80h
    
    pop ebx
    pop ecx
    pop edx
    ret

; Подпрограмма печати строки с переводом строки
sprintLF:
    push eax
    call sprint
    
    push eax
    mov eax, 0Ah
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    
    pop eax
    ret

; Подпрограмма чтения строки
sread:
    push ecx
    push edx
    push ebx
    
    mov edx, 80
    mov ecx, eax
    mov ebx, 0
    mov eax, 3
    int 80h
    
    ; Добавляем нулевой байт в конец строки
    mov esi, ecx
    add esi, eax
    dec esi
    mov byte [esi], 0
    
    pop ebx
    pop edx
    pop ecx
    ret

; Подпрограмма вывода числа на экран
iprint:
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0
    
iprint_divideLoop:
    inc ecx
    mov edx, 0
    mov esi, 10
    idiv esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz iprint_divideLoop
    
iprint_printLoop:
    dec ecx
    mov eax, esp
    call sprint
    pop eax
    cmp ecx, 0
    jnz iprint_printLoop
    
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; Подпрограмма вывода числа с переводом строки
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

; Подпрограмма преобразования строки в число
atoi:
    push ebx
    push ecx
    push edx
    push esi
    mov esi, eax
    mov eax, 0
    mov ecx, 0
    
atoi_loop:
    xor ebx, ebx
    mov bl, [esi+ecx]
    cmp bl, 48
    jl atoi_finished
    cmp bl, 57
    jg atoi_finished
    sub bl, 48
    mov edx, 10
    mul edx
    add eax, ebx
    inc ecx
    jmp atoi_loop
    
atoi_finished:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

; Подпрограмма завершения программы
quit:
    mov ebx, 0
    mov eax, 1
    int 80h
    ret
