assume cs:codesg
codesg segment

start:
	mov ax, 0FFFFH
	mov ds, ax
	mov ax, 0020H
	mov es, ax
	
	mov bx, 0
	mov cx, 12
s:
	mov dl, [bx]
	mov es:[bx], dl
	inc bx

	loop s
	
	mov ax, 4C00H
	int 21H
	
codesg ends
end start