.8086
.model	small
.stack	2048

DADOS	SEGMENT PARA 'DATA'

	; :::::::::::::::::: Files in Memory ::::::::::::::::::
		Menu            db      './files/menu.txt',0
		newgame			db		'./files/newGame.txt',0
		ClassicGame		db		'./files/moldura.txt',0
		cDifficulty		db		'./files/choose.txt',0
		ShowStats		db		'./files/stats.txt',0
		Credits			db		'./files/credits.txt',0
		GameOver		db		'./files/gameOver.txt',0
		AreUSure		db		'./files/YouSure.txt',0
		TutorialFile	db 		'./files/tutorial.txt',0
    ; :::::::::::::::::: Ficheiros em Memória ::::::::::::::::::

	; :::::::::::::::::: File Handles ::::::::::::::::::
		Erro_Open       db      'Erro ao tentar abrir o ficheiro$'
		Erro_Ler_Msg    db      'Erro ao tentar ler do ficheiro$'
		Erro_Close      db      'Erro ao tentar fechar o ficheiro$'
		HandleFich      dw      0
		car_fich        db      ?
	; :::::::::::::::::: File Handles ::::::::::::::::::

	; :::::::::::::::::: Handles ::::::::::::::::::
		pontos			db		0
		str_aux			db		10 dup(?)
	; :::::::::::::::::: Handles ::::::::::::::::::

	; :::::::::::::::::: Warnings ::::::::::::::::::
		Erro_Input		db		'WARNING: Input invalido (Press any key to continue...) $'
	; :::::::::::::::::: Warnings ::::::::::::::::::

	; :::::::::::::::::: Cobra Utils ::::::::::::::::::
		tam				db 		1
		cobra			dw		20 dup($) ; Ah - eixo x & Al - eixo y
		head			dw		?	; AH - x cord / AL - y cord
		tail 			dw		?	; AH - x cord / AL - y cord
	; :::::::::::::::::: Cobra Utils ::::::::::::::::::

		difficulty		db		? 	; (?)

		POSy			db		10	; a linha pode ir de [1 .. 25]
		POSx			db		40	; POSx pode ir [1..80]	
		POSya			db		5	; Posição anterior de y
		POSxa			db		10	; Posição anterior de x
		POSxPont		db		30
		POSyPont		db		23
		

		PASSA_T			dw		0
		PASSA_T_ant		dw		0
		direccao		db		3
		
		Centesimos		dw 		0
		FACTOR			db		100
		metade_FACTOR	db		?
		resto			db		0

		ultimo_num_aleat dw 	0
		maca			db		0

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


; :::::::::::::::::: Imprimir Ficheiro para STDOUT ::::::::::::::::::
; author: Professor
Imp_Fich	PROC
;abre ficheiro
		call 	clear_screen
        mov     ah,3dh				; vamos abrir ficheiro para leitura 
        mov     al,0				; tipo de ficheiro
        int     21h					; abre para leitura 
        jc      erro_abrir			; pode aconter erro a abrir o ficheiro 
        mov     HandleFich,ax		; ax devolve o Handle para o ficheiro 
        jmp     ler_ciclo			; depois de abero vamos ler o ficheiro 

erro_abrir:
        mov     ah,09h
        lea     dx,Erro_Open
        int     21h
        jmp     sai

ler_ciclo:
        mov     ah,3fh				; indica que vai ser lido um ficheiro 
        mov     bx,HandleFich		; bx deve conter o Handle do ficheiro previamente aberto 
        mov     cx,1				; numero de bytes a ler 
        lea     dx,car_fich			; vai ler para o local de memoria apontado por dx (car_fich)
        int     21h					; faz efectivamente a leitura
	    jc	    erro_ler			; se carry é porque aconteceu um erro
	    cmp	    ax,0				; EOF?	verifica se já estamos no fim do ficheiro 
	    je	    fecha_ficheiro		; se EOF fecha o ficheiro 
        mov     ah,02h				; coloca o caracter no ecran
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
; :::::::::::::::::: Imprimir Ficheiro para STDOUT ::::::::::::::::::

