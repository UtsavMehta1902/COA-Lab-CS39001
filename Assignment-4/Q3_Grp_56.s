# Assignment - 4
# Problem - 3
# Semester - 5 (autumn 2022-2023)
# Group No. - 56
# Names of group numbers - Utsav Mehta (20CS10069), Vibhu Yadav (20CS10072)

# This program takes input a array of 10 integers and sorts them in ascending order using a
# recursive sorting algorithm. Then, it takes input a number and searches for it in the sorted
# array using a recursive search algorithm. If the number is found, it prints the index of the
# number in the array (0-based indexing). If the number is not found, it prints -1.

.globl main

.data

prompt_arr:
.asciiz "Enter an array of 10 numbers: "                        # Asks user to input an array of 10 numbers

prompt_n:
.asciiz "Enter the number to be searched: "                     # Asks user to input a number to be searched

found:
.asciiz " is FOUND in the array at index "                      # Prints the output if number is found

not_found:
.asciiz " is NOT FOUND in the array.\n"                         # Prints the output if number is not found

sorted_array:
.asciiz "Sorted Array: "                                        # Prints the sorted array

comma:
.asciiz ", "                                                    # Prints a comma for formatting the output

newline:
.asciiz "\n"                                                    # Prints a newline for formating the output

array:                                                          # Space for 40 bytes = 10 numbers
.align 2
.space 40

len:                                                            # Size of array
.word 10

n:                                                              # Number to tbe searched
.word 0

.text

# Main Function


main:

# Asks user to input 10 integers to populate the array
input1:

    li      $v0,                4                               # Load 4 in $v0, to specify string printing operation
    la      $a0,                prompt_arr                      # Print the prompt to ask for 10 input integers
    syscall 

    la      $s0,                array                           # Load address of array in $s0
    lw      $s1,                len                             # Load length of array in $s1
    li      $s2,                0                               # $s2 = 0, iterator over the array

# Read an array of 10 numbers
read_arr:

    beq     $s2,                $s1,            read_n          # If iterator reaches the value 10, branch to call_sort function

    li      $v0,                5                               # Load 5 in $v0, to specify integer input operation
    syscall 

    sw      $v0,                0($s0)                          # $s0 points to the location in array, where the next integer is supposed to be stored
    addi    $s0,                $s0,            4               # Increment $s0 by 4, to point to the next location in array
    addi    $s2,                $s2,            1               # Increment $s2 by 1, to increment the iterator

    j       read_arr                                            # Jump to read_arr to read the next integer

read_n:

    li      $v0,                4                               # Load 4 in $v0, to specify string printing operation
    la      $a0,                prompt_n                        # Print the prompt asking user to input N
    syscall 

    li      $v0,                5                               # Load 5 in $v0, to specify reading a integer
    syscall 
    sw      $v0,                n                               # save the input in n

# Call the recursive sorting function, with appropiate parameters
call_sort:

    la      $a0,                array                           # Load address of array in $a0
    li      $a1,                0                               # Load 0 in $a1, to specify the starting index of the array
    li      $a2,                9                               # Load 9 in $a2, to specify the last index of the array

    jal     recursive_sort                                      # Call the recursive_sort function

    j       print_arr                                           # Jump to print_arr to print the sorted array

# Print the sorted array
print_arr:

    li      $v0,                4                               # Load 4 in $v0, to specify string printing operation
    la      $a0,                sorted_array                    # Print the prompt to print the sorted input integers
    syscall 

    la      $s0,                array                           # Load address of array in $s0
    lw      $s1,                len                             # Load length of array in $s1
    li      $s2,                0                               # $s2 = 0, iterator over the array

# Loop to Print the sorted array
print_arr_loop:

    beq     $s2,                $s1,            call_search     # If iterator reaches the value 10, branch to exit

    lw      $a0,                0($s0)                          # Load the next number from the array
    li      $v0,                1                               # Load 1 in $v0, to specify integer printing operation
    syscall 

    li      $v0,                4                               # Load 4 in $v0, to specify string printing operation
    la      $a0,                comma                           # Print a comma after each number
    syscall 

    addi    $s0,                $s0,            4               # Increment pointer of $s0 to next position in the array
    addi    $s2,                $s2,            1               # Increment $s2 by 1, to increment the iterator

    j       print_arr_loop                                      # Jump to print_arr_loop to print the next number


