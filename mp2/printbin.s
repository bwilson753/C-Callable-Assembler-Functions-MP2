        .globl _printbin
        .text

_printbin:       
        #movl $array, %eax #return the string
         #pushl 4(%esp)
        #call _printf
        #addl $4, %esp

        #0x20 = space
        #0x30 = 0
        #0x31 = 1
#create an "and" comparison that compares to 1111 0000, then
#put the first char into donibble then "and"  to 0000 1111
#and put the second char into do nibble
        #movl $array, %ebx #this places array pointer into ebx
        movl $0xf0, %ecx #this puts 1111 0000 into ecx
        movl 4(%esp), %edx #put char values into edx
        #movl %esp, %ebp #find the arguments
        andl %edx, %ecx #put first char value into ecx
        sarl $4, %ecx shift the bits to the right (becomes first 4 bits)
        movl $0, %eax #initialize eax to zero
        movl $array, %edx
        #need ecx, CAN use eax, CAN use edx but must be reitialized
        jmp donibble
back1:  #gets back to main code
        movl $array, %eax
        addb $9, %eax move to the last address of array (space)
        cmpl %edx, %eax #if this is true it has reached the end
        je back2  #go to return
        movb $0x20, (%edx)#add a space
        movl 4(%esp), %edx#put the chars back in edx
        movl $0x0f, %ecx #puts 0000 1111
        andl %edx, %ecx #puts 2nd char value into ecx
        movl $0, %eax #initialize eax to zero
        movl $array, %edx
        addb $5, %edx
        jmp donibble

back2:  
        movl $array, %eax#puts the final array value into eax  
        ret
        #will have to decrement back at the end.
donibble:
        #0x8 = 1000
        #0x4 = 0100
        #0x2 = 0010
        #0x1 = 0001

#move the appropriate hex value then "and" it with ecx
        movl $0x8, %eax # eax has value > 1 if there is an 3rd bit
        andl %ecx, %eax # it will hsve 0 otherwise
        cmpb $0, %eax
        je na #jump to add zero if equal

a:     #this adds a 1 to char string then increments address (incb)
        movb $0x31, (%edx)
        incb %edx
        jmp b #TEST back1 should be b
        
na:    #this adds a zero to char string then increments it
        movb $0x30, (%edx)
        incb %edx

b:     #tests second bit
        movl $0x4, %eax # eax has value > 1 if there is an 3rd bit
        andl %ecx, %eax # it will hsve 0 otherwise
        cmpb $0, %eax
        je nba #jump to add zero if equal

ba:     #this adds a 1 to char string then increments address (incb)
        movb $0x31, (%edx)
        incb %edx
        jmp c

nba:    #this adds a zero to char string then increments it
        movb $0x30, (%edx)
        incb %edx

c:       #tests 3rd bit
         movl $0x2, %eax # eax has value > 1 if there is a 2nd bit
         andl %ecx, %eax # it will hsve 0 otherwise
         cmpb $0, %eax
         je nca #jump to add zero if equal

ca:      #this adds a 1 to char string then increments address (incb)
         movb $0x31, (%edx)
         incb %edx
         jmp d

nca:     #this adds a zero to char string then increments it
         movb $0x30, (%edx)
         incb %edx

d:       #tests 4th bit
         movl $0x1, %eax # eax has value > 1 if there is a 2nd bit
         andl %ecx, %eax # it will hsve 0 otherwise
         cmpb $0, %eax
         je nda #jump to add zero if equal

da:      #this adds a 1 to char string then increments address (incb)
         movb $0x31, (%edx)
         incb %edx
         jmp back1

nda:     #this adds a zero to char string then increments it
         movb $0x30, (%edx)
         incb %edx
         jmp back1
        
#this code takes in a single char value and uses bitmasking to uncover
#each bit, one at a time, and its to a char array. 
        


        

        
        .data
#need to create a char array to hold a string of length 9.
#four bits, a space, and then four more bits.
array:  .asciz "923496789 " #this is 9 spaces long, plus one
                            #space for extra increment
        .end
