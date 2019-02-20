#Auth : vladimir geytman               DATE: 11/8/16
#input : 2 array 
#output : 1 array

.data
          array_1       : .space 40 # num * Place= 10*4 
          idx_1         : .word 0
          array_2       : .space 40 # num * Place= 10*4 
          idx_2         : .word 0
          Get_attay1    : .asciiz  "Get_attay1: Enter 10 num to array_1 Smallest to greatest \n "
          Get_attay2    : .asciiz  "Get_attay2: Enter 10 num to array_2 Smallest to greatest \n "
          nogood        : .asciiz  " Smaller than the last number entered Try again \n"
          p.10          : .asciiz  " New arr in base 10 : "
          p.array1      : .asciiz  " Array 1: " 
          p.array2      : .asciiz  " Array 2: " 
.text

.globl main

main: 
#############################################################################################################
# idx 1 run in arr 1 . 0 to arr.length-1 and Put numbers in ascending order
#
#############################################################################################################             
            li $v0 ,4          # print request 1
            la $a0 , Get_attay1
            syscall
            
             li $t2 ,0
loop_arr_1 : li $v0 ,5
             syscall           # call num 
            
             move $t5 ,$v0     # t5 = my num
            
             lw  $t0 ,idx_1                    
             beq $t0 ,40,loop_arr_2 # arr 1 is full go arr 2 (idx ==40)
             beq $t0,$zero ,loop_0   #if idx = 0 go loop 0  
             li $t4,-4
             add $t6, $t0 ,$t4       
             lw  $t7 ,array_1($t6)
             blt $t7 ,$t5 ,is_good # t5 < t7  === indx-1>indx
              
             li $v0 ,4          # print request 1
             la $a0 , nogood
             syscall
             
             j loop_arr_1
             
is_good :          ## If the number is smaller than the last inserted in arr1
             sw  $t5 ,array_1($t0)
             addi $t0 ,$t0 ,4   # its i ++
             sw  $t0,idx_1 
             
              j loop_arr_1  
             
loop_0:       ## Take care of number one , will always be
             
             sw $t5 ,array_1($t0)
             addi $t2 ,$t2 ,4     # its i ++
             sw  $t2,idx_1  
             j loop_arr_1   
             
###########################################################################################################
# ///////             print arr 1 , for Beauty
###########################################################################################################                     
pint_arr_1:   
                 li $v0 ,4           #for Beauty
                 la $a0 ,p.array1 
                 syscall      
        
                addi $t0 $zero ,0     
                lw $t1 ,idx_1           
                     
loop_print :    beq $t0 ,$t1 ,pint_arr_on  # idx run on arr to arr.length-1 and print all num in 
                lw  $t7 ,array_1($t0)   
                addi $t0 ,$t0,4       
                move $a0 ,$t7         
                li $v0 ,1          
                syscall
                
                li $v0 ,11     #for Beauty
                la $a0 ,'.'          
                syscall
                
                j loop_print         
###########################################################################################################
# idx 2 run in arr 2 0 to arr.length-1 and Put numbers in ascending order
#
###########################################################################################################               
              
loop_arr_2 : 
            li $v0 ,4          # print request 2
            la $a0 , Get_attay2
            syscall
            
             li $t2 ,0
loop_arr_22 : 
             li $v0 ,5
             syscall           # call num 
            
             move $t5 ,$v0     # t5 = my num
            
             lw  $t0 ,idx_2                    
             beq $t0 ,40,pint_arr_1 # arr 2 is full go print (idx ==40)
             beq $t0,$zero ,loop_00   #if idx = 0 go loop 0  
             li $t4,-4
             add $t6, $t0 ,$t4       
             lw  $t7 ,array_2($t6)
             blt $t7 ,$t5 ,is_good2 # t5 < t7  === indx-1>indx
              
             li $v0 ,4          # print request 2
             la $a0 , nogood
             syscall
             
             j loop_arr_22
             
