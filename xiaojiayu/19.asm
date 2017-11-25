assume  cs:codesg, ds:datasg
datasg segment
	db 'ibm             '
	db 'dec             '
	db 'dos             '
	db 'vax             '
	dw 0  ; 定义一个字，用来保存cx
datasg ends

codesg segment
start:
	mov ax, datasg
	mov ds, ax
	mov bx, 0
	
	mov cx, 4
	s:
		mov ds:[40H], cx ; 临时存放外层cx的值
		mov si, 0
		mov cx, 3
		
		s0:
			and al, 11011111B
			mov [bx+si], al
			inc si
			
		loop s0
		
		add bx, 16
		mov cx, ds:[40H] ; 在进行外层循环的时候恢复cx的值
	loop s
	
	mov ax, 4c00H
	int 21H
codesg ends
end start