assume cs:code

code segment
start:
	mov al, 0EH ; 在屏幕上显示0E
	
	call showbyte
	
	mov ax, 4C00H

showbyte:
	jmp short showbyte
	table db '0123456789ABCDEF' ;字符表
	
show:
	push bx
	push es
	
	; 将0E高、低四位分离开
	mov ah, al
	shr ah, 1
	shr ah, 1
	shr ah, 1
	shr ah, 1
	and al, 00001111b
	
	mov bl, ah
	mov bh, 0
	mov ah, table[bx]
	
	mov bx, 0B800H
	mov es, bx
	mov es:[160*12+40*2], ah
	
	mov bl, al
	mov bh, 0
	mov al, table[bx]

	mov es:[160*12+40*2+2], al
	
	pop es
	pop bx
	ret

code ends
end start