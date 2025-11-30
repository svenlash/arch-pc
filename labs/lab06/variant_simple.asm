%include 'in_out.asm'
SECTION .data
msg: DB 'Введите № студенческого билета: ',0
rem: DB 'Ваш вариант: ',0
SECTION .bss
x: RESB 80
SECTION .text
GLOBAL _start
_start:
mov eax, msg
call sprintLF
mov ecx, x
mov edx, 80
call sread

; Убираем символ новой строки из ввода
mov eax, x
call slen
cmp eax, 0
je .end
mov byte [x+eax-1], 0  ; заменяем \n на 0

; Берем только последние 2 цифры номера
mov eax, x
call slen
mov esi, eax  ; длина строки
cmp esi, 2
jl .error

; Предпоследняя цифра
mov al, [x+esi-2]  
cmp al, '0'
jl .error
cmp al, '9'
jg .error
sub al, '0'
mov bl, 10
mul bl
mov bl, al

; Последняя цифра  
mov al, [x+esi-1]
cmp al, '0'
jl .error
cmp al, '9'
jg .error
sub al, '0'
add bl, al

; Вычисляем вариант: (последние_две_цифры mod 20) + 1
movzx eax, bl
xor edx, edx
mov ebx, 20
div ebx
inc edx

mov eax, rem
call sprint
mov eax, edx
call iprintLF
jmp .end

.error:
mov eax, rem
call sprint
mov eax, 1  ; вариант по умолчанию при ошибке
call iprintLF

.end:
call quit
