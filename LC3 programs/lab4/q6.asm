        .orig x3000
        .fill b1110000000000010;lea r0,mymsg
        .fill b1111000000100010;puts
        .fill b1111000000100101;halt
mymsg   .fill x21
        .fill x21
        .fill b0000000001101000;h
        .fill b0000000001101001;i
        .end