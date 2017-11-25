assume  cs:codesg, ds:datasg, ss:stacksg
datasg segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. midify       '
datasg ends

stacksg segment
	dw 0,0,0,0,0,0,0,0
stacksg ends

codesg segment
start:
	mov ax, datasg
	mov ds, ax
	mov ax, stacksg
	mov ss, ax
	mov sp, 16
	mov bx, 0
	
	mov cx, 4
	s:
		push cx ; 将外层循环的cx值压栈
		mov si, 0
		mov cx, 4 ; cx设置为内层循环的次数
		
		s0:
			mov al, [bx+3+si]
			and al, 11011111B
			mov [bx+3+si], al
			inc si
			
		loop s0
		
		add bx, 16
		pop cx ; 从栈顶弹出原cx的值，恢复cx
	loop s
	
	mov ax, 4c00H
	int 21H
codesg ends
end start