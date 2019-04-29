; syscall constants
SYS_WRITE EQU 4
SYS_EXIT EQU 1
SYS_READ EQU 3

; file descriptor constant
STDIN EQU 0
STDOUT EQU 1

section	.text
	global _start
   ; need that for the linker (ld)
   ; gcc would use main


_start:
   ; write message
   mov   eax,  SYS_WRITE
   mov   edx,  [len_please_input]
   mov   ecx,  please_input
   mov   ebx,  STDOUT
   int   0x80

loop_body:
   ; read char into memory
   mov   eax,  SYS_READ
   mov   ebx,  STDIN
   mov   ecx,  current_char
   mov   edx,  1
   int   0x80

   ; display function uses eax as a parameter
   movzx eax,  byte[current_char]   

   ; exit on newline
   cmp   eax,  0xa
   je exit

   ; call display function
   call  display

   ; loop and read next char
   jmp loop_body

exit:
   ; write a newline to the end of the message
   mov   eax,  SYS_WRITE
   mov   ebx,  STDOUT
   mov   ecx,  newline
   mov   edx,  1
   int   0x80

   ; exit properly with code 0
   mov	eax,  SYS_EXIT
   mov   ebx,  0
   int	0x80

display:
   ; multiply eax by 2
   ; we need that because we use it to index a word array
   ; and each word is 2 bytes in size
   shl   eax,  1

   ; edx will contain length of message

   mov   edx,  eax
   add   edx,  lengths
   ; edx is now lengths + eax
   ; so a pointer (original) eaxth element of the lengths word array

   movzx edx,  word[edx]
   ; now we load the value from the array

   cmp   edx,  0
   jz return
   ; ignore length 0 (non existent) letters
   ; btw sys_write would ignore length 0 calls too


   ; ecx will contain a pointer to the string we print

   mov   ecx,  eax
   shl   ecx,  1
   ; ecx is now 2*eax or 4*original eax
   ; we will index a doubleword (4 bytes) array
   add   ecx,  starts
   mov   ecx,  [ecx]
   ; array element loading

   ; setup and call syscall
   mov	ebx,  STDOUT
   mov	eax,  SYS_WRITE
   int	0x80

   ; and write a space too
   mov   eax,  SYS_WRITE
   mov   edx,  1
   mov   ecx,  space
   int   0x80

   ; and return
return:
   ret

section	.data
%include "build/letters.asm"
please_input db "Please input a string: "
len_please_input dd $-please_input
space db 0x20
newline db 0x0a

section .bss
   current_char resq 1