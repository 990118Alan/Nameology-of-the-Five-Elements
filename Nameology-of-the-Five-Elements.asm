.data
name:.string "s1111622"
str1: .string " input number M= "
str2: .string "If you are single surname, input 0"
str3:.string "If you are double-barrelled surname ,input 1"
str4:.string "Please enter the strokes  of the last name="
str5:.string "If you only have  1 character on the first name,input 0"
str6:.string "If you  have  2 character on the first name,input 1"
str7:.string "Please enter the strokes of the first character of the first name ="
str8:.string "Please enter the strokes of the second character of the first name ="
str9:.string "Please enter the strokes of the first character of the last name="
str10:.string "Please enter the strokes of the second character of the last name="
Sky:.string "Sky "
People:.string "People "
Land:.string "Land "
Total:.string "Total "
Outside:.string "Outside "
wood: .string " wood "
fire: .string " fire"
earth: .string " earth"
metal: .string " metal"
water: .string " water"
total:.word
generate: .string " generate "
restraint: .string " restraint "
equal: .string " equal "
first_last_name:.word
secone_last_name:.word
.text
#t0=first_last_name,t1=secone_last_name,t2=first character on the first name,t3=first character on the first name
#t0~t4 initialization=-1,a2=sky,a3=people,a4=land,a5=outside,a6=total
main:
#output "s1111622"
	la      a0, name
        li       a7, 4
        ecall
 	li a0, '\n'           
    	li a7, 11  
    	
    	li t4,10
    	li a6,0
        ecall
input_last_name:
        la      a0, str2
        li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall	
        la      a0, str3
        li       a7, 4
        ecall
	li a0, '\n'           
    	li a7, 11  
	ecall	
	jal input
	mv a3,a0
	beqz a3 single_surname
	bgtz a3 double_barrelled_surname
	j exit
single_surname:
	la      a0, str4
        li       a7, 4
        ecall
        li t0,1#if single_surname,t0=1,t1=input
        addi a6,a6,-1
 	li a0, '\n'           
    	li a7, 11  
        ecall
        jal input
        mv t1,a0
        jal first_name
double_barrelled_surname:
	la      a0, str9
        li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall
        jal input
        mv t0,a0
        la      a0, str10
        li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall
        jal input
        mv t1,a0
        jal first_name
first_name:
	la      a0, str5
        li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall	
        la      a0, str6
        li       a7, 4
        ecall
	li a0, '\n'           
    	li a7, 11  
	ecall	
	jal input
	mv a3,a0
	beqz a3 one_character
	bgtz a3 two_character
one_character:
	la      a0, str7
        li       a7, 4
        ecall
 	li a0, '\n'           
    	li a7, 11  
        ecall
        jal input
        li t3,1#if one_character,t3=1,t2=input
        addi a6,a6,-1
        mv t2,a0
        jal computeSky
 two_character:
 	la      a0, str7
        li       a7, 4
        ecall
 	li a0, '\n'           
    	li a7, 11  
        ecall
        jal input
        mv t2,a0
        la      a0, str8
        li       a7, 4
        ecall
 	li a0, '\n'           
    	li a7, 11  
        ecall
        jal input
        mv t3,a0
        jal computeSky
computeSky:
	la a0,Sky
	li       a7, 4
        ecall
        add t5 ,t0,t1
        mv a0,t5
	li       a7, 1
        ecall
        jal computeWuXin
        mv a2,a0
        jal computePeople
computePeople:
        la a0,People
	li       a7, 4
        ecall
        add t5 ,t1,t2
        mv a0,t5
	li       a7, 1
        ecall
        jal computeWuXin
        mv a3,a0
        jal computeLand
computeLand:
        la a0,Land
	li       a7, 4
        ecall
        add t5 ,t2,t3
        mv a0,t5
	li       a7, 1
        ecall
        jal computeWuXin
        mv a4,a0
        jal computeOutside
computeOutside:
        la a0,Outside
	li       a7, 4
        ecall
        add t5 ,t0,t3
        mv a0,t5
	li       a7, 1
        ecall
        jal computeWuXin
        mv a5,a0
        jal computeTotal
