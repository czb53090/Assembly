assume cs:code

code segment
start:
	mov ax, cs
	mov ds, ax
	mov si, offset sqr
	mov ax, 0
	mov es, ax
	mov di, 200H
	mov cx, 0ffset sqrend - offset sqr
	cld
	rep movsb
	
	mov ax, 0
	mov es, ax
	mov word ptr es:[7CH*4], 200H
	mov word ptr es:[7CH*4+2], 0
	
	mov ax, 4C00H
	int 21H
	
sqr:
	mul ax
	iret
sqrend: nop

code ends
end start