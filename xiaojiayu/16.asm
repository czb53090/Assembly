assume assume cs:codesg, ds:datasg

datasg segment
	db 'BaSiC'
	db 'iNfOrMaTiOn'
datasg ends

codesg segment
start:
	mov ax, datasg
	mov ds, ax
	mov bx, 0
	mov cx, 5
s:
	mov al, [bx]
	and al, 11011111B
	mov [bx], al
	
	mov al, [5+bx] ;或 5[bx] 或 [bx].5
	or  al, 00100000B
	mov [bx], al
	
	inc bx
	
	loop s
	
	mov ax, 4c00H
	int 21H

codesg ends

end start