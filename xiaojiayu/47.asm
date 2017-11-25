; 编程：接受用户的键盘输入，输入“r” ，将屏幕上的字符设置伪红色，
; 输入“g“则为绿色，“b”为蓝色

; A、B、C处的程序指令比较有技巧
assume cs:code
	
code segment
start:
	mov ah, 0
	int 16H
	
	mov ah, 1		;A
	cmp al, 'r'
	je red
	cmp al, 'g'
	je green
	cmp al, 'b'
	je blue
	jmp short sret
	
red:
	shl ah, 1		;B
green:
	shl ah, 1		;C
blue:
	mov bx, 0B800H
	mov es, bx
	mov bx, 1
	mov cx, 2000
s:
	and byte ptr es:[bx], 11111000B; 清空前三位的前景色
	or es:[bx], ah
	add bx, 2
	loop s
	
sret:
	mov ax, 4C00H
	int 21H
	
code ends
end start