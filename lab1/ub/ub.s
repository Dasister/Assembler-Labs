.data

.globl _lab1UB

.text
_lab1UB:
    /* Nulling variables */
    movw $0, _nominator
    movw $0, _denominator
    movw $0, _res

    /* Nominator */
    xorw %ax, %ax
    movb $2, %al
    mulb _a
    divb _b
    subb $1, %al
    cbtw
    movw %ax, _nominator

    /* Denominator */
    xorw %ax, %ax
    movb _a, %al
    addw _c, %ax
    subw $28, %ax
    movw %ax, _denominator

    /* Res */
    xorw %dx, %dx
    movw _nominator, %ax
    cwtd
    idivw _denominator
    movw %ax, _res
    ret
