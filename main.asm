; general comments

; preprocessor directives
.586
.MODEL FLAT

; stack configuration
.STACK 4096

; Cube root approximation program for 80x86 using MASM syntax

.DATA
x REAL4 21.31
smallValue REAL4 0.001
root REAL4 1.0
oldRoot REAL4 0.0
two REAL4 2.0
three REAL4 3.0

.CODE
_main PROC
    ; Initialize FP
    finit



iteration:
    ; Calculate the absolute difference between root and oldRoot
    ; |root - oldRoot|
    ; Load initial values
    fld root
    fld oldRoot
    fsub ST(0), ST(1)
    fabs

    ; Check if the difference is less than smallValue
    ; If |root - oldRoot| < smallValue, exit the loop
    fld smallValue
    fcom		; ST(0) ? ST(1)
    fstsw AX
    sahf
    ja exit_loop

    ; Calculate new root: (2.0 * root + x / (root * root)) / 3.0
    fld two         ; Load constant 2.0 onto the FPU stack
    fmul ST(0), ST(1) ; Multiply ST(0) by ST(1), ST(0) now holds 2.0 * root
    fld x           ; Load x onto the FPU stack
    fadd            ; st(0) holds 2rootx
    fld root        ; Load root 
    fld root        ; st(0,1) hold root
    fmul            ; Multiply ST(0) by ST(1), ST(0) now holds root * root
    fdivr           ; Divide 2root+x by (root * root), ST(0) now holds 2root+x / (root * root)
    fld three       ; Load constant 3.0 onto the FPU stack
    fdivr           ; Divide ST(1) by ST(0), ST(0) now holds the new root

    ; Adjust the FPU stack
    
    fld root     ; oldRoot (previously root) in ST(0), root in ST (1)      
    fstp oldRoot
    fstp root

    ; Continue the iteration
    jmp iteration

exit_loop:
    ; Store the final root value
    fstp root

    ; Clean up and exit
    finit
    ret

_main ENDP
END
