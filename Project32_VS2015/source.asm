INCLUDE Irvine32.inc
.data
	BUFSIZE = 3072;//3kb
	ID_ELEMENT_SIZE = 4
	NAME_ELEMENT_SIZE = 20
	GRADE_ELEMENT_SIZE = 3
	MAX_STUDENT_COUNT = 50

	report_filehandle dword ?
	filehandle dword ?
	buffer BYTE BUFSIZE DUP(?),0
	report_buffer BYTE BUFSIZE DUP(?),0
	report_heder byte "StudentID |StudentName         |NumGrade  |AlphaGrade",13,10
	write_line   byte "----------|--------------------|----------|----------",13,10

	idArr byte MAX_STUDENT_COUNT dup(ID_ELEMENT_SIZE dup('+')), 0
	nameArr byte MAX_STUDENT_COUNT dup(NAME_ELEMENT_SIZE dup('+')), 0
	gradeArr byte MAX_STUDENT_COUNT dup(GRADE_ELEMENT_SIZE dup('+')), 0
	alphaGradeArr byte MAX_STUDENT_COUNT dup('+'), 0

	idPtr dword ?
	namePtr dword ?
	gradePtr dword ?
	alphaGradePtr dword ?

	id_temp byte ID_ELEMENT_SIZE dup('+')
	grade_index dword 0
	empty_grade byte "+++",0
	filesize_temp dword 0
	id_index_temp dword 0
	temp1 byte 20 dup(' ')

	fileSize dword 0
	reportfileSize dword 0
	student_count dword 0
.code

Open_Createfile proc,f_Name:ptr byte                              ;//IF the file exist overwrite it ,if not exist creat it
	INVOKE CreateFile,
	f_Name, GENERIC_WRITE OR GENERIC_READ, DO_NOT_SHARE, NULL,
	OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	ret
Open_Createfile endp

CLEAR_Createfile proc, f_Name:ptr byte								;//IF the file exist clear it and creat new ,if not exist creat it
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

initialize proc USES eax ecx edi , dist:ptr byte , value:byte , dist_size: dword   ;//initialize an array with specific value
	cld
	mov al, value
	mov ecx, dist_size
	mov edi, dist
	rep stosb
	ret
initialize endp   

SplitBuffer proc				;//fill 4 arrays (idarr,namearr,gradearr,a_gradearr) with the data
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
	mov al, ','			;//delemeter
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
			sub filesize_temp,ebx  ;//decrement file size by field lingth
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
			std					;//mov id from the end        ex: ++12
			mov edi, idPtr
			add edi, ID_ELEMENT_SIZE-1  ;//last byte in id in idArr
			mov esi, endf
			dec esi						;//last byte in id in buffer
			add idPtr, ID_ELEMENT_SIZE  ;//mov pointer to next id
			jmp next
			N :
			mov edi, namePtr					;//first byte in name in nameArr
				
			mov esi, startf						;//irst byte in name in buffer
			add namePtr, NAME_ELEMENT_SIZE		;//mov pointer to next name 
			jmp next
			G :
			std
			mov edi, gradePtr
			add edi, GRADE_ELEMENT_SIZE-1
			add gradePtr, GRADE_ELEMENT_SIZE
			mov esi, endf
			dec esi
			
			jmp next
			A :
			mov edi, alphaGradePtr
			add alphaGradePtr, 1
			mov esi, startF
			next :
			cmp ebx,0		;//if field is empety
			je done
			push ecx
			mov ecx, ebx
			rep movsb
			pop ecx	
			done:
			pop edi
			dec ecx
		jnz inner
		add edi, 2			;//jump new line in buffer
		sub filesize_temp,2 ;//for new line
		inc student_count   ;//count number of student read it
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
	cmp ecx,0		;//if the file is empety
	je done
	;INVOKE encrypt_or_decrypt_buffer,key
	;// fill the 4 arrays "idArr,nameArr,gradeArr,alphaGradeArr"
	call SplitBuffer  
	done:
	;//close the file
	INVOKE CloseHandle,filehandle
	ret
OpenDatabase endp  

