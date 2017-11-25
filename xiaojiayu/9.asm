assume cs:codesg
codesg segment

start:
	mov ax, 0ffffh
	mov ds, ax

	mov dx, 0
	mov bx, 0
	mov ax, 0
	mov cx, 12

s:
	mov al, [bx]
	add dx, ax
	inc bx

	loop s

	mov ax, 4C00H
	int 21H

codesg ends
end start