# Assignment - 4
# Problem - 2
# Semester - 5 (autumn 2022-2023)
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)

# This programs takes 10 input integers and stores them in an array,
# then it sorts the array in ascending order and prints the sorted array.

.globl main

.data

# Various strings useful for interacting with the user.
prompt_arr:                                         # Asks the user to provide 10 input intergers
    .asciiz "Enter an array of 10 numbers: \n"

comma:                                              # Used to print a comma after each number
    .asciiz ", "

newline:                                            # To print newline for better line-spacing
    .asciiz "\n"

out_arr:                                            # To print the sorted array
    .asciiz "Sorted Array: "

array:                                              # Allocate Space for 40 bytes = 10 numbers
    .align 2
    .space 40

len:                                                # Size of array
    .word 10

.text

main:

# Asks user to input 10 integers to populate the array
input1:

    li      $v0,            4                           # Load 4 in $v0, to specify string printing operation
    la      $a0,            prompt_arr                  # Print the prompt to ask for 10 input integers
    syscall 

    la      $s0,            array                       # Load address of array in $s0
    lw      $s1,            len                         # Load length of array in $s1
    li      $s2,            0                           # $s2 = 0, iterator over the array

# Read an array of 10 numbers
read_arr:

    beq     $s2,            $s1,        call_sort       # If iterator reaches the value 10, branch to call_sort function

    li      $v0,            5                           # Load 5 in $v0, to specify integer input operation
    syscall     

    sw      $v0,            0($s0)                      # $s0 points to the location in array, where the next integer is supposed to be stored
    addi    $s0,            $s0,        4               # Increment $s0 by 4, to point to the next location in array
    addi    $s2,            $s2,        1               # Increment $s2 by 1, to increment the iterator

    j       read_arr                                    # Jump to read_arr to read the next integer

# Call the recursive sorting function, with appropiate parameters
call_sort:

    la      $a0,            array                       # Load address of array in $a0
    li      $a1,            0                           # Load 0 in $a1, to specify the starting index of the array
    li      $a2,            9                           # Load 9 in $a2, to specify the last index of the array

    jal     recursive_sort                              # Call the recursive_sort function

    j       print_arr                                   # Jump to print_arr to print the sorted array

# Print the sorted array
print_arr:

    li      $v0,            4                           # Load 4 in $v0, to specify string printing operation
    la      $a0,            out_arr                     # Print the prompt to print the sorted input integers
    syscall 

    la      $s0,            array                       # Load address of array in $s0
    lw      $s1,            len                         # Load length of array in $s1
    li      $s2,            0                           # $s2 = 0, iterator over the array

# Loop to Print the sorted array
print_arr_loop:

    beq     $s2,            $s1,        exit            # If iterator reaches the value 10, branch to exit

    lw      $a0,            0($s0)                      # Load the next number from the array
    li      $v0,            1                           # Load 1 in $v0, to specify integer printing operation
    syscall 

    li      $v0,            4                           # Load 4 in $v0, to specify string printing operation
    la      $a0,            comma                       # Print a comma after each number
    syscall 

    addi    $s0,            $s0,        4               # Increment pointer of $s0 to next position in the array
    addi    $s2,            $s2,        1               # Increment $s2 by 1, to increment the iterator

    j       print_arr_loop                              # Jump to print_arr_loop to print the next number

exit:                                                   # Exit the program 
    li      $v0,            10                          # Load 10 in $v0, to specify exit operation
    syscall 

# Function to swap to two numbers
swap:                                                   # swap(&a,&b)
    lw      $t0,            0($a0)                      # Load the value of a in $t0
    lw      $t1,            0($a1)                      # Load the value of b in $t1

    move    $t2,            $t0                         # Store the value of a in $t2
    move    $t0,            $t1                         # Store the value of b in $t0
    move    $t1,            $t2                         # Store the value of a in $t1

    sw      $t0,            0($a0)                      # Store the value of b in a
    sw      $t1,            0($a1)                      # Store the value of a in b

    jr      $ra                                         # Return to the caller

# Function to sort the array in ascending order
recursive_sort:

    addi    $sp,            $sp,        -20             # Allocate space for 5 registers on the stack
    sw      $a1,            16($sp)                     # Store the value of $a1 in the stack, $a1 is the left or low pointer
    sw      $a2,            12($sp)                     # Store the value of $a2 in the stack, $a2 is the right or high pointer
    sw      $ra,            8($sp)                      # Store the return address in the stack
    sw      $s1,            4($sp)                     
    sw      $s2,            0($sp)

    move    $s0,            $a0                         # Store the value of $a0 in $s0, $a0 is the array

    add     $t9,            $zero,      $zero           # $t9 = 0+0 = 0

    lw      $s1,            16($sp)                     # Load the value of $a1 in $s1, $a1 is the left or low pointer
    lw      $s2,            12($sp)                     # Load the value of $a2 in $s2, $a2 is the right or high pointer

