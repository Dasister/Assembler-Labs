.data

.globl _lab1UW

.text
_lab1UW:
    /* Nulling variables */
    movl $0, _nominator
    movl $0, _denominator
    movl $0, _res

    /* Nominator */
    movw $2, %ax
    mulw _a
    /* Splitting DX:AX pair into EAX */
    and $0x0000ffff, %eax /* Clearing upper bits of EAX */
    shl $16, %edx /* Shifting DX into position.  */
    or %edx, %eax /* Combining into EAX */
    cltd
    divl _b
    subl $1, %eax
    movl %eax, _nominator
    /*xorl %eax, %eax
    movw $2, %ax
    mulw _a
    /* Splitting DX:AX pair into EAX */
    /* and $0x0000ffff, %eax /* Clearing upper bits of EAX */
    /* shl $16, %edx /* Shifting DX into position.  */
    /* or %edx, %eax /* Combining into EAX */
    /* xorl %edx, %edx
    idivl _b */

    /* Denominator */
    xorl %eax, %eax
    movl _a, %eax
    addl _c, %eax
    subl $28, %eax
    movl %eax, _denominator

    /* Res */
    movl _nominator, %eax
    cltd /* Convert long to double long */
    idivl _denominator
    movl %eax, _res
    ret

