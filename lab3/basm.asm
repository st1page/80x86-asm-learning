.386
.model flat, c
v ebx, offset s
	mov ecx, N
	avg_iter :
		xor ah, ah
		mov al, 10[ebx]
		shl ax, 1

		add al, 11[ebx]
		adc ah, 0
		shl ax, 1

		add al, 12[ebx]
		adc ah, 0

		mov dl, 7
		div dl

		mov 13[ebx], al
		add bx, 14
	loop avg_iter
    ret
calc_avg endp

get_poin proc
	mov ecx, N;
	mov ebx, offset s
	find_iter :
		mov esi, ebx
		mov edi, offset in_name
		push ebx
		push ecx
		mov cl, 10
		xor ch, ch
		strcmp_iter :
			mov dl, [esi]
			cmp dl, [edi]
			jnz next
			inc esi
			inc edi
		loop strcmp_iter
		jmp found
		next :
			pop ecx
			pop ebx
			add ebx, 14
		loop find_iter
		jmp not_found
	found :
	mov poin, ebx
		pop ecx
		pop ebx
	not_found:
	ret
get_poin endp
    end