computeTotal:
        la a0,Total
	li       a7, 4
        ecall
        add t5 ,t0,t1
        add t5,t5,t2
        add t5,t5,t3
        add t5,t5,a6
        mv a0,t5
	li       a7, 1
        ecall
        jal computeWuXin
        mv a6,a0
        jal computeRelationship
computeRelationship:
        li t0,-1#
	li t1,4
	li t2,-2
	li t3,3
	#sky to other
	sub t6,a2,a3
	la t4,Sky
	la t5,People
	jal relationship
	sub t6,a2,a4
	la t5,Land
	jal relationship
	sub t6,a2,a5
	la t5,Outside
	jal relationship
	sub t6,a2,a6
	la t5,Total
	jal relationship
	#People to other
	sub t6,a3,a2
	la t4,People
	la t5,Sky
	jal relationship
	sub t6,a3,a4
	la t5,Land
	jal relationship
	sub t6,a3,a5
	la t5,Outside
	jal relationship
	sub t6,a3,a6
	la t5,Total
	jal relationship
	#Land to other
	sub t6,a4,a2
	la t4,Land
	la t5,Sky
	jal relationship
	sub t6,a4,a3
	la t5,People
	jal relationship
	sub t6,a4,a5
	la t5,Outside
	jal relationship
	sub t6,a4,a6
	la t5,Total
	jal relationship
	#Outside to other
	sub t6,a5,a2
	la t4,Outside
	la t5,Sky
	jal relationship
	sub t6,a5,a3
	la t5,People
	jal relationship
	sub t6,a5,a4
	la t5,Land
	jal relationship
	sub t6,a5,a6
	la t5,Total
	jal relationship
	#Total to other
	sub t6,a6,a2
	la t4,Total
	la t5,Sky
	jal relationship
	sub t6,a6,a3
	la t5,People
	jal relationship
	sub t6,a6,a4
	la t5,Land
	jal relationship
	sub t6,a6,a5
	la t5,Outside
	jal relationship
        jal exit
computeWuXin: 
        rem t5,t5,t4
        blez t5,ModeWater
        li t6,2	 
	ble t5,t6,ModeWood
	li t6,4
	ble t5,t6,ModeFire
	li t6,6	 
	ble t5,t6,ModeEarth
	li t6,8
	ble t5,t6,ModeMetal
	li t6,9
	ble t5,t6,ModeWater

exit:
        li a7, 10  
        ecall	
input:
	li a7 5
	ecall
	ret
ModeWood:
	la a0,wood
	li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall
        li a0,1
	ret
	
ModeFire:
	la a0,fire
	li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall
        li a0,2
	ret

ModeEarth:
	la a0,earth
	li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall
        li a0,3
	ret

ModeMetal:
	la a0,metal
li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall
        li a0,4
	ret
ModeWater:
	la a0,water
	li       a7, 4
        ecall
        li a0, '\n'           
    	li a7, 11  
        ecall
        li a0,5
	ret

relationship:
	beq	 t6,t0,_generate
	beq	 t6,t1,_generate
	beq	 t6,t2,_restraint
	beq	 t6,t3,_restraint
	beqz t6,_equal
	ret
_generate:
	mv a0,t4
	li a7,4
	ecall
	la a0,generate
	li a7,4
	ecall
	mv a0,t5
	li a7,4
	ecall
	li a0, '\n'           
    	li a7, 11  
        ecall	
	ret
	
_restraint:
	mv a0,t4
	li a7,4
	ecall
	la a0,restraint
	li a7,4
	ecall
	mv a0,t5
	li a7,4
	ecall
	li a0, '\n'           
    	li a7, 11  
        ecall	
	ret
_equal:
	mv a0,t4
	li a7,4
	ecall
	la a0,equal
	li a7,4
	ecall
	mv a0,t5
	li a7,4
	ecall
	li a0, '\n'           
    	li a7, 11  
        ecall	
	ret