# Calling the recursive_search function
call_search:

    li      $v0,                4                               # Load value of 4 in v0 to indicate print_string
    la      $a0,                newline                         # Load address of newline
    syscall                                                     # print newline

    la      $a0,                array                           # a0 = &array, 1st argument
    li      $a1,                0                               # a1 = 0, 2nd argument
    li      $a2,                9                               # a2 = 9, 3rd argument
    lw      $a3,                n                               # a3 = n (key), 4th argument

    jal     recursive_search                                    # call recursive_search(A,0,9,n);
    move    $s0,                $v0                             # store result of search in s0

    beq     $s0,                -1,             not_present     # if result = -1, print message saying not found
    j       present                                             # Else, print the index of the key

# Case of number not found
not_present:

    li      $v0,                1                               # Load value of 1 in v0 to indicate print_int
    lw      $a0,                n                               # Load value of n in a0
    syscall                                                     # Print n

    li      $v0,                4                               # Load value of 4 in v0 to indicate print_string
    la      $a0,                not_found                       # Load address of not_found
    syscall                                                     # print not_found

    j       exit                                                # Exit the program

present:

    li      $v0,                1                               # Load value of 1 in v0 to indicate print_int
    lw      $a0,                n                               # Load value of n in a0
    syscall                                                     # Print n

    li      $v0,                4                               # Load value of 4 in v0 to indicate print_string
    la      $a0,                found                           # Load value of found in a0
    syscall                                                     # Print found

    li      $v0,                1                               # Load value of 1 in v0 to indicate print_int
    move    $a0,                $s0                             # Load the index of key in a0
    syscall                                                     # Print the index

    li      $v0,                4                               # Load value of 4 in v0 to indicate print_string
    la      $a0,                newline                         # Load address of newline to print
    syscall                                                     # Print newline

    j       exit                                                # Exit the program


exit:

    li      $v0,                10                              # Load value of 10 in v0 to indicate exit
    syscall                                                     # Make system call to exit execution

# Function to swap to two numbers
swap:                                                           # swap(&a,&b)
    lw      $t0,                0($a0)                          # Load the value of a in $t0
    lw      $t1,                0($a1)                          # Load the value of b in $t1

    move    $t2,                $t0                             # Store the value of a in $t2
    move    $t0,                $t1                             # Store the value of b in $t0
    move    $t1,                $t2                             # Store the value of a in $t1

    sw      $t0,                0($a0)                          # Store the value of b in a
    sw      $t1,                0($a1)                          # Store the value of a in b

    jr      $ra                                                 # Return to the caller

# Function to sort the array in ascending order
recursive_sort:

    addi    $sp,                $sp,            -20             # Allocate space for 5 registers on the stack
    sw      $a1,                16($sp)                         # Store the value of $a1 in the stack, $a1 is the left or low pointer
    sw      $a2,                12($sp)                         # Store the value of $a2 in the stack, $a2 is the right or high pointer
    sw      $ra,                8($sp)                          # Store the return address in the stack
    sw      $s1,                4($sp)
    sw      $s2,                0($sp)

    move    $s0,                $a0                             # Store the value of $a0 in $s0, $a0 is the array

    add     $t9,                $zero,          $zero           # $t9 = 0+0 = 0

    lw      $s1,                16($sp)                         # Load the value of $a1 in $s1, $a1 is the left or low pointer
    lw      $s2,                12($sp)                         # Load the value of $a2 in $s2, $a2 is the right or high pointer

while_main:
    bge     $s1,                $s2,            exit_sort       # If left pointer is greater than or equal to right pointer, branch to exit_sort

