assume cs:code, ds:data

data segment
	db 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h
	db 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov si, 0
	mov di, 16
	
	mov cx, 8
	
	call add128
	
	mov ax, 4c00h
	int 21h
	
add128:
	push ax
	push cx
	push si
	push di
	
	sub ax, ax ; 将CF设置为0
	s:
		mov ax, [si]
		adc ax, [di]
		mov [si], ax
		inc sin
		inc si
		inc di
		inc di
		
		loop s
		
	pop di
	pop si
	pop cx
	pop ax
	
	ret
code ends
end start