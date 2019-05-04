<<<<<<< HEAD
.8086
.model	small
.stack	2048

DADOS	SEGMENT PARA 'DATA'

    Menu            db      './files/menu.txt',0
	newgame			db		'./files/newGame.txt',0
	ShowStats		db		'./files/stats.txt',0
	Credits			db		'./files/credits.txt',0
	GameOver		db		'./files/gameOver.txt',0
	GameWon			db		'./files/gameWon.txt',0
    Erro_Open       db      'Erro ao tentar abrir o ficheiro$'
    Erro_Ler_Msg    db      'Erro ao tentar ler do ficheiro$'
    Erro_Close      db      'Erro ao tentar fechar o ficheiro$'
    HandleFich      dw      0
    car_fich        db      ?

	POSy			db	10	; a linha pode ir de [1 .. 25]
	POSx			db	40	; POSx pode ir [1..80]	
	POSya			db	5	; Posição anterior de y
	POSxa			db	10	; Posição anterior de x

	PASSA_T			dw	0
	PASSA_T_ant		dw	0
	direccao		db	3
	
	Centesimos		dw 	0
	FACTOR			db	100
	metade_FACTOR	db	?
	resto			db	0

DADOS	ENDS

CODIGO	SEGMENT PARA 'CODE'
	ASSUME CS:CODIGO, DS:DADOS

;------------------------------------------------------------------------
; Colocar o cursor na posição posx, posy
;  > param: posx - coluna, posy - lina 
;------------------------------------------------------------------------
GOTO_XY		MACRO	POSX,POSY
			MOV	AH,02H
			MOV	BH,0
			MOV	DL,POSX
			MOV	DH,POSY
			INT	10H
ENDM



Imp_Fich	PROC
;abre ficheiro
		call 	APAGA_ECRAN
        mov     ah,3dh			; vamos abrir ficheiro para leitura 
        mov     al,0			; tipo de ficheiro	
        ;lea     dx, Menu		; nome do ficheiro
        int     21h				; abre para leitura 
        jc      erro_abrir		; pode aconter erro a abrir o ficheiro 
        mov     HandleFich,ax	; ax devolve o Handle para o ficheiro 
        jmp     ler_ciclo		; depois de abero vamos ler o ficheiro 

erro_abrir:
        mov     ah,09h
        lea     dx,Erro_Open
        int     21h
        jmp     sai

ler_ciclo:
        mov     ah,3fh			; indica que vai ser lido um ficheiro 
        mov     bx,HandleFich	; bx deve conter o Handle do ficheiro previamente aberto 
        mov     cx,1			; numero de bytes a ler 
        lea     dx,car_fich		; vai ler para o local de memoria apontado por dx (car_fich)
        int     21h				; faz efectivamente a leitura
	    jc	    erro_ler			; se carry é porque aconteceu um erro
	    cmp	    ax,0				; EOF?	verifica se já estamos no fim do ficheiro 
	    je	    fecha_ficheiro		; se EOF fecha o ficheiro 
        mov     ah,02h			; coloca o caracter no ecran
	    mov	    dl,car_fich			; este é o caracter a enviar para o ecran
	    int	    21h					; imprime no ecran
	    jmp	    ler_ciclo			; continua a ler o ficheiro

erro_ler:
        mov     ah,09h
        lea     dx,Erro_Ler_Msg
        int     21h

fecha_ficheiro:					; vamos fechar o ficheiro 
        mov     ah,3eh
        mov     bx,HandleFich
        int     21h
        jnc     sai

        mov     ah,09h			; o ficheiro pode não fechar correctamente
        lea     dx,Erro_Close
        Int     21h
sai:	  RET
Imp_Fich	endp


;ROTINA PARA APAGAR ECRAN
APAGA_ECRAN	PROC
		PUSH BX
		PUSH AX
		PUSH CX
		PUSH SI
		XOR	BX,BX
		MOV	CX,24*80
		mov bx,160
		MOV SI,BX
APAGA:	
		MOV	AL,' '
		MOV	BYTE PTR ES:[BX],AL
		MOV	BYTE PTR ES:[BX+1],7
		INC	BX
		INC BX
		INC SI
		LOOP	APAGA
		POP SI
		POP CX
		POP AX
		POP BX
		RET
