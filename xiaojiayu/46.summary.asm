assume cs:code

code segment
start:

; 清屏
sub1:
	push bx
	push cx
	push es
	mov bx, 0b800H
	mov es, bx
	mov bx, 0
	mov cx, 2000
sub1s:
	mov byte ptr es:[bx], ''
	add bx, 2
	loop sub1s
	pop es
	pop cx
	pop bx
	ret
	
; 设置前景色
sub2:
	push bx
	push cx
	push es
	mov bx, 0b800H
	mov es, bx
	mov bx, 1
	mov cx, 2000
sub2s:
	and byte ptr es:[bx], 11111000b
	or es:[bx], al
	add bx, 2
	loop sub2s
	pop es
	pop cx
	pop bx
	ret
	
; 设置背景色
sub3:
	push bx
	push cx
	push es
	mov bx, 0b800H
	mov es, bx
	mov bx, 1
	mov cx, 2000
sub3s:
	and byte ptr es:[bx], 10001111b
	or es:[bx], al
	add bx, 2
	loop sub2s
	pop es
	pop cx
	pop bx
	ret

code ends
end start