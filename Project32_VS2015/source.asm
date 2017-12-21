INCLUDE Irvine32.inc
.data
	BUFSIZE = 5120;//5kb
	record_size=30
	grade_size=3
	filehandle dword ?
	buffer BYTE BUFSIZE DUP(?),0
	new_buffer BYTE BUFSIZE DUP(?),0
	fileSize dword 0
	idArr byte 40 dup('_'), 0
	nameArr byte 200 dup('_'), 0
	gradeArr byte 30 dup('_'), 0
	alphaGradeArr byte 10 dup('_'), 0
	temp2 dword 0
	
temp1 byte 20 dup(0)
.code
Open_Createfile proc,f_Name:ptr byte
	INVOKE CreateFile,
	f_Name, GENERIC_WRITE OR GENERIC_READ, DO_NOT_SHARE, NULL,
	OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	ret
Open_Createfile endp

encrypt_or_decrypt_buffer proc, key:byte
	mov esi ,offset buffer
	mov edi ,esi
	L:
		lodsb
		xor al,key
		stosb
	loop L
	ret
encrypt_or_decrypt_buffer endp

OpenDatabase proc, f_Name:ptr byte, key:byte
	;//open the file
	INVOKE Open_Createfile,f_Name
	mov filehandle, eax
	;//load the file in buffer
	INVOKE ReadFile,
	filehandle,offset buffer,BUFSIZE,offset fileSize,NULL
	;//decrypt data 
	mov ecx, fileSize
	cmp ecx,0
	je done
	;INVOKE encrypt_or_decrypt_buffer,key
	;// fill the 4 arrays "idArr,nameArr,gradeArr,alphaGradeArr"
	call SplitBuffer  
	done:
	;//close the file
	INVOKE CloseHandle,filehandle
	ret
OpenDatabase endp

SaveDatabase proc, f_Name:ptr byte, key:byte
	;// load the 4 arrays "idArr,nameArr,gradeArr,alphaGradeArr" in buffer
	call fillBuffer
	;//open the file
	INVOKE Open_Createfile,f_Name
	mov filehandle,eax
	;//encrypt data 
	mov ecx, fileSize
	;INVOKE encrypt_or_decrypt_buffer, key
	;//write data in the file
	INVOKE WriteFile,
	filehandle,offset buffer,fileSize,offset fileSize,null
	;//close the file
	INVOKE CloseHandle,filehandle
	ret
SaveDatabase endp

EnrollStudent proc,s_id:ptr byte,s_name:ptr byte, id_size: dword, name_size: dword
	;//set pointer to the end of the bufferr
	mov edi , offset buffer 
	add edi , fileSize			
	;//store id
	mov esi , s_id
	mov ecx ,id_size
	rep movsb
	;//write (,)
	mov byte ptr [edi], ','
	inc edi
	;//store name
	mov esi , s_name
	mov ecx , name_size
	rep movsb
	;//write (,)
	mov byte ptr[edi], ','
	inc edi
	;//save space to grade and Alpha_gread
	add edi,grade_size 
	;//write (,)
	mov byte ptr[edi], ','
	add edi,2
	;//write (,)
	mov byte ptr[edi], ','
	inc edi
	;//carrying_return
	mov byte ptr[edi],13		
	inc edi
	;//line_feed
	mov byte ptr[edi],10
	mov eax, 0
	add eax, id_size
	add eax, name_size
	add eax, grade_size
	add eax, 7
	add fileSize, eax
	;//calling SplitBuffer to split the first buffer
	call SplitBuffer
	ret
EnrollStudent endp

getIdIndex proc, s_id:ptr byte, s_id_size : dword
	;// ids should be sortrd to work properly
	mov ebx, offset idArr
	mov edx, 0
	Outer :
	mov esi, s_id
	mov edi, ebx
	mov ecx, s_id_size
	Inner :
	mov al, [edi]
	cmp[esi], al
	jne fail
	inc esi
	inc edi
	Loop Inner
	jmp found
	fail :
	add ebx, 4
	inc edx
	cmp byte ptr[ebx], 0
	jne Outer
	mov eax, -1
	jmp done
	found :
	mov eax, edx
	done :
	ret
getIdIndex endP

