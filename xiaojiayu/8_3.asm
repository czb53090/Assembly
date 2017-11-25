assume cs:codesg
	codesg segment
	start:
		mov ax, 0ffffh
		mov ds, ax
		mov al, ds:[6]
		mov ah, 0
		mov dx, 0
		
		mov cx, 123
		s:
			add dx, ax
		loop s
			
		mov ax, 4c00h
		int 21h

	codesg ends
end start