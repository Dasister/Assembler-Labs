.model tiny
.stack 64

.data
	namepar label byte
	maxlen db 10
	actlen db 0
	var db 20 dup(0), '$'

	a dw 0
	b dw 0

	res dw 0

	error_lbl db, "Error", '$'
	
	prompt_a db, "Input a [-32768..32767]: ", '$'
	prompt_b db, "Input b [-32768..32767]: ", '$'

	print_prompt db "Result: ", '$'
.code
	org 100h

public _main
_main proc far
read_a:	
	mov ah, 09
	mov dx, offset prompt_a
	int 21h

	call read_word
	jc read_a
	mov a, ax

read_b:
	mov ah, 09
	mov dx, offset prompt_b
	int 21h

	call read_word
	jc read_b
	cmp ax, 0
	je read_b
	mov b, ax


	mov ax, a
	mov bx, b
	cmp ax, bx
	jg greater
	jl lower

	;; Equal
	mov res, -300
	jmp _ret

lower:
	cwd
	idiv b
	sub ax, 1
	mov res, ax
	jmp _ret
	
greater:
	sub ax, 10
	cwd
	idiv b
	mov res, ax
	jmp _ret

_ret:
	mov dx, offset print_prompt
	mov ah, 09
	int 21h
	mov ax, res
	call print_sword
	
	int 20h			; Exit program
	ret
_main endp

convert_string_to_word proc near
	push cx
	push dx
	push bx
	push si
	push di

	clc			; Reset CF
	
	mov si, dx
	mov di, 10
	xor cx, cx
	mov cl, actlen
	jcxz error 		; If cx == 0 then error
	xor ax, ax
	xor bx, bx

convert_loop:
	mov bl, [si]		; Symbol into bl
	inc si			; Next symbol
	cmp bl, '0'
	jl error		; If bl < '0', then error	
	cmp bl, '9'
	jg error		; If bl > '9', then error
	sub bl, '0'
	mul di
	jc error		; If CF, then error
	add ax, bx
	jc error		; If CF, then error
	loop convert_loop
	jmp read_end_ret

error:
	xor ax, ax
	stc			; Set CF

read_end_ret:	
	pop di
	pop si
	pop bx
	pop dx
	pop cx
	
	ret
convert_string_to_word endp	
	
	;; Reading string and converting it to word value
read_word proc near
	mov bx, 0
	mov ch, 0
	mov cl, maxlen
	mov dx, offset var
	mov ah, 3Fh
	int 21h
	sub al, 2		; Delete \r\n symbols from string
	mov actlen, al

	push bx
	push dx
	
	test al, al
	jz read_error		; Length == 0
	mov bx, dx
	mov bl, [bx]		; Get char of string
	cmp bl, '-'
	jne no_sign
	inc dx			; Next char
	dec actlen		; Decrease length of string

no_sign:
	call convert_string_to_word
	jc error
	cmp bl, '-'
	jne plus
	cmp ax, 32768		; We can't hold more than 32768
	ja read_error
	neg ax
	jmp all_fine		; All fine, reading is done
plus:
	cmp ax, 32767		; We can't hold more than 32767
	ja read_error
	
all_fine:
	clc
	jmp _ret_read

read_error:
	xor ax, ax
	stc

_ret_read:	
	pop dx
	pop bx
	ret
read_word endp


	;; Word into ax
print_sword proc near
	push ax
	push cx
	push dx
	push bx

	cmp ax, 0
	jnl continue
	push ax
	xor ax, ax
	mov ah, 02h
	mov dx, '-'
	int 21h
	pop ax
	neg ax

continue:	
	xor cx, cx
	mov bx, 10

to_str_loop:
	xor dx, dx
	div bx
	add dl, '0'
	push dx			; Pushing char to stack
	inc cx
	test ax, ax
	jnz to_str_loop

	xor ax, ax
	mov ah, 02h
print_loop:
	pop dx			; Pop character from stack
	int 21h
	loop print_loop
	
	pop bx
	pop dx
	pop cx
	pop ax
	ret
print_sword endp	
	
end
