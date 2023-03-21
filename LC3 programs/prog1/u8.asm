        .orig x3000
st1     .stringz "Character  Unicode  UTF-8 encoding (hex)"
st2     .stringz "-------------------------------------"

spaces  .stringz "               "        
spaces1 .stringz "       "

newline .fill x0A 
        .fill x0000

start_here
        lea r0,st1
        puts
        lea r0,newline
        puts
        lea r0,st2
        puts
        lea r0,newline
        puts
        
        
mloop   lea r1,input
        and r2,r2,#0 ; initialize i=0,as counter
i++     add r1,r1,r2;adress calculated 
        ldr r1,r1,#0 ;dereference the value
        st r1,cp
        brnp enterloop ;while not zero
        
        
        halt
        
enterloop
        st r3,savemainR3
        ld r3,cp
        ;utf8 = to_utf8(*in)
        jsr to_utf8
        ld r3,savemainR3 ;restore r3
        lea r4,retArr
        st r4,utf8
        ;codepoint = to_cp(utf8)
        st r3,savemainR3
        ld r3,utf8
        ld r3,utf8 ;r3 contain the parameter
        jsr to_cp ;
        ld r3,savemainR3 ;restore r3
        ld r5,codep
        st r5,codepoint
        ;printf("%s          U+%-7.4x", utf8, codepoint);
        
        ld r0,utf8 ;utf8 contains an adress of char
        puts
        lea r0,spaces
        puts
        lea r0,codepoint
        puts
        
        
        inloop  and r6,r6,#0 ; initialize j=0,as counter
                add r4,r4,r6 ;utf8[i] adress
                ldr r4,r4,#0 ;utf8[i]
                
                st r4,utf8_i;
                lea r0,utf8_i;
                puts
                
                br inloop
                ;else get out of inloop
                
                lea r0,newline
                puts
                
                add r2,r2,#1
                brnzp i++

savemainR1  .fill x0000         
savemainR2  .fill x0000
savemainR3  .fill x0000
savemainR4  .fill x0000
savemainR5  .fill x0000
savemainR6  .fill x0000
savemainR7  .fill x0000

utf8    .fill x0000
        .fill x0000
utf8_i  .stringz ""        
codepoint .fill x0000
          .fill x0000

input   .fill x0041
        .fill x00F6
        .fill x0416
        .fill x20AC
        .fill x0000
        .fill x0000
;


saveR0  .FILL X0000
saveR1  .FILL X0000
saveR2  .FILL X0000
saveR3  .FILL X0000
saveR4  .FILL X0000
saveR5  .FILL X0000
saveR6  .FILL X0000
saveR7  .FILL X0000

codepoint_len   
;{
        st r0,saveR0;saveR0
        st r1,saveR1;saveR1
        st r2,saveR2;saveR2
        st r3,saveR3;saveR3
        st r4,saveR4;saveR4
        st r5,saveR5;saveR5
        st r6,saveR6;saveR6
        
        
        ;r3 will contain cp
        ld r1,len; load length into r1
        and r1,r1,#0 ; initialize len=0
        ld r2,i  ;  i will be the pointer
        and r2,r2,#0 ; initialize i=0

after_increment        
        lea r0,utf  ;start the array utf[]
        add r0,r0,r2;adress calculated 
        ldr r0,r0,#0 ;dereference the value
        brnp loop ;while not zero
        
        ld r0,saveR0
        ld r1,saveR1
        ld r2,saveR2
        ld r3,saveR3
        ld r4,saveR4
        ld r5,saveR5
        ld r6,saveR6
        ld r7,saveR7
retu    ret
        
loop    lea r6,utf
        add r6,r6,r2 ; go to adress of utf[i]
        ldr r6,r6,#0 ; dereference utf[i]
        ldr r6,r6,#2 ; beg is 2 adresses away, so derefernce there
        
        ;get 2s complement of beg
        not r6,r6
        add r6,r6,#1
        
        add r6,r6,r3 ; cp - (*u)->beg 
        brzp next_cond
        ;else, INCREMENT L
        
        
        ld r4,len;
        add r4,r4,#1;
        st r4,len;
        
        add r2,r2,#1
        brnzp after_increment

        
next_cond
        lea r5,utf
        add r5,r5,r2 ; go to adress of utf[i]
        ldr r5,r5,#0 ; dereference utf[i]
        ldr r5,r5,#3 ; end is 3 adresses away, so derefernce there
        
         ;get 2s complement of beg
        not r5,r5
        add r5,r5,#1
        
        add r5,r5,r3 ; cp - (*u)->end 
        brnz exit_loop   ;exit loop
        ;else
        
        ld r4,len;
        add r4,r4,#1;
        st r4,len;
        

        add r2,r2,#1
        brnzp after_increment
        
exit_loop
        ld r4,len ; load length into r4
        ld r5,neg4; 
        add r5,r4,r5; len-4
        brp halting ; exit(1)
        ;else
        st r4,len
        brnzp retu
 ;}       

        
