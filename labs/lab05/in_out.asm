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
    push eax
    call slen
    
    mov edx, eax
    pop eax
    
    mov ecx, eax
    mov ebx, 0
    mov eax, 3
    int 80h
    
    pop ebx
    pop edx
    pop ecx
    ret

; Подпрограмма завершения программы
quit:
    mov ebx, 0
    mov eax, 1
    int 80h
    ret
