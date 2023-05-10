# CubeRootMASM80x86
Cube Root Approximation in 80x86 Assembly with MASM Syntax
==========================================================

Description
-----------
This program calculates the approximate cube root of a given real number using an iterative method. It is written in 80x86 assembly language using MASM syntax.

Algorithm
---------
1. Initialize root as 1.0
2. Calculate new root as (2.0*root + x/(root*root)) / 3.0
3. Check if the absolute difference between the old root and the new root is less than a smallValue (0.001)
4. If not, update the old root with the new root and go back to step 2

Usage
-----
1. Assemble and link the program using a MASM-compatible assembler and linker.
2. Integrate the "_main" procedure into your larger assembly or C/C++ program by calling it and accessing the "root" variable to retrieve the result.

Note
----
This is a console-less version of the program, as writing console I/O operations in assembly language would make the program much more complex. To use this program, you can call the "_main" label to execute the cube root approximation procedure and access the "root" variable to retrieve the result.

Variables
---------
The program uses the following variables:

x          - The real number for which the cube root will be approximated
smallValue - The threshold value to determine when the approximation is close enough
root       - The current approximation of the cube root
oldRoot    - The previous approximation of the cube root
two        - Constant value 2.0
three      - Constant value 3.0

Modify the value of 'x' in the .DATA section to change the input number for cube root approximation.
