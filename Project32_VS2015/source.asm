INCLUDE Irvine32.inc
.data
	BUFSIZE = 5120;//5kb
	id_element_size = 4
	name_element_size = 20
	grade_element_size = 3
	max_student_count = 50

	report_filehandle dword ?
	filehandle dword ?
	buffer BYTE BUFSIZE DUP(?),0
	report_buffer BYTE BUFSIZE DUP(?),0
	idArr byte max_student_count dup(id_element_size dup('+')), 0
	nameArr byte max_student_count dup(name_element_size dup('+')), 0
	gradeArr byte max_student_count dup(grade_element_size dup('+')), 0
	alphaGradeArr byte max_student_count dup('+'), 0
	id_temp byte id_element_size dup('+')
	grade_index dword 0
	empty_grade byte "+++",0
	fileSize dword 0
	filesize_temp dword 0
	student_count dword 0
	id_index_temp dword 0
	temp1 byte 20 dup(' ')
	idPtr dword ?
	namePtr dword ?
	gradePtr dword ?
	alphaGradePtr dword ?
.code

Open_Createfile proc,f_Name:ptr byte
	INVOKE CreateFile,
	f_Name, GENERIC_WRITE OR GENERIC_READ, DO_NOT_SHARE, NULL,
	OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	ret
Open_Createfile endp

CLEAR_Createfile proc, f_Name:ptr byte
	INVOKE CreateFile,
	f_Name, GENERIC_WRITE OR GENERIC_READ, DO_NOT_SHARE, NULL,
	CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	ret
CLEAR_Createfile endp

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

initialize proc USES eax ecx edi , dist:ptr byte , value:byte , dist_size: dword
	cld
	mov al, value
	mov ecx, dist_size
	mov edi, dist
	rep stosb
	ret
initialize endp   

SplitBuffer proc
	;//file example : "10,Ahmed,100,A," 13 10 "20,Zaki,,," 13 10 
	.data
	startF dword ? ;// start of field which is needed to be copied
	endF dword ? ;// end of field which is needed to be copied
	.code
	pushad
	mov edi, offset buffer
	mov idPtr, offset idArr
	mov namePtr, offset nameArr
	mov gradePtr, offset gradeArr
	mov alphaGradePtr, offset alphaGradeArr
	mov al, ','
	mov ecx, fileSize
	mov filesize_temp,ecx
	outer :  ;//loop until the file end 
		mov ecx, 4
		inner:  ;//loop on fields
			push ecx
			mov ecx, fileSize_temp
			mov startF, edi
			cld
			repne scasb;// move edi to the offset that have (,)
			mov endF, edi
			dec endf
			pop ecx
			mov ebx, endF;// ebx equals the number of bytes read (endF - startF)
			sub ebx, startF
			sub filesize_temp,ebx
			dec filesize_temp  ;//for delamter ','
			push edi
			;// fill arrays with data between startF and endF
			cmp ecx, 3
			je N
			cmp ecx, 2
			je G
			cmp ecx, 1
			je A
			i:
			mov edi, idPtr
			add edi, id_element_size-1
			add idPtr, id_element_size
			mov esi, endf
			dec esi    ;//last byte in id
			std
			jmp next
			N :
			mov edi, namePtr
			add namePtr, name_element_size
			mov esi, startf
			jmp next
			G :
			mov edi, gradePtr
			add edi, grade_element_size-1
			add gradePtr, grade_element_size
			mov esi, endf
			dec esi
			std
			jmp next
			A :
			mov edi, alphaGradePtr
			add alphaGradePtr, 1
			mov esi, startF
			next :
			cmp ebx,0
			je done
			push ecx
			mov ecx, ebx
			rep movsb
			pop ecx	
			done:
			pop edi
			dec ecx
		jnz inner
		add edi, 2
		sub filesize_temp,2 ;//for new line
		inc student_count
	cmp filesize_temp,0		
	ja outer
	popad
	ret
SplitBuffer endp

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

fillBuffer proc
	mov edi,offset buffer
	mov idPtr, offset idArr
	mov namePtr, offset nameArr
	mov gradePtr, offset gradeArr
	mov alphaGradePtr, offset alphaGradeArr 
	;//clear the buffer
	invoke initialize , edi , 0 , fileSize
	mov ecx , student_count
	OUTER :
	push ecx
		;//copy id
		mov esi, idPtr
		mov ecx, id_element_size
		L1 :
		cmp byte ptr[esi], '+'
		je N1      ;//next byte
			mov al,[esi]
			mov [edi],al
			inc edi
		N1 :	
			inc esi 
		loop L1
		add idPtr, id_element_size
		;//write (,)
		mov byte ptr[edi], ','
		inc edi
		;//copy name
		mov esi, namePtr
		mov ecx, name_element_size
		L2 :
		cmp byte ptr[esi], '+'
		je N2    ;// break the loop
			movsb
		loop L2
		N2 :
		add namePtr, name_element_size
		;//write (,)
		mov byte ptr[edi], ','
		inc edi
		;//copy Grade
		mov esi, gradePtr
		mov ecx, grade_element_size
		L3 :
		cmp byte ptr[esi], '+'
		je N3      ;//next byte
			mov al,[esi]
			mov [edi],al
			inc edi
		N3 :	
			inc esi 
		loop L3
		add gradePtr, grade_element_size
		;//write (,)
		mov byte ptr[edi], ','
		inc edi
		;//copy alphaGrade
		mov esi, alphaGradePtr
		cmp byte ptr[esi], '+'
		je N4
			movsb
		N4:
		inc alphaGradePtr
		;//write (,)
		mov byte ptr[edi], ','
		inc edi
		;//add new line
		mov byte ptr[edi], 13
		inc edi
		mov byte ptr[edi], 10
		inc edi
		pop ecx
		dec ecx	
		jnz OUTER
		ret
