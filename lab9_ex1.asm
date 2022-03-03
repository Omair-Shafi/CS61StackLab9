.orig x3000
;this stack lab computes the polish notation of a set of calls
LD R6, STACK_ADDR

;push_val(4) pushes the value 4 onto the stack [4]
AND R1,R1,#0
ADD R1,R1,#4
LD R5, push_val
JSRR R5

;push_val(3) pushes the value 3 onto the stack [4,3]
AND R1,R1,#0
ADD R1,R1,#3
LD R5, push_val
JSRR R5

;push_val(2) pushes the value 2 onto the stack [4,3,2]
AND R1,R1,#0
ADD R1,R1,#2
LD R5, push_val
JSRR R5

;add_val() pop 3,2 and push the result of 3+2 onto the stack [4,5]
LD R5, add_val
JSRR R5

;add_val() pop 4,5 and push the result of 4+5 onto the stack[9]
LD R5, add_val
JSRR R5
;move the top value of the stack into r4

halt

push_val .FILL x3400
add_val .FILL x3800
STACK_ADDR .FILL xFE00
.end





.orig x3400 ;;push_val(int val)implement your push function that will push a value onto the stack
    ADD R6, R6, #-1         ;push into stack
    STR R7, R6, #0          ;r7 memory location
    ADD R6, R6, #-1
    STR R1, R6, #0          ;r1 value pushed
    
    RET
.end


.orig x3800 ;; add_val() pops two values from the top of the stack and pushes the result of adding the poppped value into the stack
ST R3, BACKUP_R3_3800
ST R7, BACKUP_R7_3800
    
    ;pop out of stack
    LDR R1, R6, #0          ;store value from stack to registers
    STR R3,R6,#0            ;clear the stack address
    ADD R6, R6, #1          
    LDR R7, R6, #0          ;store address from stack to registers
    STR R3,R6,#0            ;clear the stack address
    ADD R6, R6, #1
    
    AND R4,R4,#0            ;clear register
    ADD R4,R4,R1            ;add value to R4
    
    ;pop out of stack
    LDR R1, R6, #0          ;store value from stack to registers
    STR R3,R6,#0            ;clear the stack address
    ADD R6, R6, #1
    LDR R7, R6, #0          ;store address from stack to registers
    STR R3,R6,#0            ;clear the stack address
    ADD R6, R6, #1
    
    ADD R4,R4,R1            ;add value to R4
    
    AND R1,R1,#0            ;push the new value to the stack
    ADD R1,R1,R4
    LD R5, push_val_3800
    JSRR R5
    ;ADD R6, R6, #-1        ;push into stack
    ;STR R7, R6, #0         ;r7 = return addr
    ;ADD R6, R6, #-1
    ;STR R4, R6, #0
    
LD R3, BACKUP_R3_3800
LD R7, BACKUP_R7_3800

ret

BACKUP_R3_3800 .BLKW #1
BACKUP_R7_3800 .BLKW #1
push_val_3800 .FILL x3400
.end



.orig x4200 ;;data you might need

.end

