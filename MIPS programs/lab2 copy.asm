.data
.text 
.globl main 


main: 
      la $a0, X
      la $a1, Y
      jal strcpy
      li $v0, 10 #System Call Argument 
      SZaaddi $sp, $sp, -4      # adjust stack for 1 item
              sw   $s0, 0($sp)       # save $s0
	     addu  $s0, $zero, $zero     # addr of x[i] in $t3   
              
         L1:  addu  $t1, $s0, $a1     # addr of y[i] in $t1   
              lbu  $t2, 0($t1)       # $t2 = y[i]              
              sb   $t2, 0($t3)       # x[i] = y[i]    
              beq  $t2, $zero, L2    # exit loop if y[i] == 0  
              addu $s0, $s0, 1       # i = i + 1  
              j    L1               # next iteration of loop

        L2:      
	    jr $ra #End    

.data

X: .space 100
Y: .asciiz "This"