fillBuffer proc uses ecx
	
	mov edi,offset buffer
	mov idPtr, offset idArr						;//ex: "++12+100+500"
	mov namePtr, offset nameArr					;//ex: "ahmed++++++mohamed+++++Amr+++++++++"
	mov gradePtr, offset gradeArr				;//ex: "100+30++1"
	mov alphaGradePtr, offset alphaGradeArr		;//ex: "AFF"
	;//clear the buffer
	invoke initialize , edi , 0 , fileSize
	mov ecx , student_count
	OUTER :
	push ecx
		;//copy id
		mov esi, idPtr
		mov ecx, ID_ELEMENT_SIZE
		L1 :
		cmp byte ptr[esi], '+'
		je N1      ;//next byte
			mov al,[esi]
			mov [edi],al
			inc edi
		N1 :	
			inc esi 
		loop L1
		add idPtr, ID_ELEMENT_SIZE
		;//write (,)
		mov byte ptr[edi], ','
		inc edi
		;//copy name
		mov esi, namePtr
		mov ecx, NAME_ELEMENT_SIZE
		L2 :
		cmp byte ptr[esi], '+'
		je N2    ;// break the loop
			movsb
		loop L2
		N2 :
		add namePtr, NAME_ELEMENT_SIZE
		;//write (,)
		mov byte ptr[edi], ','
		inc edi
		;//copy Grade
		mov esi, gradePtr
		mov ecx, GRADE_ELEMENT_SIZE
		L3 :
		cmp byte ptr[esi], '+'
		je N3      ;//next byte
			mov al,[esi]
			mov [edi],al
			inc edi
		N3 :	
			inc esi 
		loop L3
		add gradePtr, GRADE_ELEMENT_SIZE
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
	cmp ecx,0   ;//if the file is empety
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

getIdIndex proc USES edi esi ecx ebx , s_id:ptr byte, s_id_size : dword

	invoke initialize ,offset id_temp ,'+',ID_ELEMENT_SIZE
	std
	mov edi , offset id_temp		;//mov id in id_temp to be in format  "++10"
	add edi , ID_ELEMENT_SIZE-1
	mov esi , s_id
	add esi , s_id_size 
	dec esi
	mov ecx , s_id_size
	rep movsb
	;//search for id  
	mov ebx, offset idArr
	mov eax, 0
	cld 
	check :
	cmp eax , student_count
		je fail 
		mov esi, offset id_temp 
		mov edi, ebx
		mov ecx, ID_ELEMENT_SIZE
		repe cmpsb
		je found  ;//break
		add ebx,ID_ELEMENT_SIZE ;//next element
		inc eax 
		jmp check
	fail :
		mov eax, -1
	found :
	ret
getIdIndex endp

EnrollStudent proc,s_id:ptr byte,s_name:ptr byte, id_size: dword, name_size: dword	
	invoke getIdIndex , s_id , id_size
	cmp eax,-1
	jne is_exist
		;//store id
		std
		mov edi , offset idArr
		mov edx , 0
		mov eax , student_count
		mov ebx , ID_ELEMENT_SIZE
		mul ebx
		add edi , eax					;//mov pointer to end of arr to apend new data 
		add edi , ID_ELEMENT_SIZE-1
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
		mov ebx , NAME_ELEMENT_SIZE
		mul ebx
		add edi , eax
		mov esi , s_name
		mov ecx , name_size
		rep movsb
		;//increment file size
		mov eax, id_size
		add eax, name_size
		add eax, 6 ;//for 4 delemter ','and new line 
		add fileSize, eax
		inc student_count
		mov eax,-1
	is_exist :

	ret
EnrollStudent endp


AlphaGrade proc USES esi edi ecx , grade: ptr byte
	.data
	gradeF byte "+60", 0
	gradeD byte "+70", 0
	gradeC byte "+80", 0
	gradeB byte "+90", 0
	.code
	cld 
	mov esi,  grade
	mov edi, offset gradeF	;//if(grade < 60)
	mov ecx, 3
	repe cmpsb
	jb FG

	mov esi,  grade
	mov edi, offset gradeD  ;//elseif (grade < 70)
	mov ecx, 3
	repe cmpsb
	jb DG

	mov esi,  grade
	mov edi, offset gradeC	;//elseif (grade < 80)
	mov ecx, 3
	repe cmpsb
	jb CG

	mov esi,  grade
	mov edi, offset gradeB	;//elseif (grade < 70)
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

