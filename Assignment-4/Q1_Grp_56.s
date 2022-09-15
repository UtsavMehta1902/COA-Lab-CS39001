# Assignment - 4
# Problem - 1
# Semester - 5 (autumn 2022-2023)
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)


# This programs takes 4 input integers (n, a, r, m), and constructs an m*n matrix(A),
# with row major form in Geometric Progression with parameters (a and r).
# Also, it computes the determinant of the computed matrix and prints it.

.globl main

.data

# Various strings useful for interacting with the user.

prompt1:                                                # Asks user to input m (row count)
    .asciiz "Enter first positive integer (n): "
prompt2:                                                # Asks user to input n (column count)
    .asciiz "Enter second positive integer (a): "
prompt3:                                                # Asks user to input a (first term) -
    .asciiz "Enter third positive integer (r): "
prompt4:                                                # Asks user to input r (common ratio)-
    .asciiz "Enter fourth positive integer (m): "
output1:                                                # Prompt to print the output - A
    .asciiz "Array A is - "                             
output2:                                                # Prompt to print the determinant of A
    .asciiz "Final determinant of the matrix A is " 
sanityCheck:                                            # Error message for invalid input     
    .asciiz "Please enter positive numbers only.\n"                           
newline:                                                # To print newline for better line-spacing
    .asciiz "\n"                            
whitespace:                                             # To print whitespace for better character-spacing
    .asciiz " "

.text

# Main function
# 0($s0) is $fp
# -4($s0) is n
# -8($s0) is a
# -12($s0) is r
# -16($s0) is m

InvalidInput:
    li $v0, 4                                     # Load 4 in $v0, to specify string printing operation
    la $a0, sanityCheck                           # Print the prompt to ask for valid input (positive integers only)
    syscall

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, newline                             # Load newline literal, for better spacing
    syscall  

# Function to initialize the stack :-
initStack:
    addi    $sp, $sp, -4                          # Decrement stack pointer by 4
    sw      $fp, 0($sp)                           # Store $fp in stack
    move    $fp, $sp                              # Make $fp point to current stack top before program execution
    jr      $ra                                   # jump to return address

# Function to push elements to the stack :-
pushToStack:
    subu    $sp, $sp, 4                           # $sp <-- $sp - 4, make space for pushing value
    sw      $a0, 0($sp)                           # Store the value in $a0
    jr      $ra                                   # Return to the caller function

# Function to allocate memory for matrices :-
mallocInStack:
    mul     $a0, $a0, 4                           # $a0 stores n*m, hence space required = 4*n*m
    sub     $v0, $sp, 4                           # Store the stack pointer in $v0 (return value)
    subu    $sp, $sp, $a0                         # Allocate space for n*m elements, $sp <-- $sp - $a0
    jr $ra                                        # Return to the caller function

main:
    jal initStack                                 # Initialize the stack 
    move    $s0, $sp                              # save stack pointer in $s0, $s0 stores address of $fp

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt1                             # Print the prompt to ask for first dimension
    syscall                                     

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $a0, $v0                              # Store the value n in $s0

    ble $a0, 0, InvalidInput                      # If first dimension is less than 0, branch to InvalidInput

    jal pushToStack                               # Call the pushToStack function to store $s0

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt2                             # Print the prompt to ask for first term of G.P.
    syscall                                         

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $s2, $v0                              # Store the first term in $s2

    ble $s2, 0, InvalidInput                      # If first term of G.P. is less than 0, branch to InvalidInput

    move    $a0, $s2                              # Store the first term in $a0, to pass to pushToStack function 
    jal pushToStack                               # Call the pushToStack function to store $s2

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt3                             # Print the prompt to ask for common ratio of G.P.
    syscall                                     

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $s3, $v0                              # Store the common ratio in $s3 

    ble $s3, 0, InvalidInput                      # If common ratio of G.P. is less than 0, branch to InvalidInput

    move    $a0, $s3                              # Store the common ratio in $a0, to pass to pushToStack function
    jal pushToStack                               # Call the pushToStack function to store $s3

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, prompt4                             # Print the prompt to ask for the modulo m.
    syscall                                     

    li   $v0, 5                                   # Load 5 in $v0, to specify integer scanning operation
    syscall                                     
    move    $s4, $v0                              # Store the value m in $s4

    ble $s4, 0, InvalidInput                      # If common ratio of G.P. is less than 0, branch to InvalidInput

    move    $a0, $s4                              # Store the value n in $a0, to pass to pushToStack function
    jal pushToStack                               # Call the pushToStack function to store $s4

    mul $a0, $s0, $s1                             # Store the product n*n in $a0, to pass to mallocInStack function
    jal mallocInStack                             # Call the mallocInStack function to allocate space for A
    move $s5, $v0                                 # Store the returned stack base pointer in $s5

    lw      $t0, -4($s0)                          # $t0 stores the value n
    mul     $a0, $t0, $t0                         # $a0 stores the value n*n
    jal     mallocInStack                         # call mallocInStack function and pass n*n as a function
    move    $s1, $v0                              # $s1 stores the return value from mallocInStack function, the stack pointer