; :::::::::::::::::: ROTINA PARA APAGAR ECRAN ::::::::::::::::::
; author: Professor
clear_screen	PROC
		PUSH BX
		PUSH AX
		PUSH CX
		PUSH SI
		XOR	BX,BX
		MOV	CX, 24*80
		mov bx, 160
		MOV SI,BX
clear:	
		MOV	AL, ' '
		MOV	BYTE PTR ES:[BX],AL
		MOV	BYTE PTR ES:[BX+1],7
		INC	BX
		INC BX
		INC SI
		LOOP	clear
		POP SI
		POP CX
		POP AX
		POP BX
		RET
clear_screen	ENDP
; :::::::::::::::::: ROTINA PARA APAGAR ECRAN ::::::::::::::::::


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
		MOV		AH,0BH
		INT 	21h
		cmp 	AL,0
		jne		com_tecla
		mov		AH, 0
		mov		AL, 0
		jmp		SAI_TECLA
		
com_tecla:		
		MOV		AH,08H
		INT		21H
		MOV		AH,0
		CMP		AL,0
		JNE		SAI_TECLA
		MOV		AH, 08H
		INT		21H
		MOV		AH,1
SAI_TECLA:	
		RET
LE_TECLA_0	ENDP


; :::::::::::::::::: Passa Tempo ::::::::::::::::::
; author: Professor
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
; :::::::::::::::::: Passa Tempo ::::::::::::::::::

; :::::::::::::::::: Controlador do Menu ::::::::::::::::::
menu_controller PROC
	xor		ax,	ax
	xor		dx,	dx

show_main_menu:
		lea		dx, Menu
		call	Imp_Fich

		call 	get_menu_option

		cmp		al, '0'
		je		tutorial

		cmp		al, '1'
		je		gameopts
		
		cmp 	al, '2'
		je 		stats
		
		cmp 	al, '3'
		je 		madeby
		
		cmp		al, '4'
		je		fim

		call	wrong_input
		jmp		show_main_menu

tutorial:
		lea		dx,	TutorialFile
		call	Imp_Fich				; imprime o ficheiro corresponde ao tutorial
		call	get_menu_option
		jmp		show_main_menu          ; volta ao menu principal

gameopts:
		lea		dx,	newGame				; imprime o ficheiro corresponde ao menu de jogo
		call	Imp_Fich

	gameopts_wrong_input:

		call 	get_menu_option			; Lê opção inserida pelo jogador

		cmp		al, '1'
		je 		classic_game

		cmp		al, '2'
		je		show_main_menu 			; Bonus Game

		cmp 	al, '3'
		je		show_main_menu
 
		call 	wrong_input
		jmp		gameopts

classic_game:
	lea		dx,	cDifficulty			; imprime o ficheiro corresponde à escolha da dificuldade
	call	Imp_Fich

	call 	get_menu_option			; le opcao do jogador

	cmp 	al , '1'
	je 		slug

	cmp 	al, '2'
	je		hare

	cmp		al, '3'
	je		cheetah

	cmp		al,	'4'
	je		gameopts

	call	wrong_input
	jmp		classic_game

	slug: 
		mov factor, 100
		jmp game_start

	hare:
		mov factor, 50
		jmp game_start

	cheetah:
		mov factor, 25
		jmp game_start

	game_start:
		call 	start_game
		jmp		show_main_menu

stats:
		lea		dx, ShowStats
		call	Imp_Fich

		call 	get_menu_option

		; Game History
		cmp		al, '1'
		jmp 	show_main_menu

		; Statistical Values
		cmp		al, '2'
		jmp		show_main_menu

		cmp		al, '3'
		jmp 	show_main_menu

		call	wrong_input
		jmp		stats

madeby:
		lea 	dx, Credits
		call	Imp_Fich

		mov		ah, 07h
		int 	21h
		jmp		show_main_menu

