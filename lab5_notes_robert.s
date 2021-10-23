    .data

prompt:         .asciiz  "Please enter the first integer:\n"
prompt2:        .asciiz  "Please enter the second integer:\n"
newline:        .asciiz  "\n"

    .text
    .globl  main

# Notes about registers
# Registers are variables built-in to MIPS.
# $t0-9 are temporary registers we can use, I assume they never get changed by anything except us.
# So here is what I'm using them as:
#	$t0 ~ base value which the user inputs (never changes)
#	$t1 ~ exponent which the user inputs (never changes)
#	$t2 ~ final value, (base value)^exponent (changes when I do mult $t2, $t2, $t0)
#	$t3 ~ loop counter, starts at 1, incremented at end of multiplyAndPrint

main:
    # prompt to enter the first integer
    li $v0, 4
    la $a0, prompt
    syscall

    # read the first integer and store it in $t0
    li $v0, 5
    syscall
    move $t0, $v0

    # [ implement your code here ]
    # prompt to enter the second integer
    li $v0, 4
    la $a0, prompt2
    syscall

    # read the second integer and store it in $t1
    li $v0, 5
    syscall
    move $t1, $v0
    
    #initialize product as the base value
    move $t2, $t0
    li $t3, 1

    #jumps to the top of powerloop. jumps back here when powerloop does: jr $ra
    jal powerloop

    # Terminate the program
    li $v0, 10
    syscall

.end main

powerloop:
    #if loop counter ($t3) is not equal to user's power input ($t1), then jumps to multiplyAndPrint
    bne $t3, $t1, multiplyAndPrint

    # return to the function caller of powerloop
    jr $ra

multiplyAndPrint:
    #loops as many times as needed

    #multiplies $t0 with $t2, and stores it in $t2
    mul $t2, $t2, $t0
    
    #print intermediate value
    li $v0, 1
    move $a0, $t2
    syscall

    #print newline
    li $v0, 4
    la $a0, newline
    syscall

    # $t3++
    add $t3, $t3, 1

    #jumps to the top of powerloop again
    j powerloop

### End of file

# General Notes about MIPS Assembly in QtSPIM
# Most types of commands work on that line and then are done, like normal code in higher level languages.
#	Such as	moving data around with li, la, etc.,
#		doing math with add, mult, etc.,
#		starting an if statement with beq, bne, etc.
# On the other hand, Input/Output commands take multiple lines - first you load up numbers into $v0 and $a0, $a1, etc.
#	then you do syscall to 'pull the trigger' and MIPS does the command using whatever is in $v0 and all the relevant $a's
# The ones I know:
	#prints integer in $a0
# 	li $v0, 1
# 	syscall

	#prints string whose address is in $a0
#	la $v0, 4
#	syscall

	#one time, receives data from console when entered, and puts that data in $v0
	#	($v0 is the output register, but I guess syscall uses it to tell which command to do)
#	li $v0, 5
#	syscall

# To assign numbers, you need a few different commands, there is no catch-all equal sign

#	li $t0, 3  	#copy direct number to register		load immediate
#	la $t0, my_str	#copy address to register		load address
#	lw $t0, my_num	#copy number at address to register	load word (word means 32-bit number)

#	move $t0, $t1	#copy register to register		move

#	sw $t0, my_num	#copy register to address		store word (also other options besides word)

# Jumping commands
#	j myfunc	#simple jump: goes to myfunc
#	jal myfunc	#jump with return: goes to myfunc and if you do jr $ra in myfunc then it jumps back and continues after the jal
#	jr $ra		#return to jal: $ra ~ return address, which is assigned by jal
#	beq $t0, $t1, myfunc	#if-equal: jumps to myfunc if $t0 == $t1 (== is not a thing in MIPS)
#	bne $t0, $t1, myfunc	#if-not-equal: same but if !=