fillBuffer proc
	.data
	idPtr dword ?
	namePtr dword ?
	gradePtr dword ?
	alphaGradePtr dword ?
	.code
	mov idPtr, offset idArr
	mov namePtr, offset nameArr
	mov gradePtr, offset gradeArr
	mov alphaGradePtr, offset alphaGradeArr 
	;//clear the buffer
	mov al, 0
	mov ecx, BUFSIZE
	mov edi, offset buffer
	rep stosb
	mov edi, offset buffer
	O :
	;//copy id
	mov esi, idPtr
	mov ecx, 4
	L1 :
	cmp byte ptr[esi], '_'
	je N1
	cmp ecx, 0
	je N1
	dec ecx
	movsb
	dec edx
	jmp L1
	N1 :
	add idPtr, 4
	;//write (,)
	mov byte ptr[edi], ','
	inc edi
	;//copy name
	mov esi, namePtr
	mov ecx, 20
	L2 :
	cmp byte ptr[esi], '_'
	je N2
	cmp ecx, 0
	je N2
	dec ecx
	movsb
	dec edx
	jmp L2
	N2 :
	add namePtr, 20
	;//write (,)
	mov byte ptr[edi], ','
	inc edi
	;//copy Grade
	mov esi, gradePtr
	mov ecx, 3
	rep movsb
	add gradePtr, 3
	;//write (,)
	mov byte ptr[edi], ','
	inc edi
	;//copy alphaGrade
	mov esi, alphaGradePtr
	movsb
	inc alphaGradePtr
	;//write (,)
	mov byte ptr[edi], ','
	inc edi
	;//add new line
	mov byte ptr[edi], 13
	inc edi
	mov byte ptr[edi], 10
	inc edi
	;//repet to next record if there is any
	mov ebx, idPtr
	cmp byte ptr[ebx], 0
	je done
	cmp byte ptr[ebx], '_'
	jne O
	done :
	ret
fillBuffer endp

AlphaGrade proc USES esi edi ecx,
grade: ptr byte
	.data
	gradeF byte " 60", 0
	gradeD byte " 70", 0
	gradeC byte " 80", 0
	gradeB byte " 90", 0
	.code
	mov esi,  grade
	mov edi, offset gradeF
	mov ecx, 3
	repe cmpsb
	jb FG

	mov esi,  grade
	mov edi, offset gradeD
	mov ecx, 3
	repe cmpsb
	jb DG

	mov esi,  grade
	mov edi, offset gradeC
	mov ecx, 3
	repe cmpsb
	jb CG

	mov esi,  grade
	mov edi, offset gradeB
	mov ecx, 3
	repe cmpsb
	jb BG

	AG :
	mov al, 'A'
	jmp done
	BG :
	mov al, 'B'
	jmp done
	CG :
	mov al, 'C'
	jmp done
	DG :
	mov al, 'D'
	jmp done
	FG :
	mov al, 'F'
	done :
	ret
AlphaGrade endp

UpdateGrade proc, s_id:ptr byte, s_grade:ptr byte, s_id_size:dword, s_grade_size:dword
invoke getIdIndex,s_id, s_id_size
mov temp2,eax
mov ebx,3
mul ebx
mov edi,offset gradeArr
add edi,eax
mov ecx,s_grade_size 
mov esi,s_grade
rep movsb
mov edi,offset alphaGradeArr
mov eax,temp2
add edi,eax
INVOKE AlphaGrade,s_grade
mov [edi],al
ret
UpdateGrade endp

DeleteStudent proc,s_id:ptr byte, s_id_size:dword
invoke getIdIndex,s_id, s_id_size

;// moving ids back
mov temp2,eax
mov ebx,4
mul ebx
mov edi,offset idArr
add edi,eax
mov ecx,lengthof idArr
sub ecx,eax
sub ecx,5
mov esi,edi
add esi,4
rep movsb
;// moving name back
mov eax,temp2
mov ebx,20
mul ebx
mov edi,offset nameArr
add edi,eax
mov ecx,lengthof nameArr
sub ecx,eax
sub ecx,21
mov esi,edi
add esi,20
rep movsb
;// moving grades back
mov eax,temp2
mov ebx,3
mul ebx
mov edi,offset gradeArr
add edi,eax
mov ecx,lengthof gradeArr
sub ecx,eax
sub ecx,4
mov esi,edi
add esi,3
rep movsb
;// moving alphaGrade
mov eax,temp2
mov ebx,3
mul ebx
mov edi,offset AlphagradeArr
add edi,eax
mov ecx,lengthof alphagradeArr
sub ecx,eax
sub ecx,2
mov esi,edi
add esi,1
rep movsb

ret
DeleteStudent endp

DisStudentData proc,s_id:dword,s_name:ptr byte,s_grade:ptr dword
	
	ret
DisStudentData endp

GenerateReport proc,f_name:ptr byte,sortby:byte

	ret
GenerateReport endp

