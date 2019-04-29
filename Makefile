
build:
	@-mkdir build
	@python ./generate_abc.py > ./build/letters.asm
	@nasm -f elf -F dwarf -g ./main.asm -o ./build/main.o
	@ld -m elf_i386 -s -o main ./build/main.o

clean:
	@-rm -rf build
	@-rm -f main