game_over:
		lea			dx,	gameOver
		call		Imp_Fich

		call		get_menu_option
		cmp			al, '1'
		je			classic_game
		cmp			al, '2'
		je			fim


menu_controller endp
; :::::::::::::::::: Controlador do Menu ::::::::::::::::::

; :::::::::::::::::: Obter Opção ::::::::::::::::::
get_menu_option PROC
	goto_xy		21, 20			; Vai para posição do cursor
	mov			ah,	07h
	int			21h
	cmp			al, 1Bh			; ESC - Fast Ending
	je			close
	ret

close:
	call		clear_screen
	jmp			fim

get_menu_option endp
; :::::::::::::::::: Obter Opção ::::::::::::::::::

; :::::::::::::::::: Movimento da Cobra ::::::::::::::::::
move_snake PROC
CICLO:
	;call		mostra_pontuacao 	; Mostra prontuação
	goto_xy		POSx,POSy			; Vai para nova possição
	mov 		ah, 08h				; Guarda o Caracter que está na posição do Cursor
	mov			bh,0				; numero da página
	int			10h

	cmp 		al, '#'				;  na posição do Cursor
	je			fim_jogo
	cmp 		al, 'V'
	je			maca_verde
	cmp			al, 'M'
	je 			maca_madura
	cmp			al, 'R'
	je			rato
	jmp cont_ciclo

maca_verde:
	inc maca
	jmp cont_ciclo

maca_madura:
	add maca, 2
	jmp cont_ciclo

rato:


cont_ciclo:
		cmp maca, 0					; @Andre pq que fazes esta verificação ?
		ja dec_maca

	;; Limpar o rasto da cabeça da cobra

		goto_xy		POSxa,POSya		; Vai para a posição anterior do cursor
		mov			ah, 02h
		mov			dl, ' ' 		; Coloca ESPAÇO
		int			21H	

		inc			POSxa
		goto_xy		POSxa,POSya	
		mov			ah, 02h
		mov			dl, ' '			;  Coloca ESPAÇO
		int			21H	
		dec 		POSxa

		goto_xy		POSx,POSy		; Vai para posição do cursor

IMPRIME:

	;; Atualizar a cabeça da cobra

		mov			ah, 02h
		mov			dl, '('			; Coloca AVATAR1
		int			21H
		
		inc			POSx
		goto_xy		POSx,POSy		
		mov			ah, 02h
		mov			dl, ')'			; Coloca AVATAR2
		int			21H	
		dec			POSx
		
		goto_xy		POSx,POSy		; Vai para posição do cursor
		
		mov			al, POSx		; Guarda a posição do cursor
		mov			POSxa, al
		mov			al, POSy		; Guarda a posição do cursor
		mov			POSya, al
		
LER_SETA:	
		call 		LE_TECLA_0
		cmp			ah, 1
		je			ESTEND
		CMP 		AL, 27			; ESCAPE
		jne			TESTE_END
		call		are_you_sure_about_that
TESTE_END:		
		CALL		PASSA_TEMPO
		mov			AX, PASSA_T_ant
		CMP			AX, PASSA_T
		je			LER_SETA
		mov			AX, PASSA_T
		mov			PASSA_T_ant, AX
		
verifica_0:	
		mov			al, direccao
		cmp 		al, 0
		jne			verifica_1
		inc			POSx		;Direita
		inc			POSx		;Direita
		jmp			CICLO
		
verifica_1:	
		mov 		al, direccao
		cmp			al, 1
		jne			verifica_2
		dec			POSy		;cima
		jmp			CICLO
		
verifica_2:	
		mov 		al, direccao
		cmp			al, 2
		jne			verifica_3
		dec			POSx		;Esquerda
		dec			POSx		;Esquerda
		jmp			CICLO
		
verifica_3:	
		mov 		al, direccao
		cmp			al, 3		
		jne			CICLO
		inc			POSy		;BAIXO		
		jmp			CICLO
		
ESTEND:		
		cmp 		al,48h
		jne			BAIXO
		mov			direccao, 1
		jmp			CICLO

