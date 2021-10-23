# Source: MIPS Asseembly Language Programming Using QtSpim
#   URL: https://open.umn.edu/opentextbooks/textbooks/734
#
# Objectives: Learn how to use a stack to reverse values in an array 
#
# ----------------------------------------------------
# Data Declarations

.data

str:	.asciiz	"Hello, World!"

# ----------------------------------------------------
# Text/code section
#
# Basic approach:
#   - loop to push each character onto the stack
#   - loop to pop each character off the stack
# Final result is all characters reversed.

.text 
.globl main
.ent main

main:
# ----
# Loop to read characters from string and push to stack.

	#li $v0, 4
	#la $a0, str
	#syscall

    la $t0, str       # get string starting address
    li $t1, 0           # loop index, i=0
    li $t2, 14      # string length

pushLoop:
    lb $t4, ($t0)       # get string[i]

    subu $sp, $sp, 1    # push array[i] to stack
    sb $t4, ($sp)

    add $t1, $t1, 1     # i = i+1
    add $t0, $t0, 1     # update string address (by 1 byte)

    # if i < length, continue the loop
    blt $t1, $t2, pushLoop

# ----
# Loop to pop items from stack and write into array
    la $t0, str       # get string starting address
    li $t1, 0           # loop index, i=0

popLoop:
    lb $t4, ($sp)       # pop array[i]
    addu $sp, $sp, 1

    sb $t4, ($t0)       # set string[i] #For some reason I can't get this to work, str ends up empty

	lb $a0, ($t0)	#... so I'm just printing it out as it goes
	li $v0, 11
	syscall

    add $t1, $t1, 1     # i = i+1
    add $t0, $t0, 1     # update string addreess

    # if i < length, continue the loop
    blt $t1, $t2, popLoop

# ----
# Done, terminate the program

    li $v0, 4
    la $a0, str
    syscall

    li $v0, 10
    syscall

.end main