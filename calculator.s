#Calculator

.data

ask: .asciiz "Enter a calculation (ex. '3+4'): "
calculation: .space 5
inval: .asciiz "Invalid operation"
plus: .asciiz "+      "

.text
.globl main
main:

li $v0, 4
la $a0, ask
syscall

li $v0, 8
la $a0, calculation
li $a1, 5
syscall

li $v0, 4
la $a0, calculation
syscall

li $v0, 11
li $a0, 61
syscall


li $v0, 1

la $t0, calculation
lb $t1, 0($t0)
lb $t2, 1($t0)
lb $t3, 2($t0)
lb $s1, 43
lb $s2, 45
lb $s3, 52
lb $s4, 57 
beq $s1, $t3, addition	#error occurs on these four beq's, bad stack read, I don't know why
beq $s2, $t3, subtraction
beq $s3, $t3, multiplication
beq $s4, $t3, division
invalid:
li $v0, 4
la $a0, inval
syscall
j exit

addition:
add $a0, $t1, $t3
j done

subtraction:
sub $a0, $t1, $t3
j done

multiplication:
mult $t1, $t3
mflo $a0
j done

division:
div $a0, $t1, $t3
j done

done:
syscall

exit:
li $v0, 10
syscall