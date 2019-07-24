# morse
Simple morse coder in x86 ASM.
Done in a few hours to test my ASM "skills".

### Compilation:
Run `make` or `make build` to build. You'll need to have `python` and `nasm` set up.

`generate_abc.py` creates a new ASM source file with the alphabet set up. This way it is very easy to re-target this program to code other formats.
`main.asm` contains the actual source code. It just translates every char into the string specified in the file generated, and prints them separated by spaces.