APAGA_ECRAN	ENDP



;********************************************************************************
; LEITURA DE UMA TECLA DO TECLADO    (ALTERADO)
; LE UMA TECLA	E DEVOLVE VALOR EM AH E AL
; SE ah=0 É UMA TECLA NORMAL
; SE ah=1 É UMA TECLA EXTENDIDA
; AL DEVOLVE O CÓDIGO DA TECLA PREMIDA
; Se não foi premida tecla, devolve ah=0 e al = 0
;********************************************************************************
LE_TECLA_0	PROC

	;	call 	Trata_Horas
		MOV	AH,0BH
		INT 	21h
		cmp 	AL,0
		jne	com_tecla
		mov	AH, 0
		mov	AL, 0
		jmp	SAI_TECLA
com_tecla:		
		MOV	AH,08H
		INT	21H
		MOV	AH,0
		CMP	AL,0
		JNE	SAI_TECLA
		MOV	AH, 08H
		INT	21H
		MOV	AH,1
SAI_TECLA:	
		RET
LE_TECLA_0	ENDP



PASSA_TEMPO PROC	
 
		
		MOV AH, 2CH             ; Buscar a hORAS
		INT 21H                 
		
 		XOR AX,AX
		MOV AL, DL              ; centesimos de segundo para ax		
		mov Centesimos, AX
	
		mov bl, factor		; define velocidade da snake (100; 50; 33; 25; 20; 10)
		div bl
		mov resto, AH
		mov AL, FACTOR
		mov AH, 0
		mov bl, 2
		div bl
		mov metade_FACTOR, AL
		mov AL, resto
		mov AH, 0
		mov BL, metade_FACTOR	; deve ficar sempre com metade do valor inicial
		mov AH, 0	
		cmp AX, BX
		jbe Menor
		mov AX, 1
		mov PASSA_T, AX	
		jmp fim_passa	
		
Menor:		mov AX,0
		mov PASSA_T, AX		

fim_passa:	 

 		RET 
PASSA_TEMPO   ENDP 


menu_controller PROC

show_main_menu:

	lea		dx, Menu
	call	Imp_Fich

	call 	get_menu_option

	cmp		al, '1'
	je		gameopts
	
	cmp 	al, '2'
	je 		stats
	
	cmp 	al, '3'
	je 		madeby
	
	cmp		al, '4'
	je		fim
	jmp		show_main_menu

gameopts:

	lea		dx,	newGame
	call	Imp_Fich

gameopts_wrong_input:

	call 	get_menu_option

	cmp		al, '1'
	je		show_main_menu		; Classic Game

	cmp		al, '2'
	je		show_main_menu 		; Bonus Game

	cmp 	al, '3'
	je		show_main_menu

	jmp		gameopts_wrong_input

stats:
	lea		dx, ShowStats
	call	Imp_Fich

stats_wrong_input:

	call 	get_menu_option

	; Game History
	cmp		al, '1'
	jmp 	show_main_menu

	; Statistical Values
	cmp		al, '2'
	jmp		show_main_menu

	cmp		al, '3'
	jmp 	show_main_menu

	jmp		stats_wrong_input


madeby:

	lea 	dx, Credits
	call	Imp_Fich

	mov		ah, 07h
	int 	21h
	jmp		show_main_menu


menu_controller endp

get_menu_option PROC
	mov			POSX, 21
	mov			POSY, 22
	goto_xy		POSx,POSy	; Vai para posição do cursor
	
	; mov			ah, 02h
	; mov			dx, '>'	
	; int			21h
	
	; inc 		POSX
	; goto_xy 	POSX, POSY

	mov			ah,	07h
	int			21h

	ret

get_menu_option endp

INICIO:
	mov     	ax, DADOS
	mov     	ds, ax
	MOV			AX,0B800H 		; (?)
	MOV			ES,AX			; (?)	; ES indica segmento de memória de VIDEO
	CALL 		APAGA_ECRAN
	call		menu_controller



fim:	mov     ah,4ch
	int     21h


CODIGO	ENDS
END	INICIO