.data

    .globl _Lab2UW

.text

/*

    100 100 -300
    1 2 -1
    30010 15000 2

*/

_Lab2UW:
    xorl %eax, %eax
    xorl %ebx, %ebx
    movw _a, %ax
    movw _b, %bx
    cmpw %ax, %bx
    jb _greater
    ja _lower
    jmp _equal

_lower:
    xorl %edx, %edx
    divl %ebx
    subl $1, %eax
    movl %eax, _res
    jmp _ret

_greater:
    subl $10, %eax
    xorl %edx, %edx
    idivl %ebx
    movl %eax, _res
    jmp _ret

_equal:
    movl $-300, _res

_ret:
    ret