DeleteStudent proc uses ebx edx esi edi,s_id:ptr byte, s_id_size:dword
	invoke getIdIndex,s_id, s_id_size
	cmp eax,-1
	je not_exist
		cld
		;// moving ids back  
		mov id_index_temp , eax
		mov ebx , ID_ELEMENT_SIZE
		mul ebx
		mov edi,offset idArr
		add edi,eax
		push edi
		push eax
		;//count id lingth
		mov ecx, ID_ELEMENT_SIZE
		mov al,'+'
		repe scasb
		sub fileSize,ecx   ;//filesize -=(ecx+1) -1"for delemter"	=> filesize - ecx -2
		sub fileSize,2    
		pop eax
		pop edi
		mov ecx,sizeof idArr
		sub ecx,eax
		sub ecx,ID_ELEMENT_SIZE + 1
		mov esi,edi
		add esi,ID_ELEMENT_SIZE		;//esi pointed to id which we remove it and edi to next id 
		rep movsb
		;// moving name back
		mov eax,id_index_temp
		mov ebx,NAME_ELEMENT_SIZE
		mul ebx
		mov edi,offset nameArr
		add edi,eax
		push edi
		push eax
		;//count name lingth
		mov ecx, NAME_ELEMENT_SIZE
		mov al,'+'
		repne scasb
		sub fileSize,NAME_ELEMENT_SIZE		;//filesize -=(NAME_ELEMENT_SIZE - (ecx+1)) - 1  => filesize - NAME_ELEMENT_SIZE +ecx   
		add fileSize,ecx
		pop eax
		pop edi
		mov ecx,sizeof nameArr
		sub ecx,eax
		sub ecx,NAME_ELEMENT_SIZE +1
		mov esi,edi					;//esi pointed to name which we remove it and edi to next name 
		add esi,NAME_ELEMENT_SIZE
		rep movsb
		;// moving grades back
		mov eax,id_index_temp
		mov ebx,GRADE_ELEMENT_SIZE
		mul ebx
		mov edi,offset gradeArr
		add edi,eax
		push edi
		push eax
		;//count grade lingth
		mov ecx, GRADE_ELEMENT_SIZE
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
		sub ecx,GRADE_ELEMENT_SIZE +1
		mov esi,edi
		add esi,GRADE_ELEMENT_SIZE
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
		sub fileSize,2      ;//for new line 
		dec student_count
	mov eax ,id_index_temp 
	not_exist :
	ret 
DeleteStudent endp 

UpdateGrade proc, s_id:ptr byte, s_grade:ptr byte, s_id_size:dword, s_grade_size:dword
	invoke getIdIndex,s_id, s_id_size
	cmp eax,-1
	je not_exist
		mov id_index_temp,eax
		mov ebx,GRADE_ELEMENT_SIZE
		mul ebx
		mov edi,offset gradeArr
		add edi,eax
		mov grade_index,edi
		push edi
			mov esi , offset empty_grade
			mov ecx , GRADE_ELEMENT_SIZE
			repe cmpsb
			jne full ;//there is a value in it 
				mov ebx,s_grade_size 
				add fileSize ,ebx  ;//increment with grade size
				inc fileSize       ;//increment with alpha grade size
			full :
		pop edi
		add edi,GRADE_ELEMENT_SIZE-1
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
	mov eax ,id_index_temp
	not_exist :
	ret
UpdateGrade endp  

DisStudentData proc,s_id:ptr byte,s_id_size:dword,s_name:ptr byte,s_grade:ptr byte,s_A_grade:ptr byte
	invoke getIdIndex,s_id, s_id_size
	cmp eax,-1
	je not_exist
		mov id_index_temp,eax
		mov edx,0
		mov esi ,offset nameArr
		mov ebx , NAME_ELEMENT_SIZE
		mul ebx
		add esi,eax
		mov edi,s_name
		mov ecx, NAME_ELEMENT_SIZE
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
		mov ebx , GRADE_ELEMENT_SIZE
		mul ebx
		add esi,eax
		mov edi,s_grade
		mov ecx, GRADE_ELEMENT_SIZE
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
	mov eax , id_index_temp
	not_exist :
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
	cmp ecx,0
	je done_sort
	L1: 
	push ecx ;//save outer loop count
	mov idPtr, offset idArr
	mov namePtr, offset nameArr
	mov gradePtr, offset gradeArr
	mov alphaGradePtr, offset alphaGradeArr
		L2:
		push ecx
		mov ecx, ID_ELEMENT_SIZE
		mov esi,idPtr
		mov edi, esi
		add edi, ID_ELEMENT_SIZE ;//next id 
		mov al, 'A'
		cmp sortType, al  
		je ascending
		repe cmpsb ;//compare a pair of values 
		jae next ;//if [idPtr] >= [idPtr+4], no exchange
		jmp done
		ascending:
		repe cmpsb;//compare a pair of values 
		jbe next;//if [idPtr] <= [idPtr+4], no exchange
		done:
		invoke swap,ID_ELEMENT_SIZE, idPtr
		invoke swap,NAME_ELEMENT_SIZE, namePtr
		invoke swap,GRADE_ELEMENT_SIZE, gradePtr
		invoke swap,1, alphaGradePtr

		next: 
		add idPtr,ID_ELEMENT_SIZE ;//move  pointer forward
		add namePtr,NAME_ELEMENT_SIZE;//move  pointer forward
		add gradePtr,GRADE_ELEMENT_SIZE ;//move  pointer forward
		add alphaGradePtr,1 ;//move  pointer forward
		pop ecx
		loop L2 ;//inner loop
	pop ecx ;//retrieve outer loop count
	dec ecx
	jnz L1 ;//else repeat outer loop
	done_sort:
	ret
