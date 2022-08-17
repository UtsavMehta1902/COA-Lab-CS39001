# Assignment - 2
# Problem - 1
# Semester - 5 (autumn 2022-2023)
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)

# This programs takes 2 input integers, check their ranges, and
# multiplies them according to Booth's Multiplication Algorithm.

.globl main

.data

# Various strings useful for interacting with the user, stored in the RAM.

prompt1:
    .asciiz "Enter first number: "                             # Asks for first input integer
prompt2: 
    .asciiz "Enter second number: "                            # Asks for second input integer
sanityCheck: 
    .asciiz "Please enter a 16-bit signed integer."            # Prompt to ask user for 16-bit signed integer input
output: 
    .asciiz "Product of the two numbers are: "                 # Prompt to print the finally computed product
newline: 
    .asciiz "\n"                                               # To print newline for better line-spacing

.text

# main program
# program variables:
# a (first input integer):      $a0 (multiplier - Q)
# b (second input integer):     $a1 (multiplicand - M)
# resultant product:            $v0 

main:

    # Values used for checking input integer range
    li $s2, 32767                   # upper-bound of 16-bit signed integer range 
    li $s3, -32768                  # lower-bound of 16-bit signed integer range

    li $v0, 4                       # Load 4 in $v0, to specify string printing operation
    la $a0, prompt1                 # Ask the user to enter first positive integer
    syscall

    li $v0, 5                       # Load 5 in $v0, to specify integer scanning operation
    syscall

    move $s0, $v0                   # Store the first integer in $s0

    # Check if the integer is within the 16-bit range
    bgt $s0,$s2,InvalidInput
    blt $s0,$s3,InvalidInput
    
    li $v0, 4                       # Load 4 in $v0, to specify string printing operation
    la $a0, prompt2                 # Ask the user to enter second positive integer
    syscall

    li $v0, 5                       # Load 5 in $v0, to specify integer scanning operation
    syscall

    move $s1, $v0                   # Store the second integer in $s1

    # Check if the integer is within the 16-bit range
    bgt $s1,$s2,InvalidInput
    blt $s1,$s3,InvalidInput

    move $a0, $s0                   # Store the first integer (multiplicand) in $a0
    move $a1, $s1                   # Store the second integer (multiplier) in $a1

    b multiply_booth                # Call multiply_booth
    

# If the user provides an integer beyond the 16-bit signed range :-
InvalidInput:

    li $v0, 4                       # Load 4 in $v0, to specify string printing operation
    la $a0, sanityCheck             # Print the prompt to ask user for 16-bit signed integer input
    syscall

    li $v0, 4                       # Load 4 in $v0, to specify string printing operation
    la $a0, newline                 # Print a newline for better line-spacing
    syscall
  
    li $v0, 4                       # Load 4 in $v0, to specify string printing operation
    la $a0, newline                 # Print a newline for better line-spacing
    syscall

    b main                          # Branch back to main to continue the program

# To multiply the input integers provided :-
multiply_booth:

    # Shifting the 'sign' bit(32nd bit) to 16th bit, to convert a 32 bit integer to 16 bit integer

    srl $s0, $a0, 31                # Right shifting $a0 to get the 32nd-bit (MSB)                                                  
    sll $s0, $s0, 15                # Left shifting 32nd bit to 16th bit position                                   

    sll $a0, $a0, 17                # Left shifting $a0 by 17 bits to make 1st 17 bits equal to 0              
    srl $a0, $a0, 17                # Right shifting $a0 to get the first 17 bits equal to 0                     

    add $a0, $a0, $s0               # Adding back the 'sign' bit at 16th bit position                           

    # Shifting the 'sign' bit(32nd bit) to 16th bit, to convert a 32 bit integer to 16 bit integer

    srl $s0, $a1, 31                # Right shifting $a1 to get the 32nd-bit (MSB)                                                                             
    sll $s0, $s0, 15                # Left shifting 32nd bit to 16th bit position                                                                   

    sll $a1, $a1, 17                # Left shifting $a1 by 17 bits to make 1st 17 bits equal to 0                                              
    srl $a1, $a1, 17                # Right shifting $a1 to get the first 17 bits equal to 0                                                     

    add $a1, $a1, $s0               # Adding back the 'sign' bit at 16th bit position                           

    sll $a1, $a1, 16                # Left shifting the multiplicand by 16 bits,
                                    # to get it's set-bits in first 16 positions

    li $t0, 16                      # $t0 is an iterator, initialized to 16
    li $t1, 0                       # $t1 is the previous bit( Q_(-1) ), intialized to 0
    move $v0, $a0                   # $v0 has the output, initialized to $a0 (Multiplier)

    for:
        beq $t0, 0, print_output    # Branch to print the output once the iterator becomes 0
        sub $t0, $t0, 1             # Decrement the iterator by 1 ( it -- )

        # To calculate the value of Q_(0) Q_(-1) :-

        and $t2, $a0, 1             # Get the LSB of $a0 in $t2
        sll $t2, $t2, 1             # Left shift $t2 by 1 to get the LSB at 2nd-bit
        add $t2, $t2, $t1           # Add the previous LSB of $a0 to get Q_(0) Q_(-1)

        and $t1, $a0, 1             # Update the previous LSB to the current LSB

        srl $a0, $a0, 1             # Right shift $a0 by 1

        beq $t2, 2, substraction    # If Q_(0) Q_(-1) equals 2, then branch to substraction
        beq $t2, 1, addition        # If Q_(0) Q_(-1) equals 1, then branch to addition

        b right_shift               # Else, branch to right_shift
    
    # Case when Q_(0) Q_(-1) equals 01 :-
    addition:
        add $v0, $v0, $a1           # Add $a1 to the output ($v0)
        b right_shift               # Branch to right_shift

    # Case when Q_(0) Q_(-1) equals 10 :-
    substraction:
        sub $v0, $v0, $a1           # Substract $a1 to the output ($v0)
        b right_shift               # Branch to right_shift

    # To perform the arithmetic right shift operation on the product
    right_shift:

        # Store the MSB (32nd bit) of current product :-
        li $t3, 1                   # Initilize $t3 to 1
        sll $t3, $t3, 31            # Left shift $t3 by 31 bits
        and $t3, $t3, $v0           # Store the MSB in $t3

        srl $v0, $v0, 1             # Perform the arithmetic right shift operation

        add $v0, $v0, $t3           # Add the MSB back to the 32nd position

        b for                       # Branch back to the for loop

# To print the product of two integers :-
print_output:

    move $s0, $v0                   # Move the output to $s0 as $v0

    li $v0, 4                       # Load 4 in $v0, to specify string printing operation
    la $a0, newline                 # Print a newline for better line-spacing
    syscall

    li $v0, 4                       # Load 4 in $v0, to specify string printing operation
    la $a0, output                  # Print the output statement
    syscall

    li $v0, 1                       # Load 1 in $v0, to specify integer printing operation
    move $a0,$s0                    # Move the product of two numbers to $a0
    syscall

    li $v0, 10                      # Load 10 in $v0, to specify exit operation
    syscall