assume cs:codesg

codesg segment
start:
	mov ax, 2000H
	mov ds, ax
	mov bx, 1000H
	mov ax, [bx]
	mov cx, [bx+1]
	add cx, [bx+2]
	
	mov ax, 4cooH
	int 21H
codesg ends
end start