fillBuffer endp

SaveDatabase proc, f_Name:ptr byte, key:byte
	;//open the file
	INVOKE Clear_Createfile,f_Name
	mov filehandle,eax
	mov ecx, fileSize
	cmp ecx,0
	je done
	;// load the 4 arrays "idArr,nameArr,gradeArr,alphaGradeArr" in buffer
	call fillBuffer
	;//encrypt data 
	;INVOKE encrypt_or_decrypt_buffer, key
	;//write data in the file
	INVOKE WriteFile,
	filehandle,offset buffer,fileSize,offset fileSize,null
	done:
	;//close the file
	INVOKE CloseHandle,filehandle
	ret
SaveDatabase endp  

EnrollStudent proc,s_id:ptr byte,s_name:ptr byte, id_size: dword, name_size: dword		
	;//store id
	std
	mov edi , offset idArr
	mov edx , 0
	mov eax , student_count
	mov ebx , id_element_size
	mul ebx
	add edi , eax
	add edi , id_element_size-1
	mov esi , s_id
	add esi , id_size 
	dec esi
	mov ecx , id_size
	rep movsb
	;//store name
	cld
	mov edi , offset nameArr
	mov edx , 0
	mov eax , student_count
	mov ebx , name_element_size
	mul ebx
	add edi , eax
	mov esi , s_name
	mov ecx , name_size
	rep movsb
	;//increment file size
	mov eax, id_size
	add eax, name_size
	add eax, 6 ;//for 4delemter ','and new line 
	add fileSize, eax
	inc student_count
	ret
EnrollStudent endp

getIdIndex proc USES edi esi ecx ebx , s_id:ptr byte, s_id_size : dword

	invoke initialize ,offset id_temp ,'+',id_element_size
	std
	mov edi , offset id_temp
	add edi , id_element_size-1
	mov esi , s_id
	add esi , s_id_size 
	dec esi
	mov ecx , s_id_size
	rep movsb

	mov ebx, offset idArr
	mov eax, 0
	cld 
	check :
	cmp eax , student_count
		je fail 
		mov esi, offset id_temp 
		mov edi, ebx
		mov ecx, id_element_size
		repe cmpsb
		je found  ;//break
		add ebx,id_element_size ;//next element
		inc eax 
		jmp check
	fail :
		mov eax, -1
	found :
	ret
getIdIndex endp

AlphaGrade proc USES esi edi ecx , grade: ptr byte
	.data
	gradeF byte "+60", 0
	gradeD byte "+70", 0
	gradeC byte "+80", 0
	gradeB byte "+90", 0
	.code
	cld 
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

DeleteStudent proc,s_id:ptr byte, s_id_size:dword
	pushad
	invoke getIdIndex,s_id, s_id_size
	cld
	;// moving ids back
	mov id_index_temp , eax
	mov ebx , id_element_size
	mul ebx
	mov edi,offset idArr
	add edi,eax
	push edi
	push eax
	mov ecx, id_element_size
	mov al,'+'
	repe scasb
	sub fileSize,ecx
	sub fileSize,2
	pop eax
	pop edi
	mov ecx,sizeof idArr
	sub ecx,eax
	sub ecx,5
	mov esi,edi
	add esi,4
	rep movsb
	;// moving name back
	mov eax,id_index_temp
	mov ebx,20
	mul ebx
	mov edi,offset nameArr
	add edi,eax
	push edi
	push eax
	mov ecx, name_element_size
	mov al,'+'
	repne scasb
	sub fileSize,name_element_size
	add fileSize,ecx
	pop eax
	pop edi
	mov ecx,sizeof nameArr
	sub ecx,eax
	sub ecx,21
	mov esi,edi
	add esi,20
	rep movsb
	;// moving grades back
	mov eax,id_index_temp
	mov ebx,3
	mul ebx
	mov edi,offset gradeArr
	add edi,eax
	push edi
	push eax
	mov ecx, grade_element_size
	mov al,'+'
	repe scasb
	je G_empety
	sub fileSize,ecx
	dec fileSize
	G_empety:
	dec fileSize
	pop eax
	pop edi
	mov ecx,sizeof gradeArr
	sub ecx,eax
	sub ecx,4
	mov esi,edi
	add esi,3
	rep movsb
	;// moving alphaGrade
	mov edi,offset AlphagradeArr
	add edi,id_index_temp
	cmp byte ptr[edi],'+'
	je A_empety
	dec fileSize
	A_empety:
	dec fileSize
	mov ecx,sizeof alphagradeArr
	sub ecx,id_index_temp
	sub ecx,2
	mov esi,edi
	add esi,1
	rep movsb
	sub fileSize,2
	dec student_count
	popad
	ret 
