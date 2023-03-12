xor x0, x0, 0
addi x1, x0, 8
addi x2, x0, 1
addi x3, x0, 1
addi x7, x0, 0
addi x8, x0, 1
addi x9, x0, 2

loop1:
blt x1, x9, end
addi x7, x3, 0
addi x2, x1, 0

lable:
blt x2, x9, endloop
add x3, x3, x7
sub x2, x2, x8
beq x9, x9, lablel

endloop:
sub x1, x1, x8
beq x9, x9, loop1
end:
sw x3, 0(x0)