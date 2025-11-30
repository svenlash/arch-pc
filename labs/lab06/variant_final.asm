%include 'in_out.asm'
SECTION .data
msg: DB 'Для номера 1032253528',0
rem: DB 'Ваш вариант: ',0
SECTION .text
GLOBAL _start
_start:
mov eax, msg
call sprintLF

; Фиксированный расчет для 1032253528
; Последние две цифры: 28
; 28 mod 20 = 8, 8 + 1 = 9
mov eax, 9

mov eax, rem
call sprint
mov eax, 9
call iprintLF
call quit
