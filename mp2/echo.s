        .globl _echo
        .text

## = Best code so far
        
_echo:

loop1:   
        movw 4(%esp), %dx  #move the comport into the dx
        #movl 8(%esp), %ecx #move escape value into ecx
        addw $5, %dx  #line status
        inb  (%dx), %al  #get bit values
        andb $0x01, %al  #check to see if dr is 1
        jnz loop2        #jnz? #go to send if there is data
       
        jmp loop1        #otherwise wait for data
        

loop2:
        movl 8(%esp), %ecx #move escape value into ecx
        movw 4(%esp), %dx  #move the comport into the dx
        #cmpb %ecx, (%edx)
        #je loop3
        inb (%dx), %ax
        cmpb %ecx, %eax
        je loop3
        outb %al, (%dx)
        jmp loop1

loop3:  
        ret

        .data

        .end

##loop1:  
        #turn on dtr and rts
##        movw 4(%esp), %dx  #move the comport into the dx 
##      movl 8(%esp), %ecx #move escape value into edx
##        movl 0x61, %eax #initialize eax
##        inb (%dx), %al  #TEST
#        outb %al, (%dx) #TEST
#        inb (%dx), %al  #TEST
#        outb %al, (%dx) #TEST
#        movw $0x2fc, %dx #modem control
#        inb  (%dx), %al #get current bit values
#        orb  $0x03, %al # 2 lsbs are now 1
#        outb %al, (%dx)  #rts and dts are set to 1

        #wait for dsr, cts, and dcd
#        movw $0x2fe, %dx  #modem status
#loop1:
#        inb  (%dx), %al  #get current bit values
#        andb $0xb0, %al  #isolate dcd, dsr, and cts
#        xorb $0xb0, %al  #make sure they are all 1
#        jnz  loop1       #if not then try again

#loop2:  
        #if data is ready, jump to send, otherwise stay in loop
##        addw $5, %dx  #line status
##        inb  (%dx), %al  #get bit values
##        andb $0x01, %al  #check to see if dr is 1
#        ret    #TEST
##        jz loop3        #jnz? #go to send if there is data
#        ret    #TEST
##        jmp loop2        #otherwise wait for data
#        ret     #TEST

##loop3:
        #receive and test the data for escape
##        movw 4(%esp), %dx  #i/o data address
##        inb (%dx), %al   #move rx to al
##        outb %al, (%dx)  #TEST
##        jmp loop2
#loop4:  #TEST
#        inb  (%dx), %al  #get thre
#        andb $0x20, %al  #if it is a 1, you can load it
#        jnz  loop4  #jz? #if it is not 1 then you've got to wait
#        jmp loop2
##        cmpb %eax, %ecx  #see if it is the escape character
##        je out          #if it is then quit
##        pushl %ebx    #put the ebx on the stack so you can use it
##        movb %al, %bl  #put rx into ebx

#loop4:  
        #send the data back out
#        movw $0x2fd, %dx #line status
        #thre is 0 when it is full, 1 is empty
#        inb  (%dx), %al  #get thre
#        andb $0x20, %al  #if it is a 1, you can load it
#        jz  loop4   #if it is not 1 then you've got to wait
##        movb %bl, %al  #get the data to send
##        movl 4(%esp), %ebx #restore the ebx
##        addl $4, %esp #restore the stack
##        movw $0x2f8, (%dx)  #send it
##        jmp  loop2  #go look for more data
##out:    
##        ret
##        .data

##        .end