savem1R0 .fill x0000
savem1R1 .fill x0000
savem1R2 .fill x0000
savem1R3 .fill x0000
savem1R4 .fill x0000
savem1R5 .fill x0000   
savem1R6 .fill x0000
savem1R7 .fill x0000  
  
len     .fill x0000
i       .fill x0000
neg4    .fill #-4
halting halt
        
utf8_len    
;{
        st r0,savem1R0;saveR0
        st r1,savem1R1;saveR1
        st r2,savem1R2;saveR2
        st r3,savem1R3;saveR3
        st r4,savem1R4;saveR4
        st r5,savem1R5;saveR5
        st r6,savem1R6;saveR6
        st r7,savem1R7;saveR7
        
        ;r3 will contain ch
        
        ld r1,len; load length into r1
        and r1,r1,#0 ; initialize len=0
        ld r2,i  ;  i will be the pointer
        and r2,r2,#0 ; initialize i=0
        
after_increment1       
        lea r0,utf  ;start the array utf[]
        add r0,r0,r2;adress calculated 
        ldr r0,r0,#0 ;dereference the value
        brnp loop1 ;while not zero
        
        ld r0,savem1R0
        ld r1,savem1R1
        ld r2,savem1R2
        ld r3,savem1R3
        ld r4,savem1R4
        ld r5,savem1R5
        ld r6,savem1R6
        ld r7,savem1R7
retu1        
        ret
        
loop1   lea r6,utf
        add r6,r6,r2 ; go to adress of utf[i]
        ldr r6,r6,#0 ; dereference utf[i]
        ldr r6,r6,#0 ; mask is 0 adress away, so derefernce there
        
        
        
        ;get the not of the mask
        not r6,r6
        ;and ch with  NOT mask
        and r6,r6,r3
        
        lea r5,utf
        add r5,r5,r2 ; go to adress of utf[i]
        ldr r5,r5,#0 ; dereference utf[i]
        ldr r5,r5,#2 ; end is 2 adresses away, so derefernce there
        
         ;get 2s complement of beg
        not r5,r5
        add r5,r5,#1
        
        add r6,r6,r5; get their difference
        brz exit_loop1
        ;else, INCREMENT L
        
        ld r4,len;
        add r4,r4,#1;
        st r4,len;
        
        add r2,r2,#1
        brnzp after_increment1

        
exit_loop1
        ld r4,len ; load length into r4
        ld r5,neg4; 
        add r5,r4,r5; len - 4
        brp halting ; exit(1)
        ;else
        st r4,len
        
        brnzp retu1
;}



savem2R0 .fill x0000
savem2R1 .fill x0000
savem2R2 .fill x0000
savem2R3 .fill x0000
savem2R4 .fill x0000
savem2R5 .fill x0000   
savem2R6 .fill x0000
savem2R7 .fill x0000



retArr  .blkw 5
        .fill x0000
        
utf     .fill utf_0
        .fill utf_1
        .fill utf_2
        .fill utf_3
        .fill 0
        .blkw 2  ; no reason to expect we should not have some padding!
        
;;                     mask        lead      beg      end       bits 
utf_0   .fill          b00111111
        .fill                     b10000000
        .fill                                 x0       
        .fill                                          x0      
        .fill                                                   #6
        .blkw 2 ; more padding
        
        
utf_1   .fill          b01111111
        .fill                     b00000000
        .fill                                x0000
        .fill                                          x7f
        .fill                                                   #7
        .blkw 5 ; even more padding
        
        
utf_2   .fill          b00011111
        .fill                     b11000000
        .fill                                x80
        .fill                                          x7ff    
        .fill                                                   #5
        .blkw 3 
        
        
utf_3   .fill          b00001111
        .fill                     b11100000
        .fill                                x800
        .fill                                          xffff
        .fill                                                   #4  
;utf4 could go here, for the harder project
chr     .fill x0000
codep  .fill x0000
        .fill x0000
