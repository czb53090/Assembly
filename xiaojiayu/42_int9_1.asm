; 安装一个新的int 9中断例程，F1键后改变
; 当前屏幕的显示颜色，其他的键照常处理
assume cs:code

stack segment
	db 128 dup(0)
stack ends

data segment
	dw 0,0
data ends

code segment
start:
	mov ax, stack
	mov ss, ax
	mov sp, 128
	
	mov ax, data
	mov ds, ax
	
	mov ax, 0
	mov es, ax
	
	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]
	
	cli
	mov word ptr es:[9*4], offset int9
	mov es:[9*4+2], cs
	sti
	
	mov ah, 0
s:
	call delay
	inc ah
	cmp ah, 100
	jna s
	
	mov ax, 0
	mov es, ax
	
	; 回复原来的int 9中断历程的入口地址
	push ds:[0]
	pop es:[9*4]
	push ds ; [2]
	pop es; [9*4+2]
	
	mov ax, 4c00h
	int 21h
	
delay:
	push ax
	push dx
	mov dx, 1000h ; 循环10000000次 	
	mov al, 0
	
s1:
	sub al, 1
	sbb dx, 0
	cmp al, 0
	jne s1
	cmp dx, 0
	jne s1
	pop dx
	pop ax
	ret
	
	
int9:
	push ax
	push bx
	push cx
	push es
	
	in al, 60h
	add al, 80h
	pushf
	pushf
	pop bx
	push bx
	popf
	and bh, 11111000b

	call dword ptr ds:[0]
	
	cmp al, 3BH ; F1键
	jne int9ret
	
	mov ax, 0b800h
	mov es, ax
	mov bx, 1
	mov cx, 2000
s3:
	inc byte ptr es:[bx]
	add bx, 2
	loop s3
	
int9ret:
	pop es
	pop cx
	pop bx
	pop ax
	iret

code ends
end start
