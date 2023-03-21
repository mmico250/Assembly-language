    .orig x3000
    lea r0,mymsg
    trap x22; alias for this puts
    trap x25 ; alias for this is halt
mymsg  .fill x21
       .fill x21
       .stringz "jello world"
       .end