cp      .fill x0000
        .fill x0000
bytes  .fill x0000
        .fill x0000
shift  .fill x0000
        .fill x0000

to_utf8         
        st r0,savem2R0;saveR0
        st r1,savem2R1;saveR1
        st r2,savem2R2;saveR2
        st r3,savem2R3;saveR3
        st r4,savem2R4;saveR4
        st r5,savem2R5;saveR5
        st r6,savem2R6;saveR6
        st r7,savem2R7;save r7
        
        jsr codepoint_len ;call codepoint_len(cp)
        
        ld r1,len; load the calculated length
        st r1,bytes ; store at bytes -> bytes = codepoint_len(cp)
        ld r1,len; load the calculated length
        ;r3 will contain cp
        
        
        lea r6,utf  ;start the array utf[]
        ldr r6,r6,#0 ;dereference the value
        ldr r6,r6,#4 ; bits is 4 adress away so derefernce here
        
        
        add r1,r1,#-1 ;bytes-1

mult    add r6,r6,r6 ;add 
        add r1,r1,#-1;decrement i
        brp mult
        ;else (mult done)
        st r6,shift
        and r5,r5,#0 ;0 out r5
        st r3,cp;save cp

        
        ld r4,bytes; get the value bytes
        lea r2,utf; get the starting address of utf
        add r2,r2,r4 ; calculate adress utf[bytes]
        ldr r2,r2,#0 ; enter utf array
        ldr r2,r2,#1 ; utf[bytes]->mask,into r2
        
        
        and r4,r2,r5;(cp>>shift) & utf[bytes]->mask,store in r4
        lea r2,utf; get the starting address of utf
        add r2,r2,r4 ; calculate adress utf[bytes]
        ldr r2,r2,#0 ; enter utf array
        ldr r2,r2,#2 ; utf[bytes]->lead,into r2 
        ;perform the or operation
        not r4,r4;
        not r2,r2;
        and r4,r4,r2
        not r4,r4; or operation with value in r4
        st r4,retArr ; store at ret[0]
        
        lea r2,utf
        ldr r2,r2,#0 ; enter utf array
        ldr r2,r2,#4; utf[0]->bits_stored,into r2
        ld r6,shift ;
        
        ;2s complement of utf[0]->bits
        not r2,r2
        add r2,r2,#1
        add r6,r6,r2;shift-=utf[0]->bits_stored
        st r6,shift ;store back into shift
        
        and r1,r1,#0;put counter i at r1
        add r1,r1,#1;i =1

loop2   and r5,r5,#0 ;0 out r5
        jsr Rshift
        ld r7 savem2R7;restore r7
        ;r5 now contains cp>>shift
        lea r2,utf
        ldr r2,r2,#0 ; enter utf array
        ldr r2,r2,#1; utf[0]->mask,into r2
        
        lea r2,utf
        ldr r2,r2,#0 ; enter utf array
        ldr r4,r2,#2; utf[0]->lead,into r4
        and r5,r5,r2 ; (cp >> shift & utf[0]->mask) 
        
        ;perform an or operation
        not r5,r5
        not r4,r4
        and r5,r5,r4
        not r5,r5
        ;calculate adress 
        lea r4,retArr ;load start of ret[]
        add r4,r4,r1; calculat adress of ret[i]
        str r5,r4,#0 ; store at ret[i]
        
        lea r2,utf
        ldr r2,r2,#0 ; enter utf array
        ldr r2,r2,#4; utf[0]->bits_stored,into r2
        ld r6,shift ;
        
        ;2s complement of utf[0]->bits
        not r2,r2
        add r2,r2,#1
        add r6,r6,r2;shift-=utf[0]->bits_stored
        st r6,shift ;store back into shift
        
        add r1,r1,#1; increment i
        ld r0,bytes ;
        ;2s complemnt for bytes
        not r0,r0
        add r0,r0,#1
        add r0,r0,r1 ;
        brn loop2 ;i is less than bytes so stay in loop
        ;else
        lea r4,retArr ;load start of ret[]
        ld r1,bytes ;load bytes into r1
        lea r5,strng
        add r4,r4,r1; calculat adress of ret[i]
        str r5,r4,#0 ; store at ret[i]
        
strng  .stringz "\0"        
        
        ld r0,savem2R0
        ld r1,savem2R1
        ld r2,savem2R2
        ld r3,savem2R3
        ld r4,savem2R4
        ld r5,savem2R5
        ld r6,savem2R6
        ld r7,savem2R7
        
        ret
   