while_inner_1:

    sll     $t3,                $s1,            2               # The value of 4*l, to be added to the address of array
    add     $t3,                $t3,            $s0             # Get the pointer to the left or low iterator, &A[l]
    lw      $t3,                0($t3)                          # Get the value pointed at the left or low iterator A[l]

    lw      $t4,                16($sp)                         # The left iterator in $t4
    sll     $t5,                $t4,            2               # The value of 4*p, to be added to the address of array
    add     $t5,                $t5,            $s0             # Get the pointer to the right or high iterator, &A[p]
    lw      $t5,                0($t5)                          # Get the value pointed at the right or high iterator A[p]

    bgt     $t3,                $t5,            while_inner_2   # if A[l] > A[p] goto while_inner_2
    lw      $t4,                12($sp)
    bge     $s1,                $t4,            while_inner_2   # if l >= right, goto while_inner_2

    addi    $s1,                $s1,            1               # Increment the left iterator
    j       while_inner_1                                       # Jump to while_inner_1 loop

while_inner_2:
    sll     $t4,                $s2,            2               # The value of 4*r, to be added to the address of array
    add     $t4,                $t4,            $s0             # Get the pointer to the right or high iterator, &A[r]
    lw      $t4,                0($t4)                          # Get the value pointed at the right or high iterator A[r]

    lw      $t2,                16($sp)                         # The left iterator in $t2
    sll     $t5,                $t2,            2               # The value of 4*p, to be added to the address of array
    add     $t5,                $t5,            $s0             # Get the pointer to the right or high iterator, &A[p]
    lw      $t5,                0($t5)                          # Get the value pointed at the right or high iterator A[p]

    blt     $t4,                $t5,            while_body      # if A[r] < A[p] goto while_body
    lw      $t4,                16($sp)
    ble     $s2,                $t4,            while_body      # if r <= left goto while_body

    addi    $s2,                $s2,            -1              # Decrement the right (r) by one

    j       while_inner_2                                       # Jump to while_inner_2 loop

while_body:

    blt     $s1,                $s2,            while_continue  # if l < r goto while_continue

    lw      $t4,                16($sp)
    sll     $t5,                $t4,            2               # t5 = p * 4
    add     $t5,                $t5,            $s0             # t5 = &A[p]

    sll     $t4,                $s2,            2               # t4 = r * 4
    add     $t4,                $t4,            $s0             # t4 = &A[r]

    move    $a0,                $t5                             # a0 = &A[p]
    move    $a1,                $t4                             # a1 = &A[r]
    jal     swap                                                # swap(&A[p], &A[r])

    move    $a0,                $s0                             # a0 = A
    lw      $a1,                16($sp)                         # a1 = left
    addi    $a2,                $s2,            -1              # a2 = r - 1
    jal     recursive_sort                                      # recursive_sort(A, left, r - 1)

    move    $a0,                $s0                             # a0 = A
    addi    $a1,                $s2,            1               # a1 = r + 1
    lw      $a2,                12($sp)                         # a2 = right
    jal     recursive_sort                                      # recursive_sort(A, r + 1, right)

    j       exit_sort                                           # jump back to exit_sort

while_continue:

    sll     $t3,                $s1,            2               # t3 = l * 4
    add     $t3,                $t3,            $s0             # t3 = &A[l]

    sll     $t4,                $s2,            2               # t4 = r * 4
    add     $t4,                $t4,            $s0             # t4 = &A[r]
    move    $a0,                $t3                             # a0 = &A[l]
    move    $a1,                $t4                             # a1 = &A[r]

    jal     swap                                                # Call the swap function with appropiate arguments
    j       while_main                                          # jump back to while_main

exit_sort:

    lw      $ra,                8($sp)                          # Load the return address from the stack
    lw      $s1,                4($sp)                          # Load the value of $s1 from the stack
    lw      $s2,                0($sp)                          # Load the value of $s2 from the stack
    addi    $sp,                $sp,            20              # Increment the stack pointer by 20, to pop the memory off the stack
    jr      $ra                                                 # Return to the caller

