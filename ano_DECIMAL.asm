;CODIGO PARA LA IMPRESION DE LA FECHA
;CX = ANIO  DH = MES   DL = DIA   AL = DIA DE LA SEMANA
IMP_CAD MACRO TXT    
    MOV AH, 09H     ;IMPRESION DE TXT
    LEA DX, TXT
    INT 21H
IMP_CAD ENDM

CODE:
    MOV AH, 00H     ;SERVICIO PARA ESTABLECER EL MODO DE VIDEO
    MOV AL, 02H     ;= Modo de video 80X25
    INT 10H

    MOV AH, 06H
    MOV AL, 00H     ; 0 = Borra
    MOV BH, 00AH    
    MOV CX, 00H     ;POSICION INICIAL A BORRAR  
    MOV DH, 24      ;POSICION FINAL A BORRAR
    MOV DL, 79
    INT 10H
       
    MOV AH, 02H     ; POSICIONAR EL CURSOR
    MOV BH, 0       ; PAGINA ACTUAL
    MOV DH, 12      ; = Fila
    MOV DL, 20      ; = Columna
    INT 10H

    IMP_CAD TXT1
    
    MOV AH, 2AH     ;SERVICIO DE FECHA
    INT 21H
    
    MOV DIA, DL     ;GUARDAMOS EL DIA 
    MOV MES, DH     ;GUARDAMOS EL MES
    MOV OFFSET YEAR, CX ;GUARDAMOS EL ANIO
    ;EN AL ESTA EL DIA DE LA SEMANA
    
    CMP AL, 1       ;COMPARACIONES DE LUN - DOM
    JGE VERXLUNES
    IMP_CAD DOM
    JMP IMP_DIA
    
VERXLUNES:
    CMP AL, 2
    JGE VERXMARTES
    IMP_CAD LUN
    JMP IMP_DIA 
    
VERXMARTES:
    CMP AL, 3
    JGE VERXMIERCOLES
    IMP_CAD MAR
    JMP IMP_DIA
    
VERXMIERCOLES:
    CMP AL, 4
    JGE VERXJUEVES
    IMP_CAD MIE
    JMP IMP_DIA
    
VERXJUEVES:
    CMP AL, 5
    JGE VERXVIERNES
    IMP_CAD JUE
    JMP IMP_DIA

VERXVIERNES:
    CMP AL, 6
    JGE VERXSABADO
    IMP_CAD VIE
    JMP IMP_DIA
    
VERXSABADO:
    IMP_CAD SAB
    JMP IMP_DIA
    
IMP_DIA:
        
    MOV AL, [DIA]
    MOV CL, 10
    MOV AH, 0
    DIV CL   
    
    OR AX, 3030H ;CORVERTIR A ASCII
    MOV BX, OFFSET DIAASCII
    MOV [BX], AL
    INC BX
    MOV [BX], AH
     
    ;ESTO MANDA A IMPRIMIR
    MOV AH, 09
    MOV DX, OFFSET DIAASCII
    INT 21H

       
    
    IMP_CAD TXT2    ;IMP DE
    
    MOV AL, MES
    CMP AL, 1       ;COMPARACIONES DE ENERO - DICIEMBRE
    JE IMP_ENERO
    CMP AL, 2
    JE IMP_FEBRERO
    CMP AL, 3
    JE IMP_MARZO
    CMP AL, 4
    JE IMP_ABRIL
    CMP AL, 5
    JE IMP_MAYO
    CMP AL, 6
    JE IMP_JUNIO
    CMP AL, 7
    JE IMP_JULIO
    CMP AL, 8
    JE IMP_AGOSTO
    CMP AL, 9
    JE IMP_SEPTIEMBRE
    CMP AL, 10
    JE IMP_OCTUBRE
    CMP AL, 11
    JE IMP_NOVIEMBRE
    CMP AL, 12
    JE IMP_DICIEMBRE
    
     
    
    
IMP_ENERO:          ;IMPRESIONES DE MES
    IMP_CAD ENE
    JMP ANIO
IMP_FEBRERO:
    IMP_CAD FEB
    JMP ANIO
IMP_MARZO:
    IMP_CAD MARZ
    JMP ANIO
IMP_ABRIL:
    IMP_CAD ABR
    JMP ANIO
IMP_MAYO:
    IMP_CAD MAY
    JMP ANIO
IMP_JUNIO:
    IMP_CAD JUN
    JMP ANIO
IMP_JULIO:
    IMP_CAD JUL
    JMP ANIO
IMP_AGOSTO:
    IMP_CAD AGO
    JMP ANIO
IMP_SEPTIEMBRE:
    IMP_CAD SEP
    JMP ANIO
IMP_OCTUBRE:
    IMP_CAD OCT
    JMP ANIO
IMP_NOVIEMBRE:
    IMP_CAD NOV
    JMP ANIO
IMP_DICIEMBRE:
    IMP_CAD DIC
    JMP ANIO
    
ANIO:


IMP_CAD TXT3    ;IMP DE

    MOV BX, OFFSET YEAR 
    MOV AX, [BX]
    MOV CL, 10
    DIV CL
    MOV DIG1, AH
    MOV AH, 0
    MOV CL, 10
    DIV CL
    MOV DIG2, AH
    MOV AH, 0
    MOV CL, 10
    DIV CL
    MOV DIG3, AH
    MOV AH, 0
    MOV CL, 10
    DIV CL
    MOV DIG4, AH
    OR DIG4, 30H
    OR DIG3, 30H
    OR DIG2, 30H
    OR DIG1, 30H       
       
    MOV AH, 09
    MOV DX, OFFSET DIG4
    INT 21H
    MOV DX, OFFSET DIG3
    INT 21H
    MOV DX, OFFSET DIG2
    INT 21H
    MOV DX, OFFSET DIG1
    INT 21h
    
INT 20H             ;FIN DEL PROGRAMA
    
        
   

 
    
    TXT1 DB 'Hoy es $'
    TXT2 DB ' de $' 
    TXT3 DB 'del $'
    
    DIA DB ?, '$'
    MES DB ?
    NUM DB ?
    DOM DB 'domingo $'
    LUN DB 'lunes $'
    MAR DB 'martes $'
    MIE DB 'miercoles $'
    JUE DB 'jueves $'
    VIE DB 'viernes $'
    SAB DB 'sabado $'
    
    ENE DB 'enero $'
    FEB DB 'febrero $'
    MARZ DB 'marzo $'
    ABR DB 'abril $'
    MAY DB 'mayo $'
    JUN DB 'junio $'
    JUL DB 'julio $'
    AGO DB 'agosto $'
    SEP DB 'septiembre $'
    OCT DB 'octubre $'
    NOV DB 'noviembre $'
    DIC DB 'diciembre $'
    
          
    DIG1 DB ?, '$'
    DIG2 DB ?, '$'
    DIG3 DB ?, '$'
    DIG4 DB ?, '$'  
    YEAR DB ?, ?, '$'
    
    DIAASCII DB ?, ?, '$'
    
    
    