to_cp   
;{
        st r0,savem3R0;saveR0
        st r1,savem3R1;saveR1
        st r2,savem3R2;saveR2
        st r3,savem3R3;saveR3
        st r4,savem3R4;saveR4
        st r5,savem3R5;saveR5
        st r6,savem3R6;saveR6
        st r7,savem3R7;save r7
        
        ;r3 will contain chr
        
        ;int bytes = utf8_len(*chr)
        jsr utf8_len
        ld r2,len;
        st r2,bytes ;store the adress of the ret[] at bytes
        
	    ;int shift = utf[0]->bits_stored * (bytes - 1);
	    lea r6,utf  ;start the array utf[]
        ldr r6,r6,#0 ;dereference the value
        ldr r6,r6,#4 ; bits is 4 adress away, so derefernce there
        
        add r1,r1,#-1 ;bytes-1
    
mult1   add r6,r6,r6 ;add 
        add r1,r1,#-1;decrement i
        brp mult1
        ;else (mult done)
        st r6,shift
        
        ;uint32_t codep = (*chr++ & utf[bytes]->mask) << shift
        lea r4,utf
        add r4,r4,r2 ; enter utf array
        ldr r4,r4,#1; utf[bytes]->mask,into r4
        add r3,r3,#1 ; *chr++
        and r4,r4,r3 ;*chr++ & utf[bytes]->mask
shft    add r4,r4,r4 ; left shift
        add r6,r6,#-1;
        brp shft
        ;else
        st r4,codep ;store at codep
        ld r6,shift
        ld r3,savem3R3;restore chr 
        
        and r1,r1,#0;put counter i at r1
        add r1,r1,#1;i =1

loop3   lea r2,utf
        ldr r2,r2,#0 ; enter utf array
        ldr r2,r2,#5; utf[0]->bits_stored,into r2
        ld r6,shift ;
        
        ;2s complement of utf[0]->bits
        not r2,r2
        add r2,r2,#1
        add r6,r6,r2;shift-=utf[0]->bits_stored
        st r6,shift ;store back into shift
        
        ;codep |= ((char)*chr & utf[0]->mask) << shift;
        lea r4,utf
        ldr r4,r4,#0 ; enter utf array
        ldr r4,r4,#1; utf[0]->mask,into r4
        ldr r3,r3,#0 ;(char)*chr
        and r4,r4,r3 ;((char)*chr & utf[0]->mask)
shft2   add r4,r4,r4 ; left shift
        add r6,r6,#-1;
        brp shft2
        ;done shifting
        ;r4 contains left shifted
        ld r3,codep ;r3 will contain codep
        not r3,r3
        not r4,r4
        and r4,r4,r3 
        not r4,r4 ;or operation done
        st r4,codep ;store into codep
        
        ;restore chr into r3
        ld r3,savem3R3 
        
        add r1,r1,#1; increment i
        ld r0,bytes ;
        ;2s complemnt for bytes
        not r0,r0
        add r0,r0,#1
        add r0,r0,r1 ;
        brn loop3 ;i is less than bytes so stay in loop
        ;else
        
        ld r0,savem3R0
        ld r1,savem3R1
        ld r2,savem3R2
        ld r3,savem3R3
        ld r4,savem3R4
        ld r5,savem3R5
        ld r6,savem3R6
        ld r7,savem3R7
        
        ret

;}


Rshift  
        ;r5 will contain value after each shift
        ld r5,shift
step1   ld r0,d
        and r4,r3,r0 ; use a bit mask to check bit 2
        brp setbit1
step2   ld r0,d1
        and r4,r3,r0 ; use bit mask to check bit3
        brp setbit2
step3   ld r0,d2
        and r4,r3,r0 ; use bit mask to check bit4
        brp setbit3
step4   ld r0,d3
        and r4,r3,r0 ; use bit mask to check bit5
        brp setbit4
step5   ld r0,d4
        and r4,r3,r0 ; use bit mask to check bit6
        brp setbit5
step6   ld r0,d5
        and r4,r3,r0 ; use a bit mask to check bit 7
        brp setbit6
step7   ld r0,d6
        and r4,r3,r0 ; use bit mask to check bit 8
        brp setbit7
step8   ld r0,d7 
        and r4,r3,r0 ; use bit mask to check bit 9
        brp setbit8
step9   ld r0,d8
        and r4,r3,r0 ; use bit mask to check bit10
        brp setbit9
