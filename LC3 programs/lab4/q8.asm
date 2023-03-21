        .orig x3101
        ld r6,mem   ;load the data at 3001
        ld r5,count ;count = 256
        ldr r1,r6,0   ;starting adress
        
        lea r0,ad1 ;since we start at x3000 
        puts; print ".orig x3000"
        

loop1   lea r0,newl;new line
        puts;print new line
        ld r7,rsev  ;adress to jump to
        jmp r7  ;jmp
retu    add r6,r6,#1;increment the adress
        ldr r1,r6,0   ;dereference this new adress
        add r5,r5,#-1;decrement the counter
        brp loop1

count   .fill b0000001000000000 ; 256
        
        
ad1     .stringz ".orig x3000"

newl    .fill x0A;new line
mem     .fill x3001     
rsev    .fill prln
        
        .end








        .orig x3000
prln    lea r0,mymsg
        puts ;print
        ld r2,i; store the counter in r2
        ld r4,mask; store bitmask somewhere(r4)
loop    and r3,r1,r4 ;perform an and with the bitmask
        brnp mylp  ; if negative go to mylp
        lea r0,zero ; else
        puts
        add r1,r1,r1 ; leftshift by one
        add r2,r2,#-1;decrement the counter
        brzp loop
        ld r7,rseve
        jmp r7
        
mylp    lea r0,one
        puts
        add r1,r1,r1 ; leftshift by one
        add r2,r2,#-1;decrement the character
        brzp loop
        ld r7,rseve
        jmp r7
mymsg   .stringz ".Fill b"

i       .fill b0000000000001111 ; i=15
rseve   .fill retu ;return loaction

mask    .fill b1000000000000000

one     .fill b0000000000110001 
        .fill x0000
zero    .fill b0000000000110000
        .fill x0000
        .end