SplitBuffer proc
	;//file example : "10,Ahmed,100,A,", 13, 10, "20,Zaki, 70,C,", 13, 10, 0
	.data
	startF dword ? ;// start of field which is needed to be copied
	endF dword ? ;// end of field which is needed to be copied
	idS dword ?
	namS dword ?
	gradeS dword ?
	alphaGradeS dword ?
	.code
	pushad
	mov edi, offset buffer
	mov idS, offset idArr
	mov namS, offset nameArr
	mov gradeS, offset gradeArr
	mov alphaGradeS, offset alphaGradeArr
	mov al, ','
	outer :;//loop until the file end with 0
	mov ecx, 4
	inner:;//loop on fieldss
	push ecx
	mov ecx, lengthof buffer
	mov startF, edi
	repne scasb;// move edi to the offset that have (,)
	mov endF, edi
	dec endF
	pop ecx
	mov ebx, endF;// ebx equals the number of bytes read (endF - startF)
	sub ebx, startF
	push edi
	;// fill arrays with data between startF and endF
	cmp dword ptr ecx, 3
	je N
	cmp dword ptr ecx, 2
	je G
	cmp dword ptr ecx, 1
	je A
	mov edi, idS
	add idS, 4
	jmp next
	N :
	mov edi, namS
	add namS, 20
	jmp next
	G :
	mov edi, gradeS
	add gradeS, 3
	jmp next
	A :
	mov edi, alphaGradeS
	add alphaGradeS, 1
	next :
	push ecx
	mov ecx, ebx
	mov esi, startF
	rep movsb
	pop ecx
	pop edi
	Loop inner
	add edi, 2
	cmp byte ptr[edi], 0
	jne outer
	popad
	ret
SplitBuffer endp

<<<<<<< HEAD
=======
AlphaGrade proc grade: ptr byte
	.data
	gradeF byte " 60", 0
	gradeD byte " 70", 0
	gradeC byte " 80", 0
	gradeB byte " 90", 0
	.code
	mov esi,  grade
	mov edi, offset gradeF
	mov ecx, 3
	repe cmpsb
	jb FG

	mov esi,  grade
	mov edi, offset gradeD
	mov ecx, 3
	repe cmpsb
	jb DG

	mov esi,  grade
	mov edi, offset gradeC
	mov ecx, 3
	repe cmpsb
	jb CG

	mov esi,  grade
	mov edi, offset gradeB
	mov ecx, 3
	repe cmpsb
	jb BG

	AG :
	mov al, 'A'
	jmp done
	BG :
	mov al, 'B'
	jmp done
	CG :
	mov al, 'C'
	jmp done
	DG :
	mov al, 'D'
	jmp done
	FG :
	mov al, 'F'
	done :
	ret
AlphaGrade endp
swap Proc sizes:dword,ptr1:ptr byte 
mov esi,ptr1
mov edi,offset temp1
mov ecx,sizes
rep movsb 
mov esi,ptr1
add esi,sizes
mov edi,ptr1
mov ecx,sizes
rep movsb 
mov edi,ptr1
add edi,sizes
mov esi,offset temp1
mov ecx,sizes
rep movsb
ret
swap endP

BubbleSort PROC USES eax ecx esi ebx edx edi,
Count:DWORD ; array size
mov ecx,Count
dec ecx; decrement count by 1
L1: push ecx ; save outer loop count
mov esi,offset idArr ; point to first value
mov edi,offset nameArr
mov ebx,offset gradeArr
mov edx,offset alphaGradeArr
L2: mov eax,[esi] ; get array value
cmp [esi+4],eax ; compare a pair of values
jg L3 ; if [ESI] <= [ESI+4], no exchange
xchg eax,[esi+4] ; exchange the pair
mov [esi],eax
pushad
invoke swap,4,esi
popad
pushad
invoke swap,20,edi
popad
pushad
invoke swap,3,ebx
popad
pushad
invoke swap,1,edx
popad

L3: add esi,4 ; move both pointers forward
add edi,20 ; move both pointers forward
add ebx,3 ; move both pointers forward
add edx,1 ; move both pointers forward

loop L2 ; inner loop
pop ecx ; retrieve outer loop count
loop L1 ; else repeat outer loop
L4: ret
BubbleSort ENDP


>>>>>>> 03e30fd6b8e1523eb25395957d2aacb5fae5b5c6
DllMain PROC hInstance:DWORD, fdwReason:DWORD, lpReserved:DWORD 
	mov eax, 1;//Return true to caller. 
	ret 
DllMain ENDP


END DllMain

