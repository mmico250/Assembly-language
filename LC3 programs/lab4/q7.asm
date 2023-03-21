        .orig x3000
        lea r0,mymsg
        puts ;print
        ld r2,i; store the counter in r2
        ld r4,mask; store bitmask somewhere(r4)
loop    and r3,r1,r4 ;perform an and with the bitmask
        brnp mylp  ; if negative go to mylp
        lea r0,zero ; else
        puts
        add r1,r1,r1 ; leftshift by one
        add r2,r2,#-1;decrement the counter
        brp loop
        halt
mylp    lea r0,one
        puts
        add r1,r1,r1 ; leftshift by one
        add r2,r2,#-1;decrement the character
        brp loop
        
mymsg   .fill x62; b
        .fill x0000

i       .fill b0000000000001111 ; i=15


mask    .fill b1000000000000000

one     .fill b0000000000110001 
        .fill x0000
zero    .fill b0000000000110000
        .fill x0000
        .end
