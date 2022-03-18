# Assembly Date Printer Projects

This repository contains two projects written in assembly language that print the current date on the screen. Each project uses a different method to handle and display the date.

## Project 1: Date Printer with Hexadecimal Conversion

This project prints the current date on the screen by converting the date values from hexadecimal to ASCII format. It utilizes BIOS and DOS interrupts for video and text output. The project includes macros and procedures to handle date conversion and printing.

### Key Features

- **Video Mode Setup**: Configures the screen to 80x25 text mode.
- **Screen Clearing**: Clears a specified area of the screen.
- **Cursor Positioning**: Moves the cursor to the desired location for date output.
- **Date Retrieval**: Uses DOS interrupt to get the current date.
- **Day and Month Printing**: Compares and prints the day of the week and month names.
- **Hexadecimal to ASCII Conversion**: Converts hexadecimal date values to ASCII for printing.

### Code Snippet

```asm
CONV_HEX_ASCII PROC ; Procedure to convert hexadecimal to ASCII
    CMP NUM, 09H     ; Check if number is greater than 9
    JG SUMAR37
    ADD NUM, 30H
    JMP PRINT
SUMAR37:
    ADD NUM, 37H
PRINT:  
    MOV AH, 02H
    MOV DL, NUM
    INT 21H
    RET
CONV_HEX_ASCII ENDP
```
### Usage

1.  Assemble and link the code using an assembler (e.g., TASM, MASM).
2.  Run the executable to display the current date on the screen.

## Project 2: Date Printer with Decimal Conversion

This project prints the current date on the screen by converting the date values from decimal to ASCII format. It also uses BIOS and DOS interrupts for video and text output and includes macros and procedures for date handling.

### Key Features

-   **Video Mode Setup**: Configures the screen to 80x25 text mode.
-   **Screen Clearing**: Clears a specified area of the screen.
-   **Cursor Positioning**: Moves the cursor to the desired location for date output.
-   **Date Retrieval**: Uses DOS interrupt to get the current date.
-   **Day and Month Printing**: Compares and prints the day of the week and month names.
-   **Decimal to ASCII Conversion**: Converts decimal date values to ASCII for printing.

### Code Snippet

```assembly
MOV AL, [DIA]
MOV CL, 10
MOV AH, 0
DIV CL
OR AX, 3030H ; Convert to ASCII
MOV BX, OFFSET DIAASCII
MOV [BX], AL
INC BX
MOV [BX], AH

; Print the ASCII values
MOV AH, 09
MOV DX, OFFSET DIAASCII
INT 21H
```