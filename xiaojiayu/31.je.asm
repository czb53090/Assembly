assume cs:code

code segment
start:
	cmp ah, bh
	je s
	add ah, bh
	jmp short ok
s:
	add ah, ah
ok: ret

code ends
end start