BAIXO:		
		cmp			al,50h
		jne			ESQUERDA
		mov			direccao, 3
		jmp			CICLO

ESQUERDA:
		cmp			al,4Bh
		jne			DIREITA
		mov			direccao, 2
		jmp			CICLO

DIREITA:
		cmp			al,4Dh
		jne			LER_SETA 
		mov			direccao, 0	
		jmp			CICLO

fim_jogo:		
		call		clear_screen
		jmp			game_over;
		RET

dec_maca:
		dec 		maca
		jmp 		imprime

move_snake ENDP
; :::::::::::::::::: Movimento da Cobra ::::::::::::::::::

; :::::::::::::::::: Mostra Pontuação ::::::::::::::::::
mostra_pontuacao proc
	goto_xy		POSxPont,	POSyPont 	; vai para a posição da pontuação
	xor			dx,	dx
	mov			dl, pontos
	mov			str_aux[0],	dl    	 	; passar o nr para a string aux
	mov			str_aux[1], '$'			; pq a interrupcao procura o fim da string pelo '$'
	;mostra		str_aux					; syntax error ?
	goto_xy 	POSX, POSY				; volta para a posição antiga
mostra_pontuacao endp
; :::::::::::::::::: Mostra Pontuação ::::::::::::::::::

; :::::::::::::::::: MACRO Imprime String ::::::::::::::::::
; macro para imprimir uma string no stdout
; params - recebe a string que vai imprimir
mostra MACRO str
	mov		ah, 09h
	lea		dx,	str
	int		21h	
endm
; :::::::::::::::::: MACRO Imprime String ::::::::::::::::::

; :::::::::::::::::: Imprime avisos de wrong input ::::::::::::::::::
wrong_input proc
		goto_xy 14,22			; Vai para a posição de aviso
        mov     ah,09h
        lea     dx,Erro_Input	; coloca a mensagem de erro no registo necessário
        int     21h				; chama a int para imprimir no stdout
		goto_xy	posx, posy		; volta para a posição antiga do cursor
		call 	get_menu_option
		call	clear_screen
		ret
wrong_input endp
; :::::::::::::::::: Imprime avisos de wrong input ::::::::::::::::::

; :::::::::::::::::: Calcula Aleatorio ::::::::::::::::::
; author: Professor
; CalcAleat - calcula um numero aleatorio de 16 bits
; Parametros passados pela pilha
; entrada:
; n�o tem parametros de entrada
; saida:
; param1 - 16 bits - numero aleatorio calculado
; notas adicionais:
; deve estar definida uma variavel => ultimo_num_aleat dw 0
; assume-se que DS esta a apontar para o segmento onde esta armazenada ultimo_num_aleat
CalcAleat proc near

	sub		sp,2		; 
	push	bp
	mov		bp,sp
	push	ax
	push	cx
	push	dx	
	mov		ax,[bp+4]
	mov		[bp+2],ax

	mov		ah,00h
	int		1ah

	add		dx,ultimo_num_aleat	; vai buscar o aleat�rio anterior
	add		cx,dx
	mov		ax,65521
	push	dx
	mul		cx			
	pop		dx			 
	xchg	dl,dh
	add		dx,32749
	add		dx,ax

	mov		ultimo_num_aleat,dx	; guarda o novo numero aleat�rio  

	mov		[BP+4],dx		; o aleat�rio � passado por pilha

	pop		dx
	pop		cx
	pop		ax
	pop		bp
	ret

CalcAleat endp
; :::::::::::::::::: Calcula Aleatorio ::::::::::::::::::

; :::::::::::::::::: Gera Coordenada de X válida ::::::::::::::::::
; Devolve em ax um numero valido de 8 bits
; param : recebe em dl um aleatorio de 8 bits
; NOTA: devolve sempre a mini celula da esquerda
valid_Xcoord proc
	xor 	ax,	ax
	xor		bx, bx
	xor		cx, cx
	cmp		dl, 33
	jg		invalid
	cmp		dl, 2
	jb		invalid
	ret

