.data

	.extern scanf
	.extern print

	.globl lab5

.text

/* (2 * a / b - 1) / (a - 28 + c) */
	
lab5:
	fldl a
	subl $4, %esp
	movl $2, -4(%esp)
	fildl -4(%esp)
	addl $4, %esp
	fmulp %st, %st(1)
	fldl b
	fdivrp %st, %st(1)
	fld1
	fsubrp %st, %st(1)
	fstpl nominant

	subl $4, %esp
	movl $28, -4(%esp)
	fildl -4(%esp)
	addl $4, %esp
	fldl a
	fsubp %st, %st(1)
	fildl c
	faddp %st, %st(1)
	fstpl determinant

	fldl nominant
	fldl determinant
	fdivrp %st, %st(1)
	fstpl res
	ret
	