all: project.asm
	nasm -felf64 project.asm
	gcc -o project project.o
