all: lab10-1

lab10-1: lab10-1.o
	ld -m elf_i386 lab10-1.o -o lab10-1

lab10-1.o: lab10-1.asm in_out.asm
	nasm -f elf lab10-1.asm -o lab10-1.o

in_out.asm:
	@echo "Файл in_out.asm создан"

clean:
	rm -f *.o lab10-1 lab10-1_simple readme-1.txt

test:
	@echo "Тестирование программы..."
	@echo "Test message" | ./lab10-1
	@echo "=== Содержимое файла ==="
	@cat readme-1.txt || true

run: lab10-1
	@echo "Введите текст для записи в файл (Ctrl+D для завершения):"
	./lab10-1