# Search Function
# recursive_search(A,start,end,key);

recursive_search:

    addi    $sp,                $sp,            -20             # Allocate space for storing 5 variables => 4 params, $ra and mid1,mid2

    sw      $ra,                0($sp)                          # Store return address
    sw      $a0,                4($sp)                          # Store reference to array
    sw      $a1,                8($sp)                          # Store start index
    sw      $a2,                12($sp)                         # Store end index
    sw      $a3,                16($sp)                         # Store key to be searched

# t0 = start, t1 = end, t2 = key
# t3 = mid1, t4 = mid2, t5 = (end-start) / 3
# t6 = A[mid1], t7 = A[mid2]

    move    $t0,                $a1                             # t0 = start
    move    $t1,                $a2                             # t1 = end
    move    $t2,                $a3                             # t2 = key

search_while:

    bgt     $t0,                $t1,            return_false    # if start > end, return -1

    sub     $t5,                $t1,            $t0             # t5 = (end-start)
    addi    $t9,                $zero,          3               # t9 = 3
    div     $t5,                $t9                             # t5 = (end-start) / 3

    mflo    $t5                                                 # t5 = (end-start) / 3

    add     $t3,                $t0,            $t5             # t3 = mid1 = start + (end-start) / 3
    sub     $t4,                $t1,            $t5             # t4 = mid2 = end - (end-start) / 3

    sll     $t6,                $t3,            2               # t6 = 4 * mid1
    add     $t6,                $t6,            $a0             # t6 = &A[mid1]
    lw      $t6,                0($t6)                          # t6 = A[mid1]

    sll     $t7,                $t4,            2               # t7 = 4 * mid2
    add     $t7,                $t7,            $a0             # t7 = &A[mid2]
    lw      $t7,                0($t7)                          # t7 = A[mid2]

# Case of key == A[mid1]
match1:

    bne     $t2,                $t6,            match2          # if key != A[mid1], goto match2

    move    $v0,                $t3                             # return mid1

    j       return                                              # return to caller

# Case of key == A[mid2]
match2:

    bne     $t2,                $t7,            less_mid1       # if key != A[mid2], goto less_mid1

    move    $v0,                $t4                             # return mid2

    j       return                                              # return to caller

# Case of key < A[mid1]
less_mid1:

    bge     $t2,                $t6,            greater_mid2    # break if key >= A[mid1]
                                                                # If key < A[mid1], continue
    move    $a1,                $t0                             # a1 = start
    move    $a2,                $t3                             # a2 = mid1
    addi    $a2,                $a2,            -1              # a2 = mid1 - 1
    move    $a3,                $t2                             # a3 = key

    jal     recursive_search                                    # recursive_search(A,start,mid-1,key);

    j       return                                              # return to caller

# Case of key > A[mid2]
greater_mid2:

    ble     $t2,                $t7,            else            # break if key <= A[mid2]
                                                                # If key > A[mid2], continue

    move    $a1,                $t4                             # a1 = mid2
    addi    $a1,                $a1,            1               # a1 = mid2 + 1
    move    $a2,                $t1                             # a2 = end
    move    $a3,                $t2                             # a3 = key

    jal     recursive_search                                    # recursive_search(A,mid2+1,end,key);

    j       return                                              # return to caller

# When all "else" fails :)
else:

    move    $a1,                $t3                             # a1 = mid1
    addi    $a1,                $a1,            1               # a1 = mid1 + 1
    move    $a2,                $t4                             # a2 = mid2
    addi    $a2,                $a2,            -1              # a2 = mid2 - 1
    move    $a3,                $t2                             # a3 = key

    jal     recursive_search                                    # recursive_search(A,mid1+1,mid2-1,key);

    j       return                                              # return to caller

# When not found, return -1
return_false:

    li      $v0,                -1                              # return -1
    j       return                                              # return to caller

# Returning back to caller
return:

    lw      $ra,                0($sp)                          # restore return address
    addi    $sp,                $sp,            20              # restore stack pointer
    jr      $ra                                                 # return to caller




