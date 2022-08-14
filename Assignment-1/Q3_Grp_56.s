# Assignment - 1
# Problem - 3
# Semester - 5
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)


# This program takes 1 integer as input, checks if it is >= 10,
# and computes whether it is PRIME or COMPOSITE.

.globl main

.data

# Various strings useful for interacting with the user.
prompt:
    .asciiz "Enter a positive integer greater than equals to 10: "
sanityCheck:
    .asciiz "Please enter a number greater than equal 10."
output1:
    .asciiz "Entered number is a PRIME number."
output2:
    .asciiz "Entered number is a COMPOSITE number."
newline:
    .asciiz "\n"

.text

# main program
# program variables:
# n (input integer):	            $s0
# i (iterator, initialized to 2):   $s1

main:

    # Ask the user to input an integer >= 10
    li $v0, 4
    la $0,a prompt
    syscall

    # Take the input integer
    li $v0, 5
    syscall

    # Move the input integer to $s0
    move $s0,$v0

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # If the given integer is <= 10, branch to InvalidInput
    blt $s0,10,InvalidInput
    
    # Iterator to loop from 2 to sqrt(n), initialized to 2
    li $s1, 2

# Keep iterating from 2 to sqrt(n)
for:
    mul $s2,$s1,$s1             # Store i^2 in $s2
    bgt $s2,$s0,prime           # If i^2 > n, break, and branch to prime
    div $s0,$s1                 # Divide n by i => (n/i)
    mfhi $s2                    # Move the remainder of division to $s2
    beq $s2,$zero,composite     # If the remainder is zero, immediately branch to composite
    add $s1,$s1,1               # Increment the iterator i
    b for                       # Keep continuing the loop

# Case when the given integer is composite
composite:

    # Print the corresponding output prompt
    li $v0, 4
    la $a0, output2
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Case when the given integer is prime
prime:

    # Print the corresponding output prompt
    li $v0, 4
    la $a0, output1
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Case when the given integer is <= 10
InvalidInput:

    # Print the corresponding output prompt, asking user to input >= 10
    li $v0, 4
    la $a0, sanityCheck
    syscall

    # Exit the program
    li $v0, 10
    syscall
