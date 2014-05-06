.data

    .globl _Lab2SW

.text


/*

    -32000  -32000 -300
    32010   -16000  -2
    -32000  16000   -3

*/

_Lab2SW:
    movw _b, %ax
    cwtl
    movl %eax, %ebx
    movw _a, %ax
    cwtl
    cltd
    cmpl %eax, %ebx
    jl _greater
    jg _lower
    jmp _equal

_lower:
    idivl %ebx
    subl $1, %eax
    movl %eax, _res
    jmp _ret

_greater:
    subl $10, %eax
    idivl %ebx
    movl %eax, _res
    jmp _ret

_equal:
    movl $-300, _res

_ret:
    ret