step10  ld r0,d9
        and r4,r3,r0 ; use bit mask to check bit11
        brp setbit10
step11  ld r0,d10 
        and r4,r3,r0 ; use a bit mask to check bit 12
        brp setbit11
step12  ld r0,d11 
        and r4,r3,r0 ; use bit mask to check bit 13
        brp setbit12
step13  ld r0,d12
        and r4,r3,r0 ; use bit mask to check bit 14
        brp setbit13
step14  ld r0,d13
        and r4,r3,r0 ; use bit mask to check bit 15
        brp setbit14
step15  ld r0,d14
        and r4,r3,r0 ; use bit mask to check bit 16
        brp setbit15
step16  st r5,shift  ;store what is shifted so far into r5
        and r3,r3,#0
        add r3,r3,r5    ;return 
        add r6,r6,#-1; decrement shift
        brp Rshift ;while still shiftting
        ;else 
        ;r5 contains the shifted value
        ld r3,cp;restore cp into r3
        
        ret
        
setbit1 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit2 ;load mask to set bit 1
        and r5,r4,r0
        not r5,r5
        brnzp step2
setbit2 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit3 ;load mask to set bit 2
        and r5,r4,r0
        not r5,r5
        brnzp step3
        
setbit3 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit4 ;load mask to set bit 3
        and r5,r4,r0
        not r5,r5
        brnzp step4
        
setbit4 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit5 ;load mask to set bit 4
        and r5,r4,r0
        not r5,r5
        brnzp step5
        
setbit5 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit6 ;load mask to set bit 5
        and r5,r4,r0
        not r5,r5
        brnzp step6
setbit6 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit7 ;load mask to set bit 6
        and r5,r4,r0
        not r5,r5
        brnzp step7
setbit7 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit8 ;load mask to set bit 7
        and r5,r4,r0
        not r5,r5
        brnzp step8
        
setbit8 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit9 ;load mask to set bit 8
        and r5,r4,r0
        not r5,r5
        brnzp step9
        
setbit9 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit10 ;load mask to set bit 9
        and r5,r4,r0
        not r5,r5
        brnzp step10
        
setbit10 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit11 ;load mask to set bit 10
        and r5,r4,r0
        not r5,r5
        brnzp step11
              
setbit11 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit12 ;load mask to set bit 11
        and r5,r4,r0
        not r5,r5
        brnzp step12
        
setbit12 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit13 ;load mask to set bit 12
        and r5,r4,r0
        not r5,r5
        brnzp step13
        
setbit13 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit14 ;load mask to set bit 13
        and r5,r4,r0
        not r5,r5
        brnzp step14
        
setbit14 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit15 ;load mask to set bit 14
        and r5,r4,r0
        not r5,r5
        brnzp step15
        
setbit15 ;perform an or opeartion NOT(A' AND B')
        not r4,r5;negate r5
        ld r0,bit16 ;load mask to set bit 15
        and r5,r4,r0
        not r5,r5
        brnzp step16      
        

savem3R0 .fill x0000
savem3R1 .fill x0000
savem3R2 .fill x0000
savem3R3 .fill x0000
savem3R4 .fill x0000
savem3R5 .fill x0000   
savem3R6 .fill x0000
savem3R7 .fill x0000     


d   .fill #2
d1  .fill #4
d2  .fill #8
d3  .fill #16
d4  .fill #32
d5  .fill #64
d6  .fill #128
d7  .fill #256
d8  .fill #512
d9  .fill #1024
d10 .fill #2048
d11 .fill #4096
d12 .fill #8192
d13 .fill #16384
d14 .fill #32768

;negated bit masks
bit2    .fill b1111111111111110 
bit3    .fill b1111111111111101
bit4    .fill b1111111111111011
bit5   .fill b1111111111110111
bit6    .fill b1111111111101111
bit7    .fill b1111111111011111
bit8    .fill b1111111110111111
bit9    .fill b1111111101111111
bit10   .fill b1111111011111111
bit11   .fill b1111110111111111
bit12   .fill b1111101111111111
bit13   .fill b1111011111111111
bit14   .fill b1110111111111111
bit15   .fill b1101111111111111
bit16   .fill b1011111111111111

;;;  some data. No utf_4 for the simpler projects, need to add for harder
;;;  copied from the C program, but LC3 does not support octal
      
      
; utf is an array of pointers and has a sentinel of 0      

        

        .end
       

        