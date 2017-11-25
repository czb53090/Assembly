assume cs:codesg, ds:datasg

datasg segment
	db 'welcome to masm!'
	db '................'
datasg ends

codesg segment
start:
	mov ax, datasg
	mov ds, ax
	
	mov si, 0
	
	mov cx, 8
s:
	mov ax, 0[si]
	mov 16[si], ax
	add si, 2
	
	loop s
	
	mov ax, 4c00H
	int 21H
	
codesg ends
end start