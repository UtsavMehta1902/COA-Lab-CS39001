# Assignment - 1
# Problem - 2
# Semester - 5
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)


# This program takes 2 integers as input, checks if both are positive,
# and computes their Greatest Common Divisor (GCD).

.globl main
.data

# Various strings useful for interacting with the user.
prompt1:
    .asciiz "Enter the first positive integer: "
prompt2:
    .asciiz "Enter the second positive integer: "
posCheck:
    .asciiz "Please provide positive numbers only."
output:
    .asciiz "GCD of the two integers is: "

newline:
    .asciiz "\n"

.text

# main program
# program variables:
# A (input integer-1):	$s0
# B (input integer-2):	$s1

main:

    # Ask the user to input first integer (A)
    li $v0, 4
    la $a0, prompt1
    syscall

    # Take A as input
    li $v0, 5
    syscall

    # Store the value of A is $s0
    move $s0, $v0

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # Ask the user to input second integer (B)
    li $v0, 4
    la $a0, prompt2
    syscall

    # Take B as input
    li $v0, 5
    syscall

    # Store the value of B in $s1
    move $s1, $v0

    # In case, any of the integers is less than equal to zero, 
    # branch to InvalidInput
    ble $s0,0,InvalidInput
    ble $s1,0,InvalidInput

    # Trivial case when A equals 0
    beq $s0,0,trivial

# Keep repeating while B is non-zero
while:
    beq $s1,0,endw      # If B becomes zero, branch to endw (stands for end-while)
    bgt $s0,$s1,case1   # If A>B, branch to case1
    ble $s0,$s1,case2   # If A<=B, branch to case2

# Case when A>B
case1:
    sub $s0,$s0,$s1     # A-=B
    b while             # Go back to the while loop

# Case when A<=B
case2:
    sub $s1,$s1,$s0     # B-=A
    b while             # Go back to the while loop

# When the while loop ends
endw:

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # Print the prompt of output
    li $v0, 4
    la $a0, output
    syscall

    # Print the GCD
    li $v0,1
    move $a0,$s0
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Trivial case when A=0.
trivial:
    move $s0,$s1
    b    endw

# Case when any of the given integers is negative.
InvalidInput:

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # Print the prompt to ask the user to input a positive integer.
    li $v0, 4
    la $a0, posCheck
    syscall

    # Exit the program
    li $v0, 10
    syscall
