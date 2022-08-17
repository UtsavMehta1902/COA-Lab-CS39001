# Assignment - 2
# Problem - 3
# Semester - 5 (autumn 2022-2023)
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)

# This programs takes 4 input integers (m, n, a, r), and constructs an m*n matrix(A),
# with row major form in Geometric Progression with parameters (a and r).
# Also, it constructs the transpose of matrix A as matrix B,
# and prints both the matrices as the output.

.globl main

.data

# Various strings useful for interacting with the user.

prompt1:                                                # Asks user to input m (row count)
    .asciiz "Enter first positive integer (m): "
prompt2:                                                # Asks user to input n (column count)
    .asciiz "Enter second positive integer (n): "
prompt3:                                                # Asks user to input a (first term) -
    .asciiz "Enter third positive integer (a): "
prompt4:                                                # Asks user to input r (common ratio)-
    .asciiz "Enter fourth positive integer (r): "
output1:                                                # Prompt to print the output - A
    .asciiz "Array A is - "                             
output2:                                                # Prompt to print the output - B
    .asciiz "Array B is - " 
sanityCheck:                                            # Error message for invalid input     
    .asciiz "Please enter positive numbers only.\n"                           
newline:                                                # To print newline for better line-spacing
    .asciiz "\n"                            
whitespace:                                             # To print whitespace for better character-spacing
    .asciiz " "

.text

# main program
# program variables:
# m (first input integer):    $s0
# n (second input integer):   $s1
# a (third input integer):    $s2
# r (fourth input integer):   $s3
# stack pointer               $sp
# frame pointer               $fp
# position of A on stack:     $s4
# position of B on stack:     $s5

# Function to initialize the stack :-
initStack:
    subu    $sp, $sp, 32                          # Create a 32-byte long stack frame
    sw      $ra, 20($sp)                          # Store the return address
    sw      $fp, 16($sp)                          # Store the frame pointer ($fp)
    addiu   $fp, $sp, 28                          # Set the frame pointer ($sp)
    jr      $ra                                   # Return to the caller function

# Function to push elements to the stack :-
pushToStack:
    subu    $sp, $sp, 4                           # $sp <-- $sp - 4, make space for pushing value
    sw      $a0, 0($sp)                           # Store the value in $a0
    jr      $ra                                   # Return to the caller function

# Function to allocate memory for matrices :-
mallocInStack:
    mul     $a0, $a0, 4                           # $a0 stores n*m, hence space required = 4*n*m
    move    $v0, $sp                              # Store the stack pointer in $v0 (return value)
    subu    $sp, $sp, $a0                         # Allocate space for n*m elements, $sp <-- $sp - $a0
    jr $ra                                        # Return to the caller function

# Function to the print the matrix :-
printMatrix:
    move $t0, $a0                                 # Move the first dimension to $t0
    move $t1, $a1                                 # Move the second dimension to $t1
    move $t2, $a2                                 # Move the stack pointer (to Matrix) to $t2
    li $t3, 0                                     # Iterator - 1, initialized to 0

    for_print_row: 
        beq $t3, $t0, endfor_print_row            # If iterator-1 == first dimension, branch to endfor_print_row
        add $t3, $t3, 1                           # Add 1 to the iterator-1
        li $t4, 0                                 # Iterator-2, initialized to 0

        for_print_col:
            beq $t4, $t1, endfor_print_col        # If iterator-2 == second dimension, branch to endfor_print_col
            add $t4, $t4, 1                       # Add 1 to the iterator-2
            addi $t2, $t2, -4                     # Shift the stack pointer to point to next memory space ( A[i][j] )

            lw $a0, 4($t2)                        # Load the value in memory space, to print it
            li $v0, 1                             # Load 1 in $v0, to specify integer printing operation
            syscall

            li $v0, 4                             # Load 4 in $v0, to specify string printing operation
            la $a0, whitespace                    # Load whitespace literal, for better spacing
            syscall

            b for_print_col                       # Branch back to for_print_col

        endfor_print_col:                         
            li $v0, 4                             # Load 4 in $v0, to specify string printing operation
            la $a0, newline                       # Load newline literal, for better spacing
            syscall

            b for_print_row                       # Branch back to for_print_row
    
    endfor_print_row:   
        jr $ra                                    # Return to the caller function

# Function to find the transpose matrix of any matrix A :-
transposeMatrix:
    move $t0, $a0                                 # Move the first dimension in $a0, to $t0
    move $t1, $a1                                 # Move the second dimension in $a1, to $t1
    move $t2, $a2                                 # Move the source stack pointer in $a2, to $t2
    move $t3, $a3                                 # Move the destination stack pointer in $a3, to $t3
    li $t4, 0                                     # Iterator - 1, intialized to 0

    for_transpose_row:
        beq $t4, $t0, endfor_transpose_row        # If iterator-1 == first dimension, branch to endfor_transpose_row
        li $t5, 0                                 # Iterator - 2, intialized to 0

        for_transpose_col:
            beq $t5, $t1, endfor_transpose_col    # If iterator-2 == second dimension, branch to endfor_transpose_col

            addi $t2, $t2, -4                     # Decrement the source stack pointer to get next element
            lw  $t7, 4($t2)                       # Load the value in $t2 ( A[i][j] ) to $t7

            mul $t6, $t5, $a0                     # Store the product j*m in $t6, $t6 <-- j*m 
            add $t6, $t6, $t4                     # Add i to the product of j*m, $t6 <-- j*m + i
            mul $t6, $t6, -4                      # Multiply $t6 by -4 to get corresponding memory location offset
            sub $t6, $t6, 4                       # Substract 4 from that memory location ( B[j][i] )
            add $t6, $t3, $t6                     # Add this memory location offset to stack pointer $t3
            
            addi $t5, $t5, 1                      # Add 1 to iterator-2
            sw  $t7, 4($t6)                       # Store the value in A[i][j] in B[j][i]

            b for_transpose_col                   # Branch back to for_transpose_col

        endfor_transpose_col:
            addi $t4, $t4, 1                      # Add 1 to iterator-1
            b for_transpose_row                   # Branch back to for_transpose_row
            
    endfor_transpose_row:
        jr $ra                                    # Return to the caller function 

