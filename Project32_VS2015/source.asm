INCLUDE Irvine32.inc

Student STRUCT
IdNum byte 3 dup(0)  ; 9
StudentName BYTE 30 DUP(0) ; 30
Studentgrade byte 3 dup(0)
StudentAlphaGrade byte 1 dup('A')
Student ENDS

.data
	BUFSIZE = 5120;//5kb
	record_size=30
	grade_size=3
	filehandle dword ?
	re_ffilehandle dword ?
	buffer BYTE BUFSIZE DUP(?),0
	new_buffer BYTE BUFSIZE DUP(?),0
	fileSize dword 0
	allStudents Student 20 dup(<"000","ahmed","090",'A'>)
.code
Open_Createfile proc,f_Name:ptr byte
	INVOKE CreateFile,
	f_Name, GENERIC_WRITE OR GENERIC_READ, DO_NOT_SHARE, NULL,
	OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	ret
Open_Createfile endp

OpenDatabase proc,f_Name:ptr byte,kye:byte
	;//open the file
	INVOKE Open_Createfile,f_Name
	mov filehandle, eax
	;//load the file in buffer
	INVOKE ReadFile,
	filehandle,offset buffer,BUFSIZE,offset fileSize,NULL
	;//decrypt data 
	mov esi ,offset buffer
	mov edi ,esi
	mov ecx, fileSize
	cmp ecx,0
	je done
	L:
		lodsb
		xor al,kye
		stosb
	loop L
	done:
	;//close the file
	INVOKE CloseHandle,filehandle
	ret
OpenDatabase endp

SaveDatabase proc,f_Name:ptr byte,kye:byte
	;//open the file
	INVOKE Open_Createfile,f_Name
	mov filehandle,eax
	;//encrypt data 
	mov esi ,offset buffer
	mov edi ,esi
	mov ecx, fileSize
	L:
		lodsb
		xor al,kye
		stosb
	loop L
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
	add edi,grade_size +1
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
	add eax, 6
	add fileSize, eax
	ret
EnrollStudent endp

UpdateGrade proc,s_id:dword,s_grade:dword

	ret
UpdateGrade endp

DeleteStudent proc,s_id:dword

	ret
DeleteStudent endp

DisStudentData proc,s_id:dword,s_name:ptr byte,s_grade:ptr dword
	
	ret
DisStudentData endp

GenerateReport proc,f_name:ptr byte,sortby:byte

	ret
GenerateReport endp

SplitBuffer proc 
	;//file example : "10,Ahmed,100,", 13, 10, "20,Zaki,300,", 13, 10, "30,Hassan,600,", 13, 10, 0
	.data
	id byte 30 dup(? );// id array
	nam byte 30 dup(? );// name array
	grade byte 30 dup(? );// grade array
	startF dword ? ;// start of field which is needed to be copied
	endF dword ? ;// end of field which is needed to be copied
	idS dword ? ;// offset of last id written in (id) array
	namS dword ? ;// offset of last name written in (nam) array
	gradeS dword ? ;// offset of last id written in (grade) array
	tmp byte ?
	.code
	mov edi, offset buffer
	mov idS, offset id
	mov namS, offset nam
	mov gradeS, offset grade
	mov al, ','
	outer :;//loop until the buffer end with 0
	mov edx, offset id
	mov ecx, 3;//3 for id and name and grade
	inner:
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
	cmp dword ptr ecx, 2
	je N
	cmp dword ptr ecx, 1
	je G
	mov edi, idS
	add idS, ebx
	jmp next
	N :
	mov edi, namS
	add namS, ebx
	jmp next
	G :
	mov edi, gradeS
	add gradeS, ebx
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
	ret
SplitBuffer endp

AlphaGrade proc grade2: ptr byte
	.data
	gradeF byte "059", 0
	gradeD byte "069", 0
	gradeC byte "079", 0
	gradeB byte "089", 0
	.code
	mov esi,  grade2
	mov edi, offset gradeF
	repe cmpsb
	jb FG

	mov esi,  grade2
	mov edi, offset gradeD
	repe cmpsb
	jb DG

	mov esi,  grade2
	mov edi, offset gradeC
	repe cmpsb
	jb CG

	mov esi,  grade2
	mov edi, offset gradeB
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

DllMain PROC hInstance:DWORD, fdwReason:DWORD, lpReserved:DWORD 
	mov eax, 1; Return true to caller. 
	ret 
DllMain ENDP

END DllMain

