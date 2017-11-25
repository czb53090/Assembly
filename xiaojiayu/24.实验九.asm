assume cs:code, ds:data, ss:stack

data segment
	db 'welcome to masm!' ; 定义要显示的字符串
	db 02h, 24h, 71h	  ; 定义三种颜色属性
data ends

stack segment
	dw  8 dup(0)
stack ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 10h
	
	xor bx, bx 		; bx清零，用来索引颜色
	mov ax, 0b872h  ; 算出屏幕第12行中间的显存的段其实位置放入ax中
	
	mov cx, 3		; s3循环控制行数，外循环为3次，因为要显示3个字符串
s3:
	push cx			; 三个入栈操作为外循环s3保存相关寄存器的值
	push ax			; 以防他们的值再内循环中被破坏
	push bx
	
	mov es, ax		; 此时es为屏幕第12行中间的宣存的段起始位置
	
	mov si, 0		; si用来索引代码列的字符
	mov di, 0		; di用来定位目标列
	
	mov cx, 10h
	; s1循环控制存放的字符，内循环为10h次，因为一个字符串包含10h个字节
s1:
	mov al, ds:[si]
	mov es:[di], al
	inc si
	add di, 2
	loop s1 		; 次循环实现偶地址中存放字符
	
	mov di, 1		; di的值设为1，从而在显存基地址中存放字符的颜色属性做准备
	pop bx
	mov al, ds:10h[bx]
	inc bx
	
	mov cx, 10h
s2:
	mov es:[di], al
	add di, 2
	loop s2
	
	; 一下4句为下一趟外循环做准备
	pop ax
	add ax, 0ah		; 将显存的段起始地址设为当前行的下一行 
					; [再段地址中加0ah，相当于在偏移地址中加了0a0h(=160d)]
	pop cx
	loop s3
	
code ends
end start
	