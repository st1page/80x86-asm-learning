.386
BR macro
    mov	ah, 02h		; \r
    mov	dl, 0dh
    int	21h
    mov	ah, 02h		; \n
    mov	dl, 0ah
    int	21h
endm

stackseg segment use16 stack
	dw 10 dup(0)
stackseg ends

dataseg segment use16

    s1 db 'Please input the name of the student: $'
	s2 db 'Student not found, please re-input ... ',0dh,0ah,'$'
	s3 db 'the level of the student are: $'
    s4 db 'exit!',0dh,0ah,'$'

	in_name_head db 10, ?
	in_name db 10 dup(0)

    N equ 10
    s_name equ 0
    s_mx_name equ 9
    s_a equ 10
    s_b equ 11
    s_c equ 12
    s_avg equ 13
    s_len equ 14
    BUF db 'ZhangSan', 2 dup(0) ;学生姓名，不足10个字节的部分用0填充
    db 100, 85, 80, ?   ;平均成绩还未计算
    db 'LiSi', 6 dup(0) 
    db 80, 100, 70, ? 
    db 'mxtest', 4 dup(0) 
    db 100, 100, 100, ? 
    db 'mntest', 4 dup(0) 
    db 0, 0, 0, ?  
    db N-5 dup('TempValue', 0, 80, 90, 95, ?); 除了已经定义了的学生信息及成绩表外，其他学生的暂时成绩假定是一样的
    db 'stonepage', 0    ;最后一个必须修改为自己名字的拼音
    db 85, 85, 100, ?
    poin dw 0
dataseg ends


codeseg segment use16

    assume ss:stackseg, ds:dataseg, cs:codeseg
start:
    mov	ax, dataseg
	mov ds, ax
    mov ax, stackseg
    mov ss, ax
    mov sp, 20

avg_all:
    mov bx, offset BUF
    mov cx, N
    avg_iter:
        xor ah, ah
        mov al, s_a[bx] 
        shl ax, 1

        add al, s_b[bx]
        adc ah, 0
        shl ax, 1
        
        add al, s_c[bx]
        adc ah, 0
       
        mov dl, 7
        div dl

        mov s_avg[bx], al
        add bx, s_len
    loop avg_iter

input:
    mov	ah, 09h
	mov	dx, offset s1
	int	21h	
    mov	ah, 0ah
    mov in_name_head, s_mx_name+1
    lea	dx, in_name_head
	int	21h
    BR

    ;0dh=='\n' 71h=='q'
    cmp	in_name, 0dh
	jz	input
	cmp	in_name, 71h
    jnz	filter
	cmp	in_name+01h, 0dh
	jnz	filter
    
    jmp quit
filter:
    mov bl, in_name_head[1]
    xor bh, bh
    mov byte ptr in_name[bX], 0
find:
    mov cx, n
    mov bx, offset BUF
    find_iter:
        lea si, s_name[bx]
        mov di, offset in_name
        push bx
        push cx
        mov cl, in_name_head[1]
        xor ch, ch
        strcmp_iter:
            mov dl, [si]
            cmp dl, [di]
            jnz next
            inc si
            inc di
        loop strcmp_iter
        jmp found
    next:
        pop cx
        pop bx
        add bx, s_len
    loop find_iter  
not_found:   
    mov	ah, 09h
	mov	dx, offset s2
	int	21h	
    jmp input
found:
    mov poin, bx
    mov al, s_avg[bx]
outs3:
    mov	dx, offset s3
    mov	ah, 09H
    int	21H
judge:
    mov	dl, 'A'
    cmp al, 90
	jge outlevel
    inc dl
	cmp al, 80
	jge outlevel
    inc dl
	cmp al, 70
	jge outlevel
    inc dl
	cmp al, 60
	jge outlevel
    add dl, 2
outlevel:
    mov	ah,	02h
	int	21h
    BR
    jmp input
quit:
    mov	ah, 09h
	mov	dx, offset s4
	int	21h	
	mov	ax, 4c00h
	int	21h
codeseg ends 
end start