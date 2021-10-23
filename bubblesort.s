#bubble sort

.data
array: .word 4, 8, 12, 9, 4, 5, 6, 1, 2, 500
array_len: .word 10

.text
.globl main

li $t0, -4	#previous candidate bubble number
li $t1, 0	#current candidate bubble number

findBubble:
	add $t0, $t0, 4
	add $t1, $t1, 4
	bgt $t1, array.lengthInBytes, done
	blt $t0(array), $t1(array), findBubble

move $t2, $t0
move $t3, $t1
bubbleUp:
	lw $t4, $t2(array)
	sw $t3(array), 	$t2(array)
	sw $t4, 	$t3(array)

	add $t0, $t0, 4
	add $t1, $t1, 4
	bgt $t0(array), $t1(array), bubbleUp
j findBubble
	
done:
	li $t5, -4
	printArray:
		li $v0, 1
		lw $a0, $t5(array)
		syscall
		blt $t5, array_len, printArray
	
	li $v0, 10
	syscall