	.data
	.text
	.globl main
main:
	li $v0, 7
	syscall

	li $t0, 6
	li $t1, 1

myloop:
	bne $t0, $t1, printAndIncrement
	j end
.end main

printAndIncrement:
	li $v0, 1
	move $a0, $t1
	syscall
	add $t1, $t1, 1
	j myloop

end:
	li $v0, 10
	syscall