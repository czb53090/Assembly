assume cs:code, ss:stack

stack segment
	dw 8 dup(0)
stack ends
	
code segment
start:
	mov ax, stack
	mov ss, ax
	mov sp, 10H
	
	mov ax, 4240H
	mov dx, 0FH
	mov cx, 0AH
	
	call divdw
	
	mov ax, 4C00H
	int 21H
	
divdw:
	push ax		; 先存放L
	mov ax, dx	; ax存放H
	mov dx, 	; dx置0是为了不影响下边余数位，使得高16位为0
	div cx      ; H/N(16位除法)
	mov bx, ax  ; ax，bx的值为(int)H/N, dx的值为余数
	
	pop ax		; ax的值是L
	div cx		; L/N
	;注意，16位除法的事发后默认被除数dx为高16位，ax为低16位
	mov cx, dx	; 
	mov dx, bx	; 
	
	ret
	
code ends
end start