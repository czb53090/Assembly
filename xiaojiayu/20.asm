mov ax, seg
mov ds, ax	
mov bx, 60H				  ; 确定记录地址：ds:bx
mov word ptr [bx].0cH, 38 ; 排名字段改为38, dec.pm = 38;
add word ptr [bx].0eH, 70 ; 收入字段增加70, dec.sr = dec.sr+70;

mov si, 0
mov byte ptr [bx].10H[si], 'V' ; dec.cp[i] = 'V';
inc si						   ; i++;
mov byte ptr [bx].10H[si], 'A' 
inc si
mov byte ptr [bx].10H[si], 'X'