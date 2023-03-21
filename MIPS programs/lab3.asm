# File: lab3.asm
# Author: Mike Mico
# Purpose: To calculate age in days. (User inputs current date, birth date)


.text
main:
	# read an input value from the user
	li $v0, 4
	la $a0, prompt
	syscall
	li $v0, 5
	syscall
	move $s0, $v0 		#save the current year at s0
	# print the value back to the user
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	
		
	# read an input value from the user
	li $v0, 4
	la $a0, prompt1
	syscall
	li $v0, 5
	syscall
	move $s1, $v0  		#save the current month at s1
	# print the value back to the user
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $s1
	syscall

	# read an input value from the user
	li $v0, 4
	la $a0, prompt2
	syscall
	li $v0, 5
	syscall
	move $s2, $v0  		#save the current day at s2
	# print the value back to the user
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	# read an input value from the user
	li $v0, 4
	la $a0, prompt3
	syscall
	li $v0, 5
	syscall
	move $s3, $v0 		#save the birth year at s3
	# print the value back to the user
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $s3
	syscall
	  
		
	# read an input value from the user
	li $v0, 4
	la $a0, prompt4
	syscall
	li $v0, 5
	syscall
	move $s4, $v0  		#save the birth month at s4
	# print the value back to the user
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $s4
	syscall

	# read an input value from the user
	li $v0, 4
	la $a0, prompt5
	syscall
	li $v0, 5
	syscall
	move $s5, $v0  		#save the birth day at s5
	# print the value back to the user
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $s5
	syscall

calculate_days_elapsed:
	# calculate number of days passed in current year
	# save the answer in t0
	li $t4, 30     	#store 30 to multiply with
	addi $t0 , $s1, -1    # month-1
	mul $t0 ,  $t4,  $t0   #(month-1) *30
	add $t0,   $t0,  $s2    # save the answer in t0
	
	# calculate number of days passed in birth year
	# save the answer in t0
	addi $t1 , $s4, -1    # month-1
	mul $t1 ,  $t4,  $t1   #(month-1) *30
	add $t1,   $t1,  $s5    # save the answer in t1
	
	# print the value back to the user
	li $v0, 4
	la $a0, result1
	syscall
	li $v0, 1
	move $a0, $t0
	syscall

	# print the value back to the user
	li $v0, 4
	la $a0, result2
	syscall
	li $v0, 1
	move $a0, $t1
	syscall

getage:
	blt $t0, $t1, opt1
	sub $t2, $s0,$s3 #age year in t2
	
	#get days 
	sub $t3, $t0,$t1  #number of days in t3
	
	#total days 
	li $t5, 365
	mul $t6, $t2,$t5
	add $t6, $t6, $t3
	
	# print the value back to the user
	#print age in years
	li $v0, 4
	la $a0, result3
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	# print the value back to the user
	#print days since birthday
	li $v0, 4
	la $a0, result4
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	
	# print the value back to the user
	# print total days
	li $v0, 4
	la $a0, result5
	syscall
	li $v0, 1
	move $a0, $t6
	syscall

	jal Exit

opt1: 
	#current year = current year -  birth year -1
	#age= current year - birth year
	sub $t2, $s0,$s3
	addi $t2, $t2,-1 #age year in t2

	#get days 
	sub $t3, $t1,$t0  
	li $t5, 365
	sub $t3, $t5,$t3  #number of days in t3

	#total days
	mul $t6, $t2,$t5
	add $t6, $t6, $t3
	
	# print the value back to the user
	# print age in years
	li $v0, 4
	la $a0, result3
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	# print the value back to the user
	# print days since birthday
	li $v0, 4
	la $a0, result4
	syscall
	li $v0, 1
	move $a0, $t3
	syscall

	# print the value back to the user
	# print total days
	li $v0, 4
	la $a0, result5
	syscall
	li $v0, 1
	move $a0, $t6
	syscall

# call the Exit subprogram to exit
	jal Exit
.data
prompt: .asciiz "\nPlease enter the current year: "
prompt1: .asciiz "\nPlease enter the current month: "
prompt2: .asciiz "\nPlease enter the current day: "

prompt3: .asciiz "\nPlease enter your birth year: "
prompt4: .asciiz "\nPlease enter the your birth month: "
prompt5: .asciiz "\nPlease enter your birth day: "

result: .asciiz "\nYou entered: "
result1: .asciiz "\nDays elapsed in current year: "
result2: .asciiz "\nDays elapsed in birth year: "

result3: .asciiz "\n\n\nYears: "
result4: .asciiz "\tDays: "
result5: .asciiz "\nTotal Days: "

Exit:
li $v0, 10
syscall