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

    ; Load initial values
    fld root
    fld oldRoot

iteration:
    ; Calculate the absolute difference between root and oldRoot
    ; |root - oldRoot|
    fld ST(0)
    fsub ST(0), ST(1)
    fabs

    ; Check if the difference is less than smallValue
    ; If |root - oldRoot| < smallValue, exit the loop
    fld smallValue
    fcom		; ST(0) ? ST(1)
    fstsw AX
    sahf
    jb exit_loop

    ; Update oldRoot with the current root value
    fstp oldRoot
    fld root

    ; Calculate new root: (2.0 * root + x / (root * root)) / 3.0
    fld two
    fmul ST(0), ST(1)
    fld x
    fld ST(2)
    fmul ST(0), ST(1)
    fdivr
    fadd
    fld three
    fdivr

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