is_good2 :          ## If the number is smaller than the last inserted in arr1
             sw  $t5 ,array_2($t0)
             addi $t0 ,$t0 ,4   # its i ++
             sw  $t0,idx_2 
             
              j loop_arr_22  
             
loop_00:       ## Take care of number one , will always be
             
             sw $t5 ,array_2($t0)
             addi $t2 ,$t2 ,4     # its i ++
             sw  $t2,idx_2  
             j loop_arr_22   
               
###########################################################################################################
# ///////             print arr 2 , for Beauty
###########################################################################################################              
pint_arr_on:
                 li $v0 ,11          #for Beauty
                 la $a0 ,'\n'          
                 syscall
                 
                 li $v0 ,4           #for Beauty
                 la $a0 ,p.array2 
                 syscall      

                 addi $t0 $zero ,0     
                 lw $t1 ,idx_2           
                     
loop_print_2 :   beq $t0 ,$t1 ,Cutting_of_arrays  # idx run on arr to arr.length-1 and print all num in 
                 lw  $t7 ,array_2($t0)   
                 addi $t0 ,$t0,4       
                 move $a0 ,$t7         
                 li $v0 ,1          
                 syscall
                
                 li $v0 ,11     #for Beauty
                 la $a0 ,'.'          
                 syscall
                
                 j loop_print_2
###########################################################################################################
#Cutting of arrays  ..   of 2 arr
###########################################################################################################
Cutting_of_arrays:
                    li $v0 ,11          #for Beauty
                    la $a0 ,'\n'          
                    syscall
                    
                    li $v0 ,4          # print arr 1 and 2 in base 10
                    la $a0 ,  p.10
                    syscall
                    
                    li $s0 ,-4
                    li $t0,36       # arr.length-1 idx in arr 1
                    li $t1,36       # arr.length-1 idx in arr 2
lpp:                lw $t2,array_1($t0)
                    lw $t3,array_2($t1)
                    
                    blt $t2 ,$t3 ,yotr_gadol   #if num in arr2> num in arr1 go label
                    
                    li $v0 ,1           # else print num in arr 2
                    move $a0 ,$t2         
                    syscall
                    
                    li $v0 ,11     #for Beauty
                    la $a0 ,'.'          
                    syscall
                    
                    addi $t0,$t0,-4          # idx-1 
                    beq  $t0 ,$s0,arr1_null    # if idx in arry 2 is == null print arr1 
                      j lpp
yotr_gadol:                                                 
                    li $v0 ,1
                    move $a0 ,$t3         # print num
                    syscall
                    
                    li $v0 ,11     #for Beauty
                    la $a0 ,'.'          
                    syscall
                    
                    addi $t1,$t1,-4         # idx -1 
                    beq  $t1 ,$s0,arr2_null  # indx >null loop else print all arr1 
                     j lpp
                      
arr1_null:                             #arr 1 is null print all num in arr 2
                   bne $t1 ,$s0,gogo  # idx i arr 2=!null go label els go end 
                   
                    j  end
                   
gogo:                                    
                  lw $t3,array_2($t1)   #print arr 2
                 
                  li $v0 ,1
                  move $a0 ,$t3         
                  syscall
                  
                  li $v0 ,11     #for Beauty
                  la $a0 ,'.'          
                  syscall
                     
                  addi $t1,$t1,-4 
                  j arr1_null
                     
arr2_null:                                 #arr2 is full print arr 1 
                    bne $t1 ,$s0,gogo2     # if idx in arr1 =! null go label and print arr 
                   
                     j  end
                   
gogo2:               
                  lw $t2,array_1($t0)
                 
                  li $v0 ,1
                  move $a0 ,$t2         
                  syscall
                  
                  li $v0 ,11     #for Beauty
                  la $a0 ,'.'          
                  syscall
                     
                  addi $t1,$t1,-4 
                  j arr2_null                                           
                 
###########################################################################################################
#end of globl main  
###########################################################################################################         
end:


              li $v0 ,10             
              syscall
