# Основная цель
all: reportlab3.pdf

# Правило для сборки PDF
reportlab3.pdf: reportlab3.qmd
	pandoc "$<" -o "$@" --pdf-engine=xelatex

# Очистка
clean:
	rm -rf _output *.pdf
