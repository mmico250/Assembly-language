        .orig x3000
        lea r0, mymsg
mylp    puts
        add r0,r0, #1; increment r0
        ldr r2,r0, #0; derefernce r0 and store into r2
        and r2,r2, #3; contents of r2 and bitmask of 3, basically check if content divisible by 4
        brnp mylp; if not 0, go to mylp
        halt
mymsg   .fill x21
        .fill x21
        .stringz "jello world"
        .end
        
        
;the program starts off printing from the the firdt location with the "!"
;we then dereference the contents of r0 storing into r2
;as long as the now contents of r2, are not divisible by 4 we keep incrementing r0 meaning everytime we print we start from the next character
;this program looped 4 times