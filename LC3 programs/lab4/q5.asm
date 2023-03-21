        .orig x3000
        lea r0, mymsg
mymsg   .stringz "jello world"
        puts
        halt
        .end
        
;lcr translates each string into a binary version.
;it was designed in a way such that as long as their is a valid binary value
;even though it is not an instruction,we can simply ignore it or save it for later use