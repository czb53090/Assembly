assume cs:code

code segment
start:
	mov ax, cs
	mov ds, ax
	mov si, offset lp
	mov ax, 0
	mov es, ax
	mov di, 200h
	mov cx, offset endlp - offset lp
	cld
	
	rep movsb

	mov ax, 0
	mov es, ax
	mov word ptr es:[7ch*4], 200H
	mov word ptr es:[7ch*4+2], 0
	mov word ptr es:[7ch*4+2], 0

	mov ax, 4c00H
	int 21h
lp:
	push bp		; 保存bp
	mov bp, sp
	dec cx		; cx-=1
	jcxz lpret
	add [bp+2], bx ; 栈中IP的值加上bx的值
lpret:
	pop bp
	iret		; 把CS，IP复原

endlp: nop

code ends
end start