main:
    jal initStack                                 # Initialize the stack 

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt1                             # Print the prompt to ask for first dimension
    syscall                                     

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $s0, $v0                              # Store the first dimension in $s0

    ble $s0, 0, InvalidInput                      # If first dimension is less than 0, branch to InvalidInput

    move    $a0, $s0                              # Store the first dimension in $a0, to pass to pushToStack function 
    jal pushToStack                               # Call the pushToStack function to store $s0

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt2                             # Print the prompt to ask for second dimension
    syscall

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $s1, $v0                              # Store the second dimension in $s1

    ble $s1, 0, InvalidInput                      # If second dimension is less than 0, branch to InvalidInput

    move    $a0, $s1                              # Store the second dimension in $a0, to pass to pushToStack function 
    jal pushToStack                               # Call the pushToStack function to store $s1

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt3                             # Print the prompt to ask for first term of G.P.
    syscall                                         

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $s2, $v0                              # Store the first term in $s2

    ble $s2, 0, InvalidInput                      # If first term of G.P. is less than 0, branch to InvalidInput

    move    $a0, $s2                              # Store the first term in $a0, to pass to pushToStack function 
    jal pushToStack                               # Call the pushToStack function to store $s2

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt4                             # Print the prompt to ask for common ratio of G.P.
    syscall                                     

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $s3, $v0                              # Store the common ratio in $s3 

    ble $s3, 0, InvalidInput                      # If common ratio of G.P. is less than 0, branch to InvalidInput

    move    $a0, $s3                              # Store the common ratio in $a0, to pass to pushToStack function
    jal pushToStack                               # Call the pushToStack function to store $s3

    mul $a0, $s0, $s1                             # Store the product n*m in $a0, to pass to mallocInStack function
    jal mallocInStack                             # Call the mallocInStack function to allocate space for A
    move $s4, $v0                                 # Store the returned stack base pointer in $s4

    mul $a0, $s0, $s1                             # Store the product n*m in $a0, to pass to mallocInStack function
    jal mallocInStack                             # Call the mallocInStack function to allocate space for B
    move $s5, $v0                                 # Store the returned stack base pointer in $s5

    li $t0, 0                                     # Iterator - 1, initialized to 0
    move $t2, $s4                                 # Move the matrix A pointer in $t2

for_MatrixA_row:
    beq $t0, $s0, endfor_MatrixA_row              # If iterator-1 == first dimension, branch to endfor_MatrixA_row
    addi $t0, $t0, 1                              # Add 1 to the iterator-1
    li $t1, 0                                     # Iterator - 2, intialized to 0

    for_MatrixA_col:                              
        beq $t1, $s1, for_MatrixA_row             # If iterator-1 == second dimension, branch to for_MatrixA_row
        addi $t2, $t2, -4                         # Shift the stack pointer to next memory space ( A[i][j] )
        sw $s2, 4($t2)                            # Store the value in $s2 in A[i][j]
        mul $s2, $s2, $s3                         # Multiply the current term with common ratio to get next term
        
        addi $t1, $t1, 1                          # Add 1 to the iterator-2
        b for_MatrixA_col                         # Branch back to for_MatrixA_col
    
endfor_MatrixA_row:
    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, output1                             # Print the prompt specifying the print of Matrix-A
    syscall             

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, newline                             # Load newline literal, for better spacing
    syscall                                    

    move $a0, $s0                                 # Store the first dimension in $a0, to pass to printMatrix function
    move $a1, $s1                                 # Store the second dimension in $a1, to pass to printMatrix function
    move $a2, $s4                                 # Store the matrix-A stack base pointer in $a2, to pass to printMatrix function

    jal printMatrix                               # Call the printMatrix function to print Matrix-A

    move $a0, $s0                                 # Store the first dimension in $a0, to pass to transposeMatrix function
    move $a3, $s5                                 # Store the matrix-B memory pointer in $a3
    jal transposeMatrix                           # Calculate the transpose of matrix A and store in matrix B

    li $v0, 4                                     # Load 4 in $v0, to specify string printing operation
    la $a0, output2                               # Print the prompt specifying the print of Matrix-B
    syscall

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, newline                             # Load newline literal, for better spacing
    syscall          

    move $a0, $s1                                 # Store the second dimension in $a0, to pass to printMatrix function
    move $a1, $s0                                 # Store the first dimension in $a1, to pass to printMatrix function
    move $a2, $s5                                 # Store the matrix-B stack base pointer in $a2, to pass to printMatrix function

    jal printMatrix                               # Call the printMatrix function to print Matrix-B

    li $v0, 10                                    # Load 10 in $v0, to specify exit operation
    syscall

InvalidInput:
    li $v0, 4                                     # Load 4 in $v0, to specify string printing operation
    la $a0, sanityCheck                           # Print the prompt to ask for valid input (positive integers only)
    syscall

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, newline                             # Load newline literal, for better spacing
    syscall  

    b main                                        # Branch back to main