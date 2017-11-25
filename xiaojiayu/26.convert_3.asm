assume cs:code, ds:data

data segment
	db 'word',0
	db 'unix',0
    db 'wind',0
    db 'good',0
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov si, 0
	mov bx, 0
	
	mov cx, 4
s:
	mov si, bx
	call capital
	add bx
	loop s
	
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