for_MatrixA_row:
    move    $t5, $s1                              # $t5 stores the address of the first element of matrix A
    lw      $t0, -4($s0)                          # $t0 stores the value n
    li      $t2, 0                                # $t2 is the iterator, initialized to 0
    lw      $t3, -8($s0)                          # $t3 stores the value a
    lw      $t4, -12($s0)                         # $t4 stores the value r
    lw      $t6, -16($s0)                         # $t6 stores the value m
    div     $t3, $t6                              # divides a by m, register HI stores the remainder
    mfhi    $t3                                   # move the remainder of a%m to $t3
    mul     $t1, $t0, $t0                         # $t1 stores the value of n*n

    for_MatrixA_col:
        bge     $t2, $t1, endfor_MatrixA_row      # if iterator goes beyond n*n, exit and branch to endfor_MatrixA_row
        addi    $t2, 1                            # increment the iterator
        sw      $t3, 0($t5)                       # store the value pointed by the matrix pointer $t5, in $t3
        addi    $t5, -4                           # decrement the value in $t5 by 4, to point to the next element
        mul     $t3, $t3, $t4                     # multiply the value in $t3 by r, to get the next term of geometric progression
        div     $t3, $t6                          # divides $t3 by m, register HI stores the remainder
        mfhi    $t3                               # move the remainder of ($t3)%m to $t3
        j for_MatrixA_col                         # jump to for_MatrixA_col

endfor_MatrixA_row:  
    li      $v0, 4                                # Load 4 in $v0, to specify string printing operation
    la      $a0, output1                          # Print the prompt to specify output printing operation
    syscall                                     

    li   $v0, 4                                   # Load 4 in $v0, to specify string printing operation
    la   $a0, newline                             # Load newline literal, for better spacing
    syscall    

    move    $a0, $t0                              # $a0 stores the value n
    move    $a1, $s1                              # $a1 stores the address of the first element of matrix A
    jal     printMatrix                           # call the printMatrix function to print the matrix A

Get_Determinant_of_A:
    move    $a0, $t0                              # $a0 stores the value n
    move  $a1, $s1                                # $a1 stores the address of the first element of matrix A
    jal   Compute_Determinant                     # call the Compute_Determinant function to compute the determinant of matrix A

    move $s6, $v0                                 # Store the value of determinant in $s6

    li $v0, 4                                     # Load 4 in $v0, to specify string printing operation
    la $a0, output2                               # Print the prompt specifying the determinant of A    
    syscall

    li $v0, 1                                     # Load 1 in $v0, to specify integer printing operation
    move $a0, $s6                                 # Store the determinant in $a0
    syscall

    li $v0, 10                                    # Load 10 in $v0, to specify exit operation
    syscall

