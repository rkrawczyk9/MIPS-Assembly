	.data

equal:   asciiz	"5 = 3"
unequal: asciiz	"5 != 3"

	.text
	.globl main

main:
	
	beq $t0, $t1, ifequal
	bne $t0, $t1, ifunequal
	syscall
	
	jr $31

ifequal:
	lw $v0, equal
	syscall

else:
	lw $v1, unequal
	syscall

### add $t0, $t1, $t2 ### t0 = t1 + t2
### sub $t0, $t1, $t2 ### t0 = t1 - t2