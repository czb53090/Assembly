assume cs:code, ss:stack

stack segment
	dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

code segment
start:
	;Init
	mov ax, stack
	mov ss, ax
	mov sp, 16
	mov ax, 0
	mov bx, 0
	
	;压栈操作
	;日
	mov al, 7h
	out 70h, al
	in al, 71h
	call do
	push ax
	push bx
	;月
	mov al, 8h
	out 70h, al
	in al, 71h
	call do
	push ax
	push bx
	;年
	mov al, 9h
	out 70h, al
	in al, 71h
	call do
	push ax
	push bx
	
	mov bx, 0b800H
	mov es, bx
	mov di, 160*12+36*2
	
	mov cx, 3
s:
	pop ax
	pop bx
	mov byte ptr es:[di], al
	inc di
	mov al, 02h             ;设置颜色
	mov byte ptr es:[di], al
	inc di
	mov byte ptr es:[di], bl
	inc di
	mov al, 02h             ;设置颜色
	mov byte ptr es:[di], al
	inc di
	
	dec cx
	jcxz enddo
	mov byte ptr es:[di], '|'
	inc di
	mov al, 02h             ;设置颜色
	mov byte ptr es:[di], al
	inc di
	
	jmp s
	
do:
	mov bl, al
	and al, 00001111b
	mov cl, 4
	shr bl, cl
	
	add al, 30H
	add bl, 30H
	
	ret

enddo: nop

	mov ax, 4c00h
	int 21h

code ends
end start