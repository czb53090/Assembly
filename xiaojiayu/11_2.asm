assume cs:codesg, ds:data, ss:stack

data segment
	dw 0123H, 04567H, 0789H, 0ABCH, 0DEFH, 0FEDH, 0CBAH, 0987H
data ends

stack segment
	dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

codesg segment
start:
	mov ax, stack
	mov ss, ax
	mov sp, 16
	mov ax, data
	mov ds, ax
	mov bx, 0
	mov cx, 8
	
s:
	push [bx]
	add bx, 2
	loop s
	
	mov bx, 0
	mov cx, 8
	
s0:
	pop [bx]
	add bx, 2
	loop s0
	
	mov ax, 4C00H
	int 21H
	
codesg ends
end start