# Function to print a matrix
printMatrix:
    move    $t0, $a0                              # Move the first dimension to $t0
    move    $t1, $a0                              # Move the first dimension to $t1
    move    $t2, $a1                              # Move the stack pointer (to Matrix) to $t2
    li      $t3, 0                                # Iterator - 1, initialized to 0
    
    for_print_row: 
        beq $t3, $t0, endfor_print_row            # If iterator-1 == first dimension (n), branch to endfor_print_row
        add $t3, $t3, 1                           # Add 1 to the iterator-1
        li $t4, 0                                 # Iterator-2, initialized to 0

        for_print_col:
            beq $t4, $t1, endfor_print_col        # If iterator-2 == second dimension (n), branch to endfor_print_col
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

# recursive determinant function
Compute_Determinant:
    move    $s0, $ra                              # Store the return address in $s0
    move    $t1, $a0                              # $t1 stores the value n
    jal     pushToStack                           # push n to the stack
    
    move    $a0, $a1                              # $a0 stores the value of first element of matrrix A
    jal     pushToStack                           # push A* to stack
    
    move    $a0, $s0                              # Move the return address storedin $s0, to $a0
    jal     pushToStack                           # Push the return address to the stack
    
    bne     $t1, 1, not_base_case                 # Check for base-case, when n=1

    lw      $t0, 4($sp)                           # $t0 stores the pointer in stack to the single element of A
    lw      $v0, 0($t0)                           # $v0 stores the value dereferenced from $t0
    lw      $ra, 0($sp)                           # $ra stores the return address, which was previously pushed to the stack
    addi    $sp, $sp, 12                          # Pop the stack by 12 bytes
    jr      $ra                                   # Return to the caller function

