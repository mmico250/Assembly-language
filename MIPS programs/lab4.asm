# File: lab4.as,
# Author: Mike Mico


.data
result7: .asciiz "\n Single precision value: "
result8: .asciiz "\n Multiplication Double precision value: "
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

.text
main:
	li.s $f0, 3.1415
	cvt.d.s $f0, $f0
	

	li.d $f2, 17.8415
	mul.d $f6, $f2, $f0
	mul.d $f12, $f6 ,$f2    #save area as single precision in f5
	#cvt.d.s $f4, $f3       #store double precision i 
	
	j output

output: #print the prompt "double precision value: "
	li $v0, 4
	la $a0, result8
	syscall
        
	#print the value
	li $v0, 3
	mov.d $f12, $f12
	syscall
	
	j part2



part2:	
	# prompt user
	li $v0, 4
	la $a0, prompt
	syscall
	li $v0, 7
	syscall
	mov.d $f2,$f0         #store current year at f2
	#reveal input
	li $v0, 4
	la $a0, result
	syscall
	# print the value back to the user
	li $v0, 3
	mov.d $f12, $f2
	syscall
	
		
	# prompt user
	li $v0, 4
	la $a0, prompt1
	syscall
	li $v0, 7
	syscall
	mov.d $f4,$f0         #store current month at f4
	#reveal input
	li $v0, 4
	la $a0, result
	syscall
	# print the value back to the user
	li $v0, 3
	mov.d $f12, $f4
	syscall

	# prompt user
	li $v0, 4
	la $a0, prompt2
	syscall
	li $v0, 7
	syscall
	mov.d $f6,$f0         #store current day at f6
	#reveal input
	li $v0, 4
	la $a0, result
	syscall
	# print the value back to the user
	li $v0, 3
	mov.d $f12, $f6
	syscall

	
	# prompt user
	li $v0, 4
	la $a0, prompt3
	syscall
	li $v0, 7
	syscall
	mov.d $f8,$f0         #store birth year at f8
	#reveal input
	li $v0, 4
	la $a0, result
	syscall
	# print the value back to the user
	li $v0, 3
	mov.d $f12, $f8
	syscall
	  
		
	
	# prompt user
	li $v0, 4
	la $a0, prompt4
	syscall
	li $v0, 7
	syscall
	mov.d $f10,$f0         #store birth month at f10
	#reveal input
	li $v0, 4
	la $a0, result
	syscall
	# print the value back to the user
	li $v0, 3
	mov.d $f12, $f10
	syscall

	
	
	# prompt user
	li $v0, 4
	la $a0, prompt5
	syscall
	li $v0, 7
	syscall
	mov.d $f12,$f0         #store birth day at f12
	#reveal input
	li $v0, 4
	la $a0, result
	syscall
	# print the value back to the user
	li $v0, 3
	mov.d $f12, $f12
	syscall

calculate_days_elapsed:
	# calculate number of days passed in current year
	# save the answer in f20
	li.d $f14 , 1.0	
	li.d $f16, 30.44     	#store 30.44 to multiply with
	sub.d $f18 , $f4, $f14    # month-1 ,store at f18
	mul.d $f20 ,  $f18,  $f16   #(month-1) *30.44
	add.d $f20,   $f20,  $f6    #(month-1) *30.44 + days save the answer in f20
	
	# calculate number of days passed in birth year
	# save the answer in t22
	sub.d $f18 , $f10, $f14    # month-1 ,store at f18
	mul.d $f22 ,  $f18,  $f16   #(month-1) *30.44
	add.d $f22,   $f22,  $f12    #(month-1) *30 + days save the answer in f22
	
	# print the value back to the user
	li $v0, 4
	la $a0, result1
	syscall
	li $v0, 3
	mov.d $f12,$f20
	syscall

	# print the value back to the user
	li $v0, 4
	la $a0, result2
	syscall
	li $v0, 3
	mov.d $f12,$f22
	syscall

getage:
	c.lt.d $f20,$f22
	bc1t opt1
	sub.d $f24, $f2,$f8 #age year in f24
	
	#get days 
	sub.d $f26, $f20,$f22  #number of days in f26
	
	#total days 
	li.d $f28, 365.25
	mul.d $f30, $f24,$f28
	add.d $f30, $f30, $f26
	
	# print the value back to the user
	#print age in years
	li $v0, 4
	la $a0, result3
	syscall
	li $v0, 3
	mov.d $f12, $f24
	syscall
	# print the value back to the user
	#print days since birthday
	li $v0, 4
	la $a0, result4
	syscall
	li $v0, 3
	mov.d $f12, $f26
	syscall
	
	# print the value back to the user
	# print total days
	li $v0, 4
	la $a0, result5
	syscall
	li $v0, 3
	mov.d $f12, $f30
	syscall

	jal Exit

opt1: 
	#current year = current year -  birth year -1
	#age= current year - birth year
	sub.d $f24, $f2,$f8
	sub.d $f24, $f24,$f14

	#get days 
	#number of days in f26
	sub.d $f26 ,$f22,$f20 
	li.d $f28, 365.25
	sub.d $f26, $f28,$f26  #number of days in f26

	#total days
	mul.d $f30, $f24,$f28
	add.d $f30, $f30, $f26
	
	# print the value back to the user
	# print age in years
	li $v0, 4
	la $a0, result3
	syscall
	li $v0, 3
	mov.d $f12, $f24
	syscall
	# print the value back to the user
	# print days since birthday
	li $v0, 4
	la $a0, result4
	syscall
	li $v0, 3
	mov.d $f12, $f26
	syscall

	# print the value back to the user
	# print total days
	li $v0, 4
	la $a0, result5
	syscall
	li $v0, 3
	mov.d $f12, $f30
	syscall
	jal Exit

Exit:
li $v0,10
syscall