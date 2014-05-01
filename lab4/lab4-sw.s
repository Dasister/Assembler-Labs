.data
	.extern scanf
	.extern printf

	.globl main
	.type main, @function
	.type read_value, @function

read_formatstring:
	.asciz "%d"

write_formatstring:
	.asciz "%d\n"
	
n:
	.long 0

c:
	.long 0

d:
	.long 0

sum:
	.long 0

input_n_label:
	.asciz "Input n: "

input_c_label:
	.asciz "Input c: "

input_d_label:
	.asciz "Input d: "

arr:
	.space 4000000
	/* Reserving 4000000 bytes for array. sizeof(int) * 1000000 */
	
.text

read_value:
	pushl %ebp
	movl %esp, %ebp

	subl $4, %esp
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
read_n:	
	pushl $input_n_label
	call printf
	addl $4, %esp

	call read_value
	movl %eax, n

read_c:
	pushl $input_c_label
	call printf
	addl $4, %esp

	call read_value
	movl %eax, c
	
read_d:	
	pushl $input_d_label
	call printf
	addl $4, %esp

	call read_value
	movl %eax, d
	
	movl $0, %ecx
	
read_array_loop:

read_array_element:	
	call read_value
	movl %eax, arr(, %ecx, 4)
	
	
	inc %ecx
	cmp %ecx, n
	jne read_array_loop

	movl $0, %ecx
proceed_loop:
	movl arr(, %ecx, 4), %eax
	cmpl %eax, c
	jg loop_check
	cmp %eax, d
	jl loop_check
	addl %eax, sum

	
loop_check:
	incl %ecx
	cmpl %ecx, n
	ja proceed_loop

	pushl sum
	pushl $write_formatstring
	call printf
	addl $8, %esp
	ret
	