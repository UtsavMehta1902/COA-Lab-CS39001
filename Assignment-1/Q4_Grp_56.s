# Assignment - 1
# Problem - 4
# Semester - 5
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)


# This program takes 1 integer as input, checks if it is positive,
# and computes whether it is PERFECT or not.

.globl main

.data

# Various strings useful for interacting with the user.
prompt:
    .asciiz "Enter a positive integer: "
sanityCheck:
    .asciiz "Please enter a positive number."
output1:
    .asciiz "Entered number is a perfect number."
output2:
    .asciiz "Entered number is not a perfect number."
newline:
    .asciiz "\n"

.text

# main program
# program variables:
# n (input integer):	            $s0
# i (iterator, initialized to 2):   $s1
# sum (sum of all factors):         $s2

main:

    # Ask the user to input a positive integer
    li $v0, 4
    la $a0, prompt
    syscall

    # Input the integer (n)
    li $v0, 5
    syscall

    # Store n is $s0
    move $s0,$v0

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # Branch to InvalidInput if the given integer is <= 0
    ble $s0,0,InvalidInput

    # Initialize the iterator to 2
    li $s1, 2

    # Initialize the sum to 1, as one is always a factor
    li $s2, 1

    # Base Case when given integer is 1 (1 is not a perfect number)
    beq $s0,1,isNotPerfect

# Keep looping from 2 to sqrt(n), to find all the factors
for:
    mul $s3,$s1,$s1         # Store i^2 in $s3
    bgt $s3,$s0,endf        # If i^2 goes greater than n, break, and branch to endf
    div $s0,$s1             # Divide n by i => (n/i)
    mfhi $s3                # Move the remainder of division to $s3
    beq $s3,$zero,factor    # If remainder is zero, branch to factor
    add $s1,$s1,1           # Increment the iterator i
    b for                   # Continue the for loop

# Case when the for loop ends
endf:

    # Corner case when n is a perfect square, we would have
    # taken sqrt(n) as a factor twice, in our sum.
    sub $s1,$s1,1           # Substract 1 from i
    mul $s3,$s1,$s1         # Store i^2 in $s3
    beq $s3,$s0,correction  # If i^2 == n, correct the sum, branch to correction.

    beq $s2,$s0,isPerfect       # If the 'sum' is equak to n, number is Perfect. 
    bne $s2,$s0,isNotPerfect    # Else it is not.

    # Exit the program
    li $v0, 10
    syscall

# Case when n was a perfect square, remove the extra sqrt(n), taken into the sum
correction:
    sub $s2,$s2,$s1     # sum -= sqrt(n), as i^2 was equal to n, sqrt(n) = i
    b endf              # Branch back to end of for loop

# This case adds both i and n/i to the sum, if i is a factor of n.
factor:
    add $s2,$s2,$s1     # Add i to the sum
    mflo $s3            # Move the quotient of n/i to $s3
    add $s2,$s2,$s3     # Add the quotient to the sum
    add $s1,$s1,1       # Increment the iterator i
    b for               # Branch back to for loop

# Case when the given number n is not a perfect integer.
isNotPerfect:

    # Print the corresponding output prompt
    li $v0, 4
    la $a0, output2
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Case when the given number n is a perfect integer.
isPerfect:

    # Print the corresponding output prompt
    li $v0, 4
    la $a0, output1
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Case when the given number is not a positive integer.
InvalidInput:

    # Print the corresponding output prompt, asking user to input a positive integer
    li $v0, 4
    la $a0, sanityCheck
    syscall

    # Exit the program
    li $v0, 10
    syscall
