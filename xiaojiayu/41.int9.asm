assume cs:code, ss:stack, ds:data

stack segment
	db 128 dup(0)
stack ends

data segment
	dw 0, 0
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
	
	; 将原来的int 9中断历程的入口地址保存在ds:0、ds:2单元中
	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]

	; 在中断向量表中设置新的int 9中断例程的入口地址
	cli ;设置IF＝0屏蔽中断
	mov word ptr es:[9*4], offset int9
	mov es:[9*4+2], cs
	sti ;设置IF＝1不屏蔽中断
	
	mov ax, 0b800h
	mov es, ax
	mov ah, 'a'
s:
	mov es:[160*12+40*2], ah
	call delay
	inc ah
	cmp ah, 'z'
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
	
;------------以下为新的int 9中断例程-------------
int9:
	push ax
	push bx
	push es
	
	in al, 60h
	
	; 对int指令进行模拟，调用原来的int 9中断例程
	pushf
	; 因为调用中断例程之后会自动设置IF、ZF位为0，
	; 所以可以省略下述步骤
	;pushf
	;pop bx
	;push bx
	;popf
	and bh, 11111100b
	call dword ptr ds:[0]
	
	cmp al, 1
	jne int9ret
	
	mov ax, 0b800h
	mov es, ax
	inc byte ptr es:[160*12+40*2+1]
	
int9ret:
	pop es
	pop bx
	pop ax
	iret

code ends
end start