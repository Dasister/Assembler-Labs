.data

.globl _lab1Byte

.text
_lab1Byte:
    /* Nulling variables */
    movw $0, _nominator
    movw $0, _denominator
    movw $0, _res

    /* Nominator */
    xorw %ax, %ax
    movb $2, %al
    imulb _a
    cwtd
    idivw _b
    subw $1, %ax
    movw %ax, _nominator

    /* Denominator */
    xorw %ax, %ax
    movb _a, %al
    cbtw
    addw _c, %ax
    subw $28, %ax
    movw %ax, _denominator

    /* Res */
    movw _nominator, %ax
    cwtd
    idivw _denominator
    movw %ax, _res
    ret
