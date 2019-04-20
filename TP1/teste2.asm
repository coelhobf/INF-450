addi $t0, $zero, 0
addi $t1, $zero, 1
addi $t2, $zero, 2
addi $t3, $zero, 3
addi $t4, $zero, 4
addi $t5, $zero, 5
addi $t6, $zero, 6
addi $t7, $zero, 7

add $t1, $t2, $t2
add $t2, $t3, $t3
sub $t3, $t7, $t5
beq $t1, $t4, -4
add $t5, $t0, $t0
beq $t2, $t4, -6
or  $t1, $t2, $t2 
