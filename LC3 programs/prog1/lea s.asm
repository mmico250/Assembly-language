        .orig x3000
        
        lea r6,utf
        ldr r6,r6,#0 ; dereference utf[i]
        ldr r6,r6,#1 ; beg is 3 adresses away, so derefernce there
        
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

        .end