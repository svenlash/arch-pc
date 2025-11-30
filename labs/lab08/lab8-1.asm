%include 'in_out.asm'
SECTION .data
msg: DB 'Введите N: ',0
SECTION .bss
N: RESB 10
SECTION .text
GLOBAL _start
_start:
mov eax, msg
call sprint
mov eax, N
call sread
mov eax, N
call atoi
mov ecx, eax
mov eax, 0
label:
push ecx        ; СОХРАНЯЕМ ECX В СТЕК
sub ecx,1
mov [N],ecx
mov eax,[N]
call iprintLF
pop ecx         ; ВОССТАНАВЛИВАЕМ ECX ИЗ СТЕКА
loop label
call quit
