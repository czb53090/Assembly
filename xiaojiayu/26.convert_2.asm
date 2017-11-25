assume cs:code, ds:data

data segment
	db 'conversation',0
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov si, 0
	
	call capital
	
	mov ax, 4c00H
	int 21H
	
capital:
	mov cl, [si]
	mov ch, 0
	jcxz ok
	
	and byte ptr [si],11011111B
	int si
	jmp short capital
	
ok:	ret
	
code ends
end start