%include 'in_out.asm'

SECTION .data
filename db 'readme-1.txt', 0
msg db 'Введите строку для записи в файл: ', 0
msg_success db 'Файл успешно записан!', 0
msg_error db 'Ошибка при работе с файлом!', 0

SECTION .bss
contents resb 255

SECTION .text
global _start

_start:
    ; Вывод приглашения
    mov eax, msg
    call sprint
    
    ; Чтение строки от пользователя
    mov ecx, contents
    mov edx, 255
    call sread
    
    ; ---- Открытие файла (создать или перезаписать) ----
    mov eax, 5          ; sys_open
    mov ebx, filename   ; имя файла
    mov ecx, 101o       ; O_CREAT|O_WRONLY|O_TRUNC
    mov edx, 644o       ; права доступа: rw-r--r--
    int 0x80
    
    ; Проверка успешности открытия
    cmp eax, 0
    jl error            ; если eax < 0 (ошибка)
    
    mov esi, eax        ; сохраняем дескриптор файла
    
    ; ---- Запись в файл ----
    mov eax, contents
    call slen           ; получаем длину строки
    mov edx, eax        ; длина строки
    mov ecx, contents   ; данные для записи
    mov ebx, esi        ; дескриптор файла
    mov eax, 4          ; sys_write
    int 0x80
    
    ; ---- Закрытие файла ----
    mov ebx, esi        ; дескриптор файла
    mov eax, 6          ; sys_close
    int 0x80
    
    ; Сообщение об успехе
    mov eax, msg_success
    call sprintLF
    
    call quit

error:
    mov eax, msg_error
    call sprintLF
    call quit
