    .orig x3000
    lea r0,mymsg
    trap x22; alias for this puts
    .fill x21
    .fill x22
    .fill x23
    .fill x24
    .fill x25
    .fill x26
    .fill x8000
    trap x25 ; alias for this is halt
mymsg  .fill x21
       .fill x21
       .stringz "jello world"
       .end