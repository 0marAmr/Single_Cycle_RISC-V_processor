xor x0,x0,x0
addi x1,x0,0
addi x2,x0,1
addi x3,x0,1
addi x4,x0,1
addi x5,x0,0
addi x6,x0,10
addi x7,x0,0

loop:
beq x3,x4,eq
add x2,x2,x1
sub x3,x3,x4
slli x7,x5,2
sw x2,0(x7)
beq x4,x4,endloop

eq:
add x1,x1,x2
add x3,x3,x4
slli x7,x5,2
sw x1,0(x7)

endloop:
addi x5,x5,1
blt x5,x6,loop
halt