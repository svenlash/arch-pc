%include 'in_out.asm'

SECTION .data
filename db 'name.txt', 0
pr db 'Как Вас зовут? ', 0
intr db 'Меня зовут ', 0

SECTION .bss
name resb 255

SECTION .text
global _start

_start:
    ; 1. Вывод приветствия
    mov eax, pr
    call sprint
    
    ; 2. Чтение имени
    mov ecx, name
    mov edx, 255
    call sread
    
    ; 3. Создание/открытие файла
    ; sys_creat: eax=8, ebx=имя файла, ecx=права доступа
    mov eax, 8          ; sys_creat (создание файла)
    mov ebx, filename   ; имя файла
    mov ecx, 644o       ; права доступа: rw-r--r-- (в восьмеричной системе)
    int 0x80            ; системный вызов
    
    ; Проверка на ошибку
    cmp eax, 0
    jl error
    
    ; Сохранение дескриптора файла
    mov esi, eax
    
    ; 4. Запись в файл строки "Меня зовут "
    mov eax, intr       ; адрес строки "Меня зовут "
    call slen           ; получаем длину строки
    mov edx, eax        ; длина для записи
    mov ecx, intr       ; данные для записи
    mov ebx, esi        ; дескриптор файла
    mov eax, 4          ; sys_write
    int 0x80
    
    ; 5. Запись в файл имени пользователя
    mov eax, name       ; адрес строки с именем
    call slen           ; получаем длину имени
    mov edx, eax        ; длина для записи
    mov ecx, name       ; данные для записи
    mov ebx, esi        ; дескриптор файла
    mov eax, 4          ; sys_write
    int 0x80
    
    ; 6. Добавление перевода строки в файл
    mov eax, 0Ah        ; символ новой строки
    push eax
    mov ecx, esp        ; адрес символа в стеке
    mov edx, 1          ; длина (1 байт)
    mov ebx, esi        ; дескриптор файла
    mov eax, 4          ; sys_write
    int 0x80
    pop eax             ; очистка стека
    
    ; 7. Закрытие файла
    mov ebx, esi        ; дескриптор файла
    mov eax, 6          ; sys_close
    int 0x80
    
    ; 8. Сообщение об успехе
    mov eax, msg_success
    call sprintLF
    
    call quit

error:
    mov eax, msg_error
    call sprintLF
    call quit

SECTION .data
msg_success db 'Файл успешно создан!', 0
msg_error db 'Ошибка при создании файла!', 0

