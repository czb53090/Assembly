assume cs:code

code segment
start:
	mov al, 8
	out 70h, al ; 得到月份信息
	in al, 71h ; 取出月份信息到al中
	
	mov ah, al ; 拷贝一份月份信息到ah中
	mov cl, 4
	shr ah, cl ; 获得月份的十位
	and al, 00001111b ; 获得月份的个位

	; 分别取得字符表示
	add ah, 30h
	add al, 30h
	
	; 显示数据
	mov bx, 0b800H ; 显存地址
	mov es, bx
	mov byte ptr es:[160*12+40*2], ah
	mov byte ptr es:[160*12+40*2+2], al
	
code ends
end start