.data
	ask: .asciiz "Enter a number and then another and I will print the sum\n"
.text
.globl main

main:
	#print "Enter a number and then another and I will print the sum\n"
	li $v0, 4
	la $a0, ask
	syscall
	
	#receive a number
	li $v0, 5
	syscall

	#put received number in temp register
	move $t0, $v0
	syscall

	#receive a number
	li $v0, 5
	syscall
	
	#put received number in temp register
	move $t1, $v0
	syscall

	#add numbers in temp register
	add $t2, $t0, $t1
	syscall
	
	#print sum
	li $v0, 1
	move $a0, $t2
	syscall