while_main:
    bge     $s1,            $s2,        exit_sort       # If left pointer is greater than or equal to right pointer, branch to exit_sort

while_inner_1:

    sll     $t3,            $s1,        2               # The value of 4*l, to be added to the address of array
    add     $t3,            $t3,        $s0             # Get the pointer to the left or low iterator, &A[l]
    lw      $t3,            0($t3)                      # Get the value pointed at the left or low iterator A[l]

    lw      $t4,            16($sp)                     # The left iterator in $t4
    sll     $t5,            $t4,        2               # The value of 4*p, to be added to the address of array
    add     $t5,            $t5,        $s0             # Get the pointer to the right or high iterator, &A[p]
    lw      $t5,            0($t5)                      # Get the value pointed at the right or high iterator A[p]

    bgt     $t3,            $t5,        while_inner_2   # if A[l] > A[p] goto while_inner_2
    lw      $t4,            12($sp)
    bge     $s1,            $t4,        while_inner_2   # if l >= right, goto while_inner_2

    addi    $s1,            $s1,        1               # Increment the left iterator
    j       while_inner_1                               # Jump to while_inner_1 loop

while_inner_2:
    sll     $t4,            $s2,        2               # The value of 4*r, to be added to the address of array
    add     $t4,            $t4,        $s0             # Get the pointer to the right or high iterator, &A[r]
    lw      $t4,            0($t4)                      # Get the value pointed at the right or high iterator A[r]

    lw      $t2,            16($sp)                     # The left iterator in $t2
    sll     $t5,            $t2,        2               # The value of 4*p, to be added to the address of array
    add     $t5,            $t5,        $s0             # Get the pointer to the right or high iterator, &A[p]
    lw      $t5,            0($t5)                      # Get the value pointed at the right or high iterator A[p]

    blt     $t4,            $t5,        while_body      # if A[r] < A[p] goto while_body
    lw      $t4,            16($sp)
    ble     $s2,            $t4,        while_body      # if r <= left goto while_body

    addi    $s2,            $s2,        -1              # Decrement the right (r) by one

    j       while_inner_2                               # Jump to while_inner_2 loop

while_body:

    blt     $s1,            $s2,        while_continue  # if l < r goto while_continue

    lw      $t4,            16($sp)
    sll     $t5,            $t4,        2               # $t5 stores the value of 4*p
    add     $t5,            $t5,        $s0             # $t5 stores the pointer to A[p]

    sll     $t4,            $s2,        2               # $t4 stores the value of 4*r
    add     $t4,            $t4,        $s0             # $t4 stores the pointer to A[r]

    move    $a0,            $t5                         # $a0 now holds the pointer to A[p]
    move    $a1,            $t4                         # $a1 now holds the pointer to A[r]
    jal     swap                                        # swap(&A[p], &A[r])

    move    $a0,            $s0                         # $a0 stores the address of the array A
    lw      $a1,            16($sp)                     # $a1 is the left iterator (l+1)
    addi    $a2,            $s2,        -1              # $a2 is the right iterator (r-1)
    jal     recursive_sort                              # Call the recursion to sort the array to the left

    move    $a0,            $s0                         # $a0 stores the address of the array A
    addi    $a1,            $s2,        1               # $a1 is the left iterator (r+1)
    lw      $a2,            12($sp)                     # $a2 is the right
    jal     recursive_sort                              # Call the recursion to sort the array to the right

    j       exit_sort                                   # jump back to exit_sort

while_continue:

    sll     $t3,            $s1,        2               # $t3 stores the value of 4*l
    add     $t3,            $t3,        $s0             # $t3 stores the pointer to A[l]

    sll     $t4,            $s2,        2               # $t4 stores the value of 4*r
    add     $t4,            $t4,        $s0             # $t4 stores the pointer to A[r]
    move    $a0,            $t3                         # $a0 stores the pointer to A[l]
    move    $a1,            $t4                         # $a1 stores the pointer to A[r]

    jal     swap                                        # Call the swap function with appropiate arguments
    j       while_main                                  # jump back to while_main

exit_sort:

    lw      $ra,            8($sp)                      # Load the return address from the stack
    lw      $s1,            4($sp)                      # Load the value of $s1 from the stack
    lw      $s2,            0($sp)                      # Load the value of $s2 from the stack
    addi    $sp,            $sp,        20              # Increment the stack pointer by 20, to pop the memory off the stack
    jr      $ra                                         # Return to the caller