invalid:
	mov		al, dl
	mov		cl, 33
	mul		cl
	mov		cl, 255
	div		cl
	add		al, 2 			; garantir que o nr e superior a 2
	mov		posx, al
	ret
valid_Xcoord endp
; :::::::::::::::::: Gera Coordenada de X válida ::::::::::::::::::

; :::::::::::::::::: Gera Coordenada de Y válida ::::::::::::::::::
valid_Ycoord proc
	xor		ax,	ax
	xor		bx, bx
	xor 	cx, cx
	cmp		dl, 22
	jg		invalid_0
	cmp		dl, 2
	jb		invalid_0
	ret
invalid_0:
	mov		al, dl
	mov		cl, 22
	mul		cl
	mov		cl, 255
	div		cl
	add		al, 2
	mov		posy, al
	ret
valid_Ycoord endp
; :::::::::::::::::: Gera Coordenada de Y válida ::::::::::::::::::

; :::::::::::::::::: Start Game ::::::::::::::::::
start_game proc
	lea		dx, ClassicGame
	call	Imp_Fich
	xor		ax,	ax
	xor		bx, bx
	call 	CalcAleat
	mov		dx,	ultimo_num_aleat
	call	valid_Xcoord
	mov		dx, ultimo_num_aleat
	call	valid_Ycoord
	goto_xy POSX, POSY
	
	call 	move_snake
	cmp		al, 1Bh		; considerando que sempre o jogo acaba o jogador perdeu
	call	are_you_sure_about_that
	call	game_over		; podemos validar o ESC para perguntar se quer mesmo sair

start_game endp
; :::::::::::::::::: Start Game ::::::::::::::::::

; :::::::::::::::::: are_you_sure_about_that? ::::::::::::::::::
are_you_sure_about_that proc
ciclo:
	lea 	dx, AreUSure
	call	Imp_Fich
	call	get_menu_option
	cmp		al, '0'
	JE		fim
	cmp	 	al, '1'
	je		game
	call	wrong_input
	jmp   	ciclo
game:
	call		start_game
are_you_sure_about_that endp
; :::::::::::::::::: are_you_sure_about_that? ::::::::::::::::::

; :::::::::::::::::: Draw Snake Position ::::::::::::::::::
draw_snake proc
		xor			cx, cx
		xor			ax,	ax
		xor			si, si
		mov			cl, tam
loop_1:
		mov			ax,	cobra[si] ; se a head estiver no array da cobra
		cmp			ax,	'$'
		je			fim_draw

		goto_xy		ah, al
		mov			ah, 02h
		mov			dl, '(' 		; Coloca ESPAÇO
		int			21H	

		inc			ah
		goto_xy		ah, al	
		mov			ah, 02h
		mov			dl, ')'			;  Coloca ESPAÇO
		int			21H
		call		get_menu_option
		loop		loop_1

fim_draw:		
		goto_xy		POSx,POSy		; Vai para posição do cursor
draw_snake endp
; :::::::::::::::::: Draw Snake Position ::::::::::::::::::

; :::::::::::::::::: Game Over ::::::::::::::::::
game_over proc
wrong_0:
	call	clear_screen
	lea		dx, gameOver
	call	Imp_Fich
	call	get_menu_option
	cmp		al, '1'					; jogador nao quer voltar a jogar
	je		fim
	cmp		al, '2'					; jogador quer voltar a jogar
	jne		wrong
	call	menu_controller
wrong:								; se o input não for válido, alerta o jogador e volta a perguntar
	call	wrong_input				; notifica o jogador do aviso
	jmp		wrong_0
game_over endp
; :::::::::::::::::: Game Over ::::::::::::::::::

INICIO:
	mov     	ax, DADOS
	mov     	ds, ax
	MOV			AX,0B800H 		; (?)
	MOV			ES,AX			; (?)	; ES indica segmento de memória de VIDEO
	CALL 		clear_screen
	call		menu_controller

fim:	mov     ah,4ch
	int     21h


CODIGO	ENDS
END	INICIO