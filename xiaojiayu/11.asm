assume cs:codesg
codesg segment

	dw 0123H, 04567H, 0789H, 0ABCH, 0DEFH, 0FEDH, 0CBAH, 0987H
	dw 0, 0, 0, 0, 0, 0, 0, 0
	;用dw定义8个字型数据，再程序加载后，将取得8个字的内存空间
	;在后面的程序中将这段空间当做栈来使用
start:
	mov ax, cs
	mov ss, ax
	mov sp, 32 ;设置栈顶ss:sp指向cs:32
	mov bx, 0
	mov cx, 8
	
s:
	push cs:[bx]
	add bx, 2
	loop s ;以上将代码段0~16单元中的8个字型数据依次入栈
	
	mov bx, 0
	mov cx, 8

s0:
	pop cs:[bx]
	add bx, 2
	loop s0 ;以上依次出栈8个字型数据到代码段0~16单元中
	
	mov ax, 4C00H
	int 21H
	
codesg ends
end start ;指明程序的入口在start处