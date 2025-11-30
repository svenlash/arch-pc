%include 'in_out.asm'
SECTION .data
msg db "Результат: ",0
SECTION .text
global _start
_start:
pop ecx ; Извлекаем количество аргументов
pop edx ; Извлекаем имя программы
sub ecx,1 ; Уменьшаем на 1 (без названия программы)
mov esi, 1 ; Используем `esi` для хранения произведения (начинаем с 1!)
next:
cmp ecx,0h ; проверяем, есть ли еще аргументы
jz _end ; если аргументов нет - выходим
pop eax ; извлекаем следующий аргумент
call atoi ; преобразуем символ в число
mul esi ; умножаем esi на eax (результат в eax)
mov esi, eax ; сохраняем результат обратно в esi
loop next ; переход к следующему аргументу
_end:
mov eax, msg ; вывод сообщения "Результат: "
call sprint
mov eax, esi ; записываем произведение в eax
call iprintLF ; печать результата
call quit ; завершение программы
