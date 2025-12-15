; ===============================================
; Библиотека in_out.asm (полная версия)
; ===============================================

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

; Подпрограмма преобразования строки в число (atoi)
atoi:
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, eax
    xor eax, eax
    xor ecx, ecx
    
convert_loop:
    movzx ebx, byte [esi+ecx]
    cmp bl, 0
    je done
    
    cmp bl, '0'
    jl error
    cmp bl, '9'
    jg error
    
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    
    inc ecx
    jmp convert_loop

error:
    xor eax, eax

done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

; Подпрограмма печати числа
iprint:
    push eax
    push ecx
    push edx
    push esi
    
    xor ecx, ecx
    
divide_loop:
    inc ecx
    xor edx, edx
    mov esi, 10
    div esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz divide_loop
    
print_loop:
    dec ecx
    mov eax, esp
    call sprint
    pop eax
    cmp ecx, 0
    jnz print_loop
    
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; Подпрограмма печати числа с переводом строки
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

; Подпрограмма завершения программы
quit:
    mov ebx, 0
    mov eax, 1
    int 80h
    ret
