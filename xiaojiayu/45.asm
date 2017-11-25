assume cs:code

code segment
start:
	mov al, 60 ; 欲求出sin(60°)的大小
	call showsin
	
	mov ax, 4C00H
	int 21H
	
showsin:
	jmp short showsin
	
	table 	dw ag0, ag30, ag60, ag90, ag120, ag150, ag180
	ag0		db '0', 0
	ag30	db '0.5', 0
	ag60	db '0.866', 0
	ag90	db '1', 0
	ag120	db '0.866', 0
	ag150	db '0.5', 0
	ag180	db '0', 0
	
show:
	push bx
	push es
	push si
	
	mov bx, 0B800H

; 以下用角度值/30作为相对于tabgle的偏移量，取得对应的字符串的
; 偏移地址，放在bx中
	mov ah, 0
	mov bl, 30
	div bl
	mov bl, al
	mov bh, 0
	add bx, bx
	mov bx, table[bx]

; 以下显示sin(x)对应的字符串
shows:
	mov ah, cs:[bx]
	cmp ah, 0
	je showret
	mov es:[si], ah
	inc bx
	add si, 2
	jmp show

showret:
	pop si
	pop es
	pop bx
	ret
	
code ends
end start
