        .globl _pollcount_putc
        .text

_pollcount_putc:

        movl $0x0, %ecx  #for the count
loop:
        incl %ecx  #incremnt the number of times checked
        movl $0x2f8, %dx  #com2 address
        addw $5, %dx   #line status
        inb (%dx), %al  #get the thre
        andb $0x20, %al #look at the thre
        jz  loop #stay in loop if holding register full
        movl $0x2f8, %dx  #com2 address
        movl 4(%esp), %eax
        outb %al, (%dx)  #send out the char
        movl %ecx, %eax
        ret

        .data


        .end
