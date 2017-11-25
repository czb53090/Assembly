assume cs:codesg, ds:data, es:table

data segment
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
	db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
	db '1993', '1994', '1995'
	;以上是表示21年的21个字符串
	
	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
	;以上是表示21年公司总收入的21个dword型数据
	
	dw 3, 7, 8, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
	;以上是表示21年公司雇员人数的21个word型数据
data ends

table segment
	db 21 dup ('year summ ne ??')
table ends

codesg segment
start:
	mov ax, data
	mov ds, ax
	mov ax, table
	mov es, ax

	mov bx, 0
	mov si, 0
	mov di, 0
	mov cx, 21
	
s:
	;存放年份
	mov al, [bx]
	mov es:[di], al
	mov al, [bx+1]
	mov es:[di+1], al
	mov al, [bx+2]
	mov es:[di+2], al
	mov al, [bx+3]
	mov es:[di+3], al
	
	;存放公司总收入
	mov ax, 54H[bx]
	mov dx, 56H[bx]
	mov es:5H[di], ax
	mov es:7H[di], dx

	;存放公司人数
	mov ax, 048H[si]
	mov es:0AH[di], ax
	

	;存放人均收入
	mov ax, 54H[bx]
	mov dx, 56H[bx]
	div word ptr ds:048H[si]
	mov es:0DH[di], ax

	
	add bx, 4
	add di, 16
	add si, 2
	loop s
	
	mov ax, 4C00H
	int 21H
	
codesg ends
end start