not_base_case:
    
    li      $t0, 0                                # $t0 stores the loop iterator, iterator(j) of the first-row, initialized to 0
    lw      $t2, 8($sp)                           # $t2 stores the value n

    li      $v0, 0                                # stores the computed value of the determinant, initialized to 0
    move    $a0, $v0                              # $a0 stores the vlaue in $v0
    jal     pushToStack                           # push $a0 to stack
    
    li      $a0, 1                                # Load the value 1 in $a0, $a0 is basically the sign of the column of row-1
    jal     pushToStack                           # Push the sign to the stack

    for_row1_A: 
        
        beq     $t0, $t2, endfor_row1_A                 # check if j reaches end of columns(n) and branch to endfor_row1_A
        
        move    $a0, $t0                                # $a0 stores the value of iterator(j)
        jal     pushToStack                             # push the value of iterator(j) to the stack

        lw      $t7, 16($sp)                            # $t7 stores the pointer to first element of A
        lw      $t6, 0($sp)                             # $t6 stores the value of iterator(j)
        
        move    $t1, $t2                                # Store the value of n in $t1
        
        addi    $t1, $t1, -1                            # $t1 now holds the value of n-1
        mul     $t1, $t1, $t1                           # $t1 now holds the value of (n-1)*(n-1)
        
        move    $a0, $t1                                # $a0 holds the value of (n-1)*(n-1)
        jal     mallocInStack                           # Call mallocInStack to allocated memory for the new matrix

        move    $t1, $v0                                # $t1 stores address of first element of new matrix A'
        move    $t0, $t2                                # $t0 store the value of n
        
        sub     $t8, $zero, 4                           #t8 stores the value -4
        mul     $t8, $t8, $t0                           # $t8 stores the value of the product -4*n
        add     $t7, $t7, $t8                           # $t7 points the first element of the second row of A

        li      $t2, 1                                  # Stores the interator to row

        for_row_A:
            beq     $t2, $t0, endfor_row_A              # Check if iterator(i) reaches end of rows(n) and branch to endfor_row_A
            li    $t3, 0                                # Stores the iterator to column

            for_col_A:
                beq     $t3, $t0, endfor_col_A          # Check if iterator of columns reaches end of columns(n) and branch to endfor_col_A
                beq     $t6, $t3, skip_col_A            # Check if iterator of columns is equal to iterator(j) and branch to skip_col_A
                
                lw      $t4, 0($t7)                     # $t4 stores the value of A[i][j]
                sw      $t4, 0($t1)                     # Store the value of A[i][j] in A'[i'][j']
                addi    $t1, $t1, -4                    # $t1 points to next memory space of A'
                addi    $t7, $t7, -4                    # $t7 points to next memory space of A
                b next_col_A                            # Branch to next_col_A

            skip_col_A:
                addi    $t7, $t7, -4                    # $t7 points to next memory space of A
                
            next_col_A:
                addi $t3, $t3, 1                        # Increment the iterator of columns
                b for_col_A                             # Branch to for_col_A

            endfor_col_A:
                addi    $t2, $t2, 1                     # Increment the iterator of rows
                j       for_row_A                       # Branch to for_row_A

        endfor_row_A:
            addi    $t0, $t0, -1                        # $t0 stores the value of n-1
            move    $a0, $t0                            # $a0 stores the value of n-1
            jal     pushToStack                         # push $a0 to stack, to store for future use
            
            move    $a0, $t0                            # $a0 stores the value of n-1
            move    $a1, $v0                            # $a1 stores the address of first element of A'
            jal     Compute_Determinant                 # Call Compute_Determinant recursively to compute the determinant of A'

            lw      $t0, 0($sp)                         # $t0 stores the value n-1
            move    $t2, $t0                            # $t2 stores the value n-1
                        
            addi    $sp, $sp, 4                         # Pop the stack by 4 bytes
            mul     $t0, $t0, $t0                       # $t0 stores the value of (n-1)*(n-1)
            mul     $t0, $t0, 4                         # $t0 stores the value of 4*(n-1)*(n-1)
            
            add     $sp, $sp, $t0                       # Pop the matrix A' from the stack
            
            lw      $t0, 0($sp)                         # $t0 stores the value of loop iterator(j)
            addi    $sp, $sp, 4                         # Pop the stack by 4 bytes
            
            lw      $t1, 0($sp)                         # Load the sign back from the stack
            addi    $sp, $sp, 4                         # Pop the stack by 4 bytes

            lw      $t3, 0($sp)                         # Load the value of determinant back from the stack
            addi    $sp, $sp, 4                         # Pop the stack by 4 bytes
            
            mul     $t4, $v0, $t1                       # $t4 stores the value of sign*(recursively computed determinant)
            
            move    $t6, $t0                            # $t6 stores the value of iterator(j)
            mul     $t6, $t6, -4                        # $t6 stores the value of -4*iterator(j)
 
            lw      $t5, 4($sp)                         # $t5 stores the address of first element of A
            add     $t5, $t5, $t6                       # $t5 stores the address of the jth column of first row of A
            lw      $t5, 0($t5)                         # $t5 stores the value of A[0][j]
            mul     $t4, $t4, $t5                       # $t4 stores the value of sign*(recursively computed determinant)*A[0][j]
            add     $t4, $t4, $t3                       # $t4 stores the value of sign*(recursively computed determinant)*A[0][j] + determinant
                                                        # hence, the updated value of determinant

            mul     $t1, $t1, -1                        # $t1 stores the value of -1*sign
 
            move    $a0, $t4                            # $a0 stores the value of determinant
            jal     pushToStack                         # push $a0 to stack, to store for future use
            
            move    $a0, $t1                            # $a0 stores the computed value of -1*sign
            jal     pushToStack                         # push $a0 to stack, to store for future use
            
            addi    $t2, $t2, 1                         # Increment the value n-1 to n
            addi    $t0, $t0, 1                         # Increment the iterator of columns (j)
            j       for_row1_A                          # Branch to for_row1_A

    endfor_row1_A:
        lw      $v0, 4($sp)                             # $v0 stores the value of Determinant 
        addi    $sp, $sp, 4                             # Pop the stack by 4 bytes

        lw      $ra, 4($sp)                             # $ra stores the return address
        addi    $sp, $sp, 4                             # Pop the stack by 4 bytes

        addi    $sp, $sp, 12                            # Pop the stack by 12 bytes
        jr      $ra                                     # Jump back to the caller function
