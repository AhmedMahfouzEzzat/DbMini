INCLUDE Irvine32.inc
.data
str1 byte  "ahmedFile.txt", 0
str2 byte  "data gwa file", 0
fileHandle handle ?
BUFFER_SIZE = 1000
buffer byte 1000 dup(0)

WriteToFile_1 dword 0 
BigBuffer byte 2523 dup(0)
carriageReturn BYTE 13, 10
.code

;make file function 
makeFile proc
	mov edx, offset str1
	INVOKE CreateFile,
	edx, GENERIC_WRITE, DO_NOT_SHARE, NULL,
	CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	mov fileHandle, eax
	mov eax, fileHandle
	mov edx, OFFSET str2
	mov ecx, sizeof str2
	call WriteToFile
	mov eax, fileHandle
	INVOKE CloseHandle, eax
	ret
makefile endp

;append TXT File 
appendTxtFile proc
	mov edx, offset str1
	INVOKE CreateFile,
	edx, GENERIC_READ, DO_NOT_SHARE, NULL,
	OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
	mov fileHandle, eax
	ret

appendTxtFile endp

; read from File
readFile2 proc str12 : PTR BYTE
mov edx, offset str1
INVOKE CreateFile,
edx, GENERIC_READ, DO_NOT_SHARE, NULL,
OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov fileHandle, eax
mov edx, str12
mov ecx, 1000
call ReadFromFile
mov buffer[eax], 0
mov ebx, eax
mov eax, offset buffer
mov eax, fileHandle
INVOKE CloseHandle, eax
mov eax, ebx
ret
readFile2 endP

enroll2 proc ID : ptr Byte, Namee : ptr Byte, IDSize : Dword, NameSize : Dword
mov edx,offset str1
INVOKE CreateFile,
edx, GENERIC_WRITE, DO_NOT_SHARE, NULL,
OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov filehandle, EAX
mov esi,ID
mov edi, offset buffer
mov ecx, IDSize
rep movsb
mov al,','
mov [edi], al
inc edi
mov esi, Namee
mov ecx, NameSize
rep movsb
mov al, carriageReturn
mov [edi],al
inc edi
mov al, carriageReturn+1
mov [edi],al
inc edi


INVOKE SetFilePointer,
fileHandle, ; file handle
0, ; distance low
0, ; distance high
FILE_END
MOV EAX,fileHandle
mov edx,OFFSET buffer
MOV ecx,0
add ecx,IDSize
add ecx,NameSize
add ecx,3
call WriteToFile

INVOKE CloseHandle, filehandle

ret
enroll2 endP



DllMain PROC hInstance:DWORD, fdwReason:DWORD, lpReserved:DWORD 
mov eax, 1; Return true to caller. 
ret 
DllMain ENDP
END DllMain

END main
