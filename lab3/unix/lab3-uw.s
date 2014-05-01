.data
	.extern scanf
	.extern printf

	.globl main
	.type main, @function
	.type read_word, @function
	
a:
	.long 0

b:
	.long 0

res:
	.long 0

read_formatstring:
	.asciz "%d"

write_formatstring:
	.asciz "%d\n"

input_a_label:
	.asciz "Input a [0..65535]: "

input_b_label:
	.asciz "Input b [0..65535]: "
	
.text

read_value:
	pushl %ebp
	movl %esp, %ebp

	subl $4, %esp /* Reserving stack */
	leal -4(%esp), %eax
	pushl %eax
	pushl $read_formatstring
	call scanf

	addl $8, %esp

	xorl %eax, %eax
	movl -4(%esp), %eax
	movl %ebp, %esp	
	popl %ebp
	ret
	
main:
/*	Reading a Variable	 */
read_a:
	pushl $input_a_label
	call printf
	addl $4, %esp

	call read_value
	cmp $0, %eax
	jb read_a
	cmp $65535, %eax
	ja read_a
	movl %eax, a
/*	Reading b Variable	 */
read_b:
	pushl $input_b_label
	call printf
	addl $4, %esp

	call read_value
	cmp $0, %eax
	jb read_b
	cmp $65535, %eax
	ja read_b
	movl %eax, b
	

/*	Solving			 */
	xorl %eax, %eax
	xorl %ebx, %ebx
	movl a, %eax
	movl b, %ebx
	cmpl %eax, %ebx
	jb greater
	ja lower

equal:
	movl $-300, res
	jmp _ret
	
lower:
	xorl %edx, %edx
	divl %ebx
	subl $1, %eax
	movl %eax, res
	jmp _ret

greater:
	subl $10, %eax
	cltd
	idivl %ebx
	movl %eax, res
	jmp _ret

_ret:
	pushl res
	pushl $write_formatstring
	call printf
	addl $8, %esp
	ret
	