DeleteStudent endp 

UpdateGrade proc, s_id:ptr byte, s_grade:ptr byte, s_id_size:dword, s_grade_size:dword
	invoke getIdIndex,s_id, s_id_size
	mov id_index_temp,eax
	mov ebx,grade_element_size
	mul ebx
	mov edi,offset gradeArr
	add edi,eax
	mov grade_index,edi
	push edi
		mov esi , offset empty_grade
		mov ecx , grade_element_size
		repe cmpsb
		jne full ;//there is a value in it 
			mov ebx,s_grade_size 
			add fileSize ,ebx  ;//increment with grade size
			inc fileSize       ;//increment with alpha grade size
		full :
	pop edi
	add edi,grade_element_size-1
	mov esi,s_grade
	add esi,s_grade_size
	dec esi
	mov ecx,s_grade_size 
	std 
	rep movsb
	mov edi,offset alphaGradeArr
	add edi,id_index_temp
	INVOKE AlphaGrade,grade_index
	mov [edi],al
	ret
UpdateGrade endp  

DisStudentData proc,s_id:ptr byte,s_id_size:dword,s_name:ptr byte,s_grade:ptr byte,s_A_grade:ptr byte
	invoke getIdIndex,s_id, s_id_size
	mov id_index_temp,eax
	mov edx,0
	mov esi ,offset nameArr
	mov ebx , name_element_size
	mul ebx
	add esi,eax
	mov edi,s_name
	mov ecx, name_element_size
	n:
		mov al ,[esi]
		cmp al,'+'
		je name_finished
		mov [edi],al
		inc edi
		inc esi
	loop n
	name_finished:

	mov eax , id_index_temp
	mov esi , offset gradeArr
	mov ebx , grade_element_size
	mul ebx
	add esi,eax
	mov edi,s_grade
	mov ecx, grade_element_size
	g:
		mov al ,[esi]
		cmp al,'+'
		je next  ;//next byte 
		mov [edi],al
		inc edi
		next :
		mov byte ptr[edi],' '
		inc esi
	loop g

	mov esi , offset AlphagradeArr
	add esi , id_index_temp
	mov edi , s_A_grade
	mov al ,[esi]
	cmp al,'+'
	je done
		mov [edi],al
		inc edi
	done:
		mov byte ptr[edi],' '
	ret
DisStudentData endp

Swap proc USES esi edi ecx, sizes:dword,ptr1:ptr byte 
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
Swap endp

BubbleSort PROC, Count:DWORD, sortType:byte
	mov ecx,Count
	dec ecx;//decrement count by 1
	L1: 
	push ecx ;//save outer loop count
	mov idPtr, offset idArr
	mov namePtr, offset nameArr
	mov gradePtr, offset gradeArr
	mov alphaGradePtr, offset alphaGradeArr
	L2:
	push ecx
	mov ecx, 4
	mov esi,idPtr
	mov edi, esi
	add edi, 4
	mov al, 'A'
	cmp sortType, al
	je ascending
	repe cmpsb ;//compare a pair of values 
	jae next ;//if [idPtr] <= [idPtr+4], no exchange
	jmp done
	ascending:
	repe cmpsb;//compare a pair of values 
	jbe next;//if [idPtr] <= [idPtr+4], no exchange
	done:
	invoke swap,4, idPtr
	invoke swap,20, namePtr
	invoke swap,3, gradePtr
	invoke swap,1, alphaGradePtr

	next: 
	add idPtr,4 ;//move both pointers forward
	add namePtr,20 ;//move both pointers forward
	add gradePtr,3 ;//move both pointers forward
	add alphaGradePtr,1 ;//move both pointers forward
	pop ecx
	loop L2 ;//inner loop
	pop ecx ;//retrieve outer loop count
	dec ecx
	jnz L1 ;//else repeat outer loop
	ret
BubbleSort ENDP

GenerateReport proc,f_name:ptr byte, sortType:byte
	invoke BubbleSort, student_count, sortType
	invoke SaveDatabase, f_name, 170
	ret
GenerateReport endp


DllMain PROC hInstance:DWORD, fdwReason:DWORD, lpReserved:DWORD 
	mov eax, 1;//Return true to caller. 
	ret 
DllMain ENDP


END DllMain