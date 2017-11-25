assume cs:code

data segment
	db 8, 11, 8, 1, 8, 5, 63, 38
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov bx, 0 ; ds:bx指向第一个字节
	mov ax, 0 ; 初始化累加器
	mov cx, 8
	
	s:
		cmp byte ptr [bx], 8 ;和8进行比较
		jne next
		inc ax
	
	next:
		inc bx
		loop s
		
	mov ax, 4C00H
	int 21H
	
code ends
end start