BubbleSort ENDP

Format_report proc
	mov edi, offset report_buffer
	mov idPtr, offset idArr						;//ex: "++12+100+500"
	mov namePtr, offset nameArr					;//ex: "ahmed++++++mohamed+++++Amr+++++++++"
	mov gradePtr, offset gradeArr				;//ex: "100+30++9"
	mov alphaGradePtr, offset alphaGradeArr		;//ex: "AFF"
	;//calculate report file Size
	mov edx, 0
	mov eax, student_count
	inc eax   ;//for header
	mov ebx, 55*2              ;//55 for length of record + 55 for write line 
	mul ebx
	mov reportfileSize,eax
	;//clear the buffer
	INVOKE initialize , offset report_buffer ,' ',reportfileSize
	;//write the header
	mov esi, offset report_heder
	mov ecx, lengthof report_heder
	rep movsb
	;//write line
	mov esi, offset write_line
	mov ecx, lengthof write_line
	rep movsb
	mov ecx, student_count
	OUTER :
	push ecx
		;//copy id
		push edi
		mov esi, idPtr
		mov ecx, ID_ELEMENT_SIZE
		L1 :
		cmp byte ptr[esi], '+'
		je N1      ;//next byte
			mov al,[esi]
			mov [edi],al
			inc edi
		N1 :	
			inc esi 
		loop L1
		pop edi 
		add edi , 10
		add idPtr, ID_ELEMENT_SIZE
		;//write (|)
		mov byte ptr[edi], '|'
		inc edi
		;//copy name
		push edi
		mov esi, namePtr
		mov ecx, NAME_ELEMENT_SIZE
		L2 :
		cmp byte ptr[esi], '+'
		je N2    ;// break the loop
			movsb
		loop L2
		N2 :
		pop edi 
		add edi , 20
		add namePtr, NAME_ELEMENT_SIZE
		;//write (|)
		mov byte ptr[edi], '|'
		inc edi
		;//copy Grade
		push edi
		mov esi, gradePtr
		mov ecx, GRADE_ELEMENT_SIZE
		L3 :
		cmp byte ptr[esi], '+'
		je N3      ;//next byte
			mov al,[esi]
			mov [edi],al
			inc edi
		N3 :	
			inc esi 
		loop L3
		pop edi
		add edi , 10
		add gradePtr, GRADE_ELEMENT_SIZE
		;//write (|)
		mov byte ptr[edi], '|'
		inc edi
		;//copy alphaGrade
		push edi
		mov esi, alphaGradePtr
		cmp byte ptr[esi], '+'
		je N4
			movsb
		N4:
		pop edi
		add edi , 10
		inc alphaGradePtr
		;//add new line
		mov byte ptr[edi], 13
		inc edi
		mov byte ptr[edi], 10
		inc edi
		;//write_line
		mov esi, offset write_line
		mov ecx, lengthof write_line
		rep movsb
		pop ecx
	dec ecx	
	jnz OUTER
	ret
Format_report endp

FormatAndCreate_report proc ,f_name :ptr byte 
	;//Cearet the report 
	INVOKE Clear_Createfile,f_Name
	mov report_filehandle,eax
	;//format the report_buffer
	INVOKE Format_report
	;//write the report
	INVOKE WriteFile,
	report_filehandle,offset report_buffer,reportfileSize,offset reportfileSize,null
	;//close the file
	INVOKE CloseHandle,report_filehandle
	ret
FormatAndCreate_report endp

GenerateReport proc,f_name:ptr byte, sortType:byte
	cmp student_count , 0
	je No_data
	invoke BubbleSort, student_count, sortType
	invoke FormatAndCreate_report, f_name
	No_data :
	mov eax, student_count
	ret
GenerateReport endp


DllMain PROC hInstance:DWORD, fdwReason:DWORD, lpReserved:DWORD 
	mov eax, 1;//Return true to caller. 
	ret 
DllMain ENDP


END DllMain