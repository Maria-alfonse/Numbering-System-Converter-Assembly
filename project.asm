.data
base1: .asciiz "Enter the current system: "
number: .asciiz "Enter the number: "
base2: .asciiz "Enter the new system: "
buffer: .space 150
output: .asciiz "The number in the new system: "
error: .asciiz "Invalid input: the number does not belong to the specified base.\n"
line: .asciiz "\n"
.text
.globl main

main: 
	li $v0, 4
	la $a0, base1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0   #base1 in $t0
	
	
	li $v0, 4
	la $a0, number
	syscall
	li $v0, 8
	la $a0, buffer  #number in buffer
	li $a1, 150
	syscall
	
	li $v0, 4
	la $a0, base2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0   #base2 in $t2
	
	#check if valid if not exit
	jal validate  #0 false or 1 true
	move $t2, $v0
	beqz $t2, invalid
	
  	#jal OtherToDecimal  
	jal DecimalToOther
	
	li $v0, 10
        syscall


	
validate:
	la $a0, buffer
	move $t4, $t0

ValidationLoop:
	lb $t5, 0($a0)
	beqz $t5, valid
	li $t6, 10                # ASCII value for newline character '\n'
    	beq $t5, $t6, Skip
	li $t6, 48
	li $t7, 57
	blt $t5, $t6, invalidin
	bgt $t5, $t7, CheckChar
	
	subi $t5, $t5, 48
	bge $t5, $t4, invalidin
	addi $a0, $a0, 1
	j ValidationLoop

Skip:
	addi $a0, $a0, 1
	j ValidationLoop
CheckChar:
	li $t6, 65
	li $t7, 70
	blt $t5, $t6, invalidin
	bgt $t5, $t7, invalidin
	
	subi $t5, $t5, 55
	bge $t5, $t4, invalidin
	addi $a0, $a0, 1
	j ValidationLoop
	
invalidin:
	li $v0, 0
	jr $ra
	
valid:
	li $v0, 1
	jr $ra	
			
invalid:
	li $v0, 4
	la $a0, error
	syscall	
	
	li $v0, 10
	syscall
	
	
	
DecimalToOther:
    # Convert decimal in $t3 to target base in $t1
        li $t3, 67
    	move $t0, $t3       
    	move $t4, $t1       
    	li $t2, 0           
    	beq $t0, $zero, PrintZero

ConversionLoop:
    	divu $t5, $t0, $t4  
    	mfhi $t6            
    	mflo $t0            
    	sw $t6, 0($sp)      
    	addi $sp, $sp, -4   
    	addi $t2, $t2, 1   
    	bne $t0, $zero, ConversionLoop

PrintResult:
    # Print the output label
    	li $v0, 4
    	la $a0, output
    	syscall

    # Print digits from stack
    	blez $t2, Done      
PrintLoop:
    	addi $sp, $sp, 4    
    	lw $t7, 0($sp)      
    	addi $t2, $t2, -1   

    # Convert digit to ASCII
    	li $t8, 10
    	blt $t7, $t8, Numeric
    	addi $t7, $t7, 55    # Convert to 'A'-'F' for hexadecimal
    	j PrintDigit

Numeric:
 	addi $t7, $t7, 48    # Convert to ASCII ('0'-'9')
    
PrintDigit:
   	li $v0, 11          
    	move $a0, $t7
    	syscall
    	bgtz $t2, PrintLoop  

Done:
    	jr $ra               # Return to caller

PrintZero:
    # Print 0 for the number 0
    	li $v0, 11
    	li $a0, 48           # ASCII for '0'
    	syscall
    	j Done



StringToInt:
	li $t3, 0              
StringToIntloop:

    	lb $t4, 0($a0)      
    	beqz $t4, DoneStringToInt
    
    
    	subi $t4, $t4, 48   
    	mul $t3, $t3, 10    
    	add $t3, $t3, $t4 
    	addi $a0, $a0, 1    
    	j StringToIntloop
    
DoneStringToInt:
  	jr $ra

