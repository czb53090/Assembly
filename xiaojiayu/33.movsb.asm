assume cs:code, ds:data

data segment
	db 'Welcome to masm!'
	db 16 dup(0)
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov si, 0	; ds:si指向data:0
	mov es, ax
	mov di, 16	; es:di指向data:16
	mov cx, 16	; (cx)=16,rep循环16次
	
	cld			; 设置DF=0,正向传送
	rep movsb
	
	mov ax, 4C00H
	int 21H

code ends
end start