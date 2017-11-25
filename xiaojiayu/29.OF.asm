assume cs:code

code segment
start:
	mov al, 01100010B
	add al, 01100010B
	
	mov ax, 4C00H
	int 21H
	
code ends

end start