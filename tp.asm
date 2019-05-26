.8086
.model	small
.stack	2048

DADOS	SEGMENT PARA 'DATA'
		POSy			db		10	; a linha pode ir de [1 .. 25]
		POSx			db		40	; POSx pode ir [1..80]	
	; :::::::::::::::::: Files in Memory ::::::::::::::::::
		map_editor		db		'./files/map_editor.txt',0
		statsFile		db		'./files/stats.txt',0
		history_file	db		'./files/history.txt',0
    ; :::::::::::::::::: Ficheiros em Memória ::::::::::::::::::

	; :::::::::::::::::: File Handles ::::::::::::::::::
		Erro_Open       db      'Erro ao tentar abrir o ficheiro!$'
		Erro_Ler_Msg    db      'Erro ao tentar ler do ficheiro!$'
		Erro_Close      db      'Erro ao tentar fechar o ficheiro!$'
		msgErrorCreate	db		"Ocorreu um erro na criacao do ficheiro!$"
		msgErrorWrite	db		"Ocorreu um erro na escrita para ficheiro!$"
		msgErrorClose	db		"Ocorreu um erro no fecho do ficheiro!$"
		HandleFich      dw      0
		car_fich        db      ?
		w_caracter		dw		?
	; :::::::::::::::::: File Handles ::::::::::::::::::

	; :::::::::::::::::: Handles ::::::::::::::::::
		pontos			dw		0
		vidas 			db		2
		str_aux			db		10 dup('$')
		stats_string	dw		4 dup(0)
		aux_hist_value	dw		6 dup('$')
		aux_hist_test	dw 		6 dup('$')
		str_vidas		db		10 dup('$')
		player_name     db 		5 dup('$')
	; :::::::::::::::::: Handles ::::::::::::::::::

	; :::::::::::::::::: Warnings ::::::::::::::::::
		Erro_Input		db		'WARNING: Invalid input (Press any key to continue...) $'
	; :::::::::::::::::: Warnings ::::::::::::::::::

	; :::::::::::::::::: Cobra Utils ::::::::::::::::::
		tam				db 		0	; tamanho da cobra, menos 1 (facilita o uso do vetor)
		snake_dir		db		620 dup(?) ; vetor de direçoes para cada "peça" da cobra
		head_x			db		?
		head_y			db		?	
		tail_x 			db		?
		tail_y			db		?
	; :::::::::::::::::: Cobra Utils ::::::::::::::::::

	; :::::::::::::::::: Views ::::::::::::::::::
				GameBoardView	db	"                          DANGER NOODLE                                       ",13,10
								db	"  ##################################################################          ",13,10
								db	"  ##                                                              ##          ",13,10  ; Limites
								db	"  ##                                                              ##          ",13,10	; x : 5 - 64
								db	"  ##                                                              ##          ",13,10	; y : 3 - 20
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##################################################################          ",13,10
								db	"            SCORE:                           LEVEL:                           ",13,10
								db	"                                                                             $",13,10

			MapEditor			db	"                             DANGER NOODLE                                    ",13,10
								db	"  ##################################################################          ",13,10
								db	"  ##                                                              ##   LIFES  ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##################################################################          ",13,10
								db	"            SCORE:                           LEVEL:                           ",13,10
								db	"                                                                             $",13,10
							
			StandardMapEditor	db	"                             DANGER NOODLE                                    ",13,10
								db	"  ##################################################################          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##                                                              ##          ",13,10
								db	"  ##################################################################          ",13,10
								db	"            SCORE:                           LEVEL:                           ",13,10
								db	"                                                                             $",13,10
								

			MainMenuView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"      o---------------------------------------------------------------o      ",13,10
								db 	"      |      0       |     1      |       2       |     3     |   4   |      ",13,10
								db 	"      | How to play? |  New game  |   Show stats  |  Credits  |  Exit |      ",13,10
								db 	"      o---------------------------------------------------------------o      ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


				BonusMenuView 	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db  "                    o-----------------------------------o                    ",13,10
								db  "                    |   1  |    2     |    3     |  4   |                    ",13,10
								db 	"                    | Play | Load Map | Edit Map | Back |                    ",13,10
								db 	"                    o-----------------------------------o                    ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

		ChooseDifficultyView 	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db  "                   o-------------------------------------o                   ",13,10
								db  "                   |   1   |    2   |     3     |   4    |                   ",13,10
								db 	"                   | Slug  |  Hare  |  Cheetah  |  Back  |                   ",13,10
								db 	"                   o-------------------------------------o                   ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

				EditorMapMenu	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db  "                       o---------------------------------o                   ",13,10
								db  "                       |      1     |      2      |   3  |                   ",13,10
								db 	"                       | New Editor | Load Editor | Back |                   ",13,10
								db 	"                       o---------------------------------o                   ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


			CreditsView			db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                        Implemented by:                                      ",13,10
								db	"                            > Andre Coelho   - 21270347                      ",13,10
								db 	"                            > Joaquim Santos - 21270351                      ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                    Press any key to get back to the main menu...            ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


			StatsMenuView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                    o-----------------------------------o                    ",13,10
								db	"                    |       1        |    2    |   3    |                    ",13,10
								db	"                    |  Game history  |  Stats  |  Back  |                    ",13,10
								db 	"                    o-----------------------------------o                    ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

			GameHistoryView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"         NOME          PONTOS        M.VERDES      M.MADURAS     RATOS       ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db 	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

			StatsView 			db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                Stats:                                                       ",13,10
								db 	"                                                                             ",13,10								
								db	"                  > Nr. games:                                               ",13,10  ; (31, 17)
								db	"                  > Best play:                                               ",13,10  ; (31, 18)
								db 	"                  > Worst play:                                              ",13,10  ; (32, 19)
								db	"                  > Average play:                                            ",13,10  ; (34, 20)
								db	"                                                                             ",13,10
								db	"                      Press any key to get back to menu...                   ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

			HowToPlayView		db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                               < HOW TO PLAY >                               ",13,10
								db	"                                                                             ",13,10
								db	"                        LEFT ARROW      to move LEFT                         ",13,10
								db	"                        RIGHT ARROW     to move RIGHT                        ",13,10
								db	"                        DOWN ARROW      to move DOWN                         ",13,10
								db	"                        UP ARROW        to move UP                           ",13,10
								db	"                                                                             ",13,10
								db	"                    Press any key to get back to main menu...                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


			newGameView			db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                o-----------------------------------------------o            ",13,10
								db	"                |       1       |       2       |       3       |            ",13,10
								db	"                |    Classic    |     Bonus     |  Back to menu |            ",13,10
								db	"                o-----------------------------------------------o            ",13,10
								db	"                                                                             ",13,10
								db 	"      Insert Option >                                                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10


		YouSureAboutThatView	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                           Are you sure about that?                          ",13,10								
								db	"                                                                             ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"             | 0 - yes |                                | 1 - no  |          ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

				GameOverView	db	"                                                                             ",13,10
								db	"                ::::::::      :::     ::::    ::::  ::::::::::               ",13,10
								db	"               :+:    :+:   :+: :+:   +:+:+: :+:+:+ :+:                      ",13,10
								db	"               +:+         +:+   +:+  +:+ +:+:+ +:+ +:+                      ",13,10
								db	"               :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#                 ",13,10
								db	"               +#+   +#+# +#+     +#+ +#+       +#+ +#+                      ",13,10
								db	"               #+#    #+# #+#     #+# #+#       #+# #+#                      ",13,10
								db	"                ########  ###     ### ###       ### ##########               ",13,10
								db	"                                                                             ",13,10
								db	"                ::::::::  :::     ::: :::::::::: :::::::::                   ",13,10
								db	"               :+:    :+: :+:     :+: :+:        :+:    :+:                  ",13,10
								db	"               +:+    +:+ +:+     +:+ +:+        +:+    +:+                  ",13,10
								db	"               +#+    +:+ +#+     +:+ +#++:++#   +#++:++#:                   ",13,10
								db	"               +#+    +#+  +#+   +#+  +#+        +#+    +#+                  ",13,10
								db	"               #+#    #+#   #+#+#+#   #+#        #+#    #+#                  ",13,10
								db	"                ########      ###     ########## ###    ###                  ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                          Do you want to play again?                         ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"             | 0 - yes |                                | 1 - no  |          ",13,10
								db	"             o---------o                                o---------o          ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

				SaveNameView	db	"                                                                             ",13,10
								db	"                ::::::::      :::     ::::    ::::  ::::::::::               ",13,10
								db	"               :+:    :+:   :+: :+:   +:+:+: :+:+:+ :+:                      ",13,10
								db	"               +:+         +:+   +:+  +:+ +:+:+ +:+ +:+                      ",13,10
								db	"               :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#                 ",13,10
								db	"               +#+   +#+# +#+     +#+ +#+       +#+ +#+                      ",13,10
								db	"               #+#    #+# #+#     #+# #+#       #+# #+#                      ",13,10
								db	"                ########  ###     ### ###       ### ##########               ",13,10
								db	"                                                                             ",13,10
								db	"                ::::::::  :::     ::: :::::::::: :::::::::                   ",13,10
								db	"               :+:    :+: :+:     :+: :+:        :+:    :+:                  ",13,10
								db	"               +:+    +:+ +:+     +:+ +:+        +:+    +:+                  ",13,10
								db	"               +#+    +:+ +#+     +:+ +#++:++#   +#++:++#:                   ",13,10
								db	"               +#+    +#+  +#+   +#+  +#+        +#+    +#+                  ",13,10
								db	"               #+#    #+#   #+#+#+#   #+#        #+#    #+#                  ",13,10
								db	"                ########      ###     ########## ###    ###                  ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"           Insert 4 digit name: _ _ _ _                                      ",13,10
								db	"                                                                             ",13,10
								db	"                  You can undo you changes with BACKSPACE!                   ",13,10
								db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10

				MapEditorHelp	db	"                                                                             ",13,10
								db	"                                                                             ",13,10
								db	"                  dMMMMb  .aMMMb  dMMMMb  .aMMMMP dMMMMMP dMMMMb             ",13,10
								db	"                 dMP VMP dMP dMP dMP dMP dMP     dMP     dMP.dMP             ",13,10
								db  "                dMP dMP dMMMMMP dMP dMP dMP MMP dMMMP   dMMMMK               ",13,10
								db 	"               dMP.aMP dMP dMP dMP dMP dMP.dMP dMP     dMP AMF               ",13,10
								db 	"              dMMMMP  dMP dMP dMP dMP  VMMMP  dMMMMMP dMP dMP                ",13,10
								db  "                                                                             ",13,10
								db 	"                  dMMMMb  .aMMMb  .aMMMb  dMMMMb  dMP     dMMMMMP            ",13,10
								db 	"                 dMP dMP dMP dMP dMP dMP dMP VMP dMP     dMP                 ",13,10
								db 	"                dMP dMP dMP dMP dMP dMP dMP dMP dMP     dMMMP                ",13,10
								db 	"               dMP dMP dMP.aMP dMP.aMP dMP.aMP dMP     dMP                   ",13,10
								db 	"              dMP dMP  VMMMP   VMMMP  dMMMMP  dMMMMMP dMMMMMP                ",13,10
								db	"                                                                             ",13,10
								db	"                      		  ~ Editor Help ~                                 ",13,10
								db	"                                                                             ",13,10
								db	"              - Use the ARROW KEYS to mouve the cursor around                ",13,10
								db	"                                                                             ",13,10
								db	"              - To build a wall or destroy press SPACE                       ",13,10
								db	"                                                                             ",13,10
								db	"              - To save the file use 's' key and 'h' to read this help       ",13,10
								db	"       file any time.                                                        ",13,10
								db	"                          Press any key to go back...                        ",13,10
								db	"                                                                             ",13,10
								db	"                                                                            $",13,10
								



		slug_label		db		"SLUG$"
		hare_label		db		"HARE$"
		cheetah_label	db		"CHEETAH$"

		conta_MM		dw		0
		conta_MV		dw		0
		conta_RD		dw		0
		game_id			db		0

		
		nr_games		dw		0
		best_play 		dw 		0
		worst_play		dw		0
		average_play	dw		0

		difficulty		db		? 	; (?) Multiplier para pontuação
		conta_maca		db		0

		nr_macas		db		0	
		nr_ratos		db		0
		rato_x			db 		?
		rato_y			db		?
		rato_mov		db 		?
		tp_vida			db		?
		rato_nasce		db		?

		POSya			db		5	; Posição anterior de y
		POSxa			db		10	; Posição anterior de x
		POSxPont		db		19
		POSyPont		db		23
		posxlevel		db 		52
		posylevel		db		23
		

		PASSA_T			dw		0
		PASSA_T_ant		dw		0
		direccao		db		3
		direccao_edita	db		0
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
			push ax
			push bx
			;push dx
			xor bx, bx
			xor	ax, ax
			xor	dx, dx
			MOV	AH,02H
			MOV	BH,0
			MOV	DL,POSX
			MOV	DH,POSY
			INT	10H
			;pop dx
			pop bx
			pop ax
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
clear_screen	proc
		push bx
		xor	bx,bx
		mov	cx,25*80
apaga:	
		mov	byte ptr es:[bx],' '
		mov	byte ptr es:[bx+1],7
		inc	bx
		inc 	bx
		loop	apaga
		pop	bx
		ret
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
push	ax
push	bx
push	cx
push	dx
	xor		ax,	ax
	xor		dx,	dx

show_main_menu:
		lea		dx, MainMenuView
		mov		ah, 09h
		int 	21h

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
		je		fim_menu

		call	wrong_input
		jmp		show_main_menu

tutorial:
		lea		dx, HowToPlayView
		mov		ah, 09h
		int 	21h
		call	get_menu_option
		jmp		show_main_menu          ; volta ao menu principal

gameopts:
		lea		dx, newGameView
		mov		ah, 09h
		int 	21h
	gameopts_wrong_input:

		call 	get_menu_option			; Lê opção inserida pelo jogador

		cmp		al, '1'
		je 		classic_game

		cmp		al, '2'
		je		bonus_game 			; Bonus Game

		cmp 	al, '3'
		je		show_main_menu
 
		call 	wrong_input
		jmp		gameopts

classic_game:
	lea		dx, ChooseDifficultyView
	mov		ah, 09h
	int		21h

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
		mov difficulty, 1
		jmp game_start

	hare:
		mov factor, 50
		mov difficulty, 2
		jmp game_start

	cheetah:
		mov factor, 25
		mov difficulty, 3
		jmp game_start

	game_start:
		call 	start_game
		jmp		show_main_menu

bonus_game:
	lea		dx, BonusMenuView
	mov		ah, 09H
	int		21H

	call	get_menu_option

	cmp		al, '1'
	je		bonus_play

	cmp		al, '2'
	je		load_map

	cmp		al, '3'
	je		edit_board

	cmp		al, '4'
	je 		gameopts

	call	wrong_input
	jmp		bonus_game

bonus_play:
	lea		dx, ChooseDifficultyView
	mov		ah, 09H
	int		21h

	call	get_menu_option

	cmp 	al , '1'
	je 		slug_0

	cmp 	al, '2'
	je		hare_0

	cmp		al, '3'
	je		cheetah_0

	cmp		al, '4'
	je		bonus_game

	call	wrong_input
	jmp		bonus_play

slug_0:
	mov		factor, 100
	mov		difficulty, 1
	jmp		bonus_game_start

hare_0:
	mov		factor, 50
	mov		difficulty, 2
	jmp		bonus_game_start

cheetah_0:
	mov		factor, 25
	mov		difficulty, 3
	jmp		bonus_game_start

load_map:
	lea		dx, map_editor
	call	LoadEditorToMemory
	jmp		bonus_play

edit_board:
		lea		dx, EditorMapMenu
		mov		ah, 09H
		int		21H
		
		call	get_menu_option

		cmp		al, '1'
		je		new_editor

		cmp		al, '2'
		je		load_editor

		cmp		al, '3'
		je		bonus_game

		call	wrong_input
		jmp		edit_board

new_editor:
		lea		dx, StandardMapEditor				; vai buscar o ponteiro da a string
		mov		ah, 09H
		int		21h
		call	changeBoard							; rotina para editar o mapa
		jmp		bonus_play

load_editor:
		lea		dx, map_editor
		call	LoadEditorToMemory
		call	changeBoard
		jmp		bonus_play

bonus_game_start:
	call	start_bonus_game  
	jmp		show_main_menu

stats:
		lea		dx, StatsMenuView			; coloca o ponteiro para a string em dx
		mov		ah, 09h
		int 	21h							; chama a interrupcao para imprimir string em stdout
		call 	get_menu_option				; recebe input do teclado

		; Game History
		cmp		al, '1'
		je	 	game_history

		; Statistical Values
		cmp		al, '2'
		je		game_stats

		cmp		al, '3'
		je	 	show_main_menu

		call	wrong_input
		jmp		stats

game_history:
		call show_history
		call	get_menu_option
		jmp		stats

game_stats:
		call	LoadStats
		xor		bx, bx
		lea		dx, StatsView
		mov		ah, 09H
		int		21H

		goto_xy 31, 17
		mov		ax, nr_games
		call	NumbersIntoChars

display_nrgames:
		xor		dl, dl
		mov		ah, 02h
		mov		dl, str_aux[si]
		int		21h
		mov		dx, nr_games
		mov		stats_string[bx], dx
		inc		bx
		inc		bx
		cmp		si, 0
		je		bp_1
		dec		si				; caso haja mais digitos para imprimir

		jmp		display_nrgames

bp_1:
		; mov stats_string[bx], 13
		; inc		bx
		; inc	bx
		; mov stats_string[bx], 10
		; inc		bx
		; inc		bx
		inc bx
		goto_xy	31, 18
		mov	ax, best_play
		call NumbersIntoChars

display_bp:
		xor		dl, dl
		mov		ah, 02h
		mov		dl, str_aux[si]
		int		21h
		mov		dx, best_play
		mov		stats_string[bx], dx
		inc		bx
		inc		bx
		cmp		si, 0
		je		wp_1
		dec		si
		jmp		display_bp

wp_1:
		; mov stats_string[bx], 13
		; inc		bx
		; inc	bx
		; mov stats_string[bx], 10
		; inc		bx
		; inc bx
		goto_xy	32, 19
		mov		ax, worst_play
		call	NumbersIntoChars

display_wp:
		xor		dl, dl
		mov		ah, 02h
		mov		dl, str_aux[si]
		int		21h
		mov		dx, worst_play
		mov		stats_string[bx], dx
		inc		bx
		inc		bx
		cmp		si, 0
		je		avg_1
		dec		si
		jmp		display_wp
		
avg_1:		
		; mov stats_string[bx], 13
		; inc		bx
		; inc	bx
		; mov stats_string[bx], 10
		; inc		bx
		; inc bx
		goto_xy	34, 20
		mov		ax, average_play
		call	NumbersIntoChars

display_average:		
		xor		dl, dl
		mov		ah, 02h
		mov		dl, str_aux[si]
		int		21h
		mov		dx, average_play
		mov		stats_string[bx], dx
		inc		bx
		inc		bx
		cmp		si, 0
		je		fim_stats
		dec		si
		jmp		display_average

fim_stats:
		; call 	SaveStats
		call	get_menu_option
		jmp		stats

madeby:
		lea		dx, CreditsView
		mov		ah, 09h
		int		21h
		mov		ah, 07h
		int 	21h
		jmp		show_main_menu

fim_menu:
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		ret
menu_controller endp

;recebe handle do ficheiro em dx
LoadEditorToMemory proc
		push	ax
		push	bx
		push	cx
		xor		si,si
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
		mov		dl, car_fich
		mov		MapEditor[si], dl
		inc		si

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
sai:	
		pop	cx
		pop	bx
		pop	ax
		RET
LoadEditorToMemory endp

; :::::::::::::::::: Controlador do Menu ::::::::::::::::::

LE_TECLA	PROC

		mov		ah,08h
		int		21h
		mov		ah,0
		cmp		al,0
		jne		SAI_TECLA
		mov		ah, 08h
		int		21h
		mov		ah,1
SAI_TECLA:	RET
LE_TECLA	endp

; Change Game Board

changeBoard proc
		push	ax
		push	bx
		xor		si, si

		lea		dx, MapEditorHelp
		mov		ah, 09H
		int		21h
		call	get_menu_option
		call	clear_screen
setup_view:
		lea		dx, MapEditor
		mov		ah, 09H
		int		21h
		mov 	bl, 11
		mov		bh, 34
		mov		posx, bh
		mov		posy, bl
		goto_xy	posx, posy
LER_SETA:
		xor		bx, bx
		call 	LE_TECLA
		cmp		ah, 1
		je		ESTEND
		CMP 	AL, 's'	; ESCAPE
		je		save
		cmp		al, 'h'
		je		help
		cmp		al, 32			; space
		jne 	LER_SETA

		mov		ah, 08H
		mov		bh, 0
		int		10h

		cmp		al, ' '
		je		createMuro

		mov		ah, 02H
		mov		dl, ' '
		int		21H
		push	bx				; guardar bx na pilha (nao perder o valor)
		mov		bl, posx		; guardo o x em bx
		push	ax				; guardar ax na pilha (nao perder o valor)
		mov		ax,	80			; guardar o nr. de celulas que cada linha tem em ax
		mul		posy			; multiplicar o nr. de celulas pela posicao em y (corresponde ao nr. de linhas)
		add		bx, ax			; adicionar a posicao de x ao resultado da multiplicacao = nr da celula atual do cursor
		mov		si, bx			; colocar esse valor em si por comodidade
		pop		ax				; retirar os valores da pilha
		pop 	bx				; retirar os valores da pilha
		mov	MapEditor[si], ' '	; colocar 'space' na string
		inc		posx
		goto_xy posx, posy
		mov		ah, 02H
		mov		dl, ' '
		int		21H
		inc		si				; incrementar o si para que a posicao correspondente no ecra seja equivalente na string
		mov	MapEditor[si], ' '	; colocar 'space' na string
		dec		si				; voltar ao valor original (porque o cursor só anda nas celulas do lado esquerdo)
		dec		posx
		goto_xy	posx, posy
		jmp 	LER_SETA

createMuro:
		mov		ah, 02H
		mov		dl, '#'
		int		21H
		push	bx
		push	ax
		mov		bl, posx
		mov		ax, 80
		mul		posy
		add		bx, ax
		pop		ax
		mov		si, bx
		pop		bx
		mov	MapEditor[si], '#'	; colocar '#' na string
		inc		posx
		goto_xy posx, posy
		mov		ah, 02H
		mov		dl, '#'
		int		21H
		inc		si
		mov	MapEditor[si], '#'	; colocar '#' na string
		dec		si
		dec		posx
		goto_xy	posx, posy
		jmp LER_SETA

save:
		call clear_screen
		lea	dx, map_editor
		call SaveBonusMap
		pop	bx
		pop	ax
		ret
		jmp		LER_SETA
		
ESTEND:		
		cmp 	al,48h
		jne		BAIXO
		cmp		posy, 2			; para nao saltar fora do mapa
		je		baixo	
		dec		POSy		;cima
		goto_xy	posx, posy
		jmp		LER_SETA

BAIXO:		
		cmp		al,50h
		jne		ESQUERDA
		cmp		posy, 21		; para nao saltar fora do mapa
		je		esquerda
		inc 	POSy		;Baixo
		goto_xy	posx, posy
		jmp		LER_SETA

ESQUERDA:
		cmp		al,4Bh
		jne		DIREITA
		cmp		posx, 4			; para nao saltar fora do mapa
		je		direita
		dec		POSx		;Esquerda
		dec		POSx		;Esquerda
		goto_xy	posx, posy
		jmp		LER_SETA

DIREITA:
		cmp		al,4Dh
		jne		help
		cmp		posx, 64		; para nao saltar fora do mapa
		je		help 
		inc		POSx		;Direita
		inc		POSx		;Direita
		goto_xy	posx, posy
		jmp	LER_SETA

help:
		cmp		al, 'h'
		jne		LER_SETA
		call	clear_screen
		lea		dx, MapEditorHelp
		mov		ah, 09H
		int		21h
		call	get_menu_option
		jmp		setup_view
	
changeBoard endp

; passar em dx a handle para o ficheiro
SaveBonusMap proc
push	ax
push	bx
push	cx
push	dx
		mov		ah, 3ch				; Abrir o ficheiro para escrita
		mov		cx, 00H				; Define o tipo de ficheiro 
		;lea		dx, fname			; DX aponta para o nome do ficheiro 
		int		21h				; Abre efectivamente o ficheiro (AX fica com o Handle do ficheiro)
		jnc		escreve				; Se não existir erro escreve no ficheiro
	
		mov		ah, 09h
		lea		dx, msgErrorCreate
		int		21h
	
		jmp		fim

escreve:
		mov		bx, ax				; Coloca em BX o Handle
		mov		ah, 40h				; indica que é para escrever
    	
		lea		dx, MapEditor		; DX aponta para a informação a escrever
		mov		cx, 1920				; CX fica com o numero de bytes a escrever
		int		21h				; Chama a rotina de escrita
		jnc		close				; Se não existir erro na escrita fecha o ficheiro
	
		mov		ah, 09h
		lea		dx, msgErrorWrite
		int		21h
close:
		mov		ah,3eh				; fecha o ficheiro
		int		21h
		jnc		fim_save
	
		mov		ah, 09h
		lea		dx, msgErrorClose
		int		21h

fim_save:
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		ret
SaveBonusMap endp

LoadStats proc
; TODO: mudar a interrupção para nao criar o ficheiro mas abrir
		push ax
		push bx
		push cx
		push dx
		xor si, si
		lea		dx, statsFile
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
        mov     cx,2				; numero de bytes a ler
        lea     dx,w_caracter			; vai ler para o local de memoria apontado por dx (car_fich)
        int     21h					; faz efectivamente a leitura
	    jc	    erro_ler			; se carry é porque aconteceu um erro
		cmp		ax, 0
	    je	    fecha_ficheiro		; se EOF fecha o ficheiro
		mov		dx, w_caracter
		mov		stats_string[si], dx
		add		si, 2
		jmp		ler_ciclo

load_ng:
		xor 	si, si
		mov		dx, stats_string[si]
		mov		nr_games, dx

load_bp:
		inc si
		inc si
		mov		dx, stats_string[si]
		mov		best_play, dx

load_wp:
		inc si
		inc si
		mov		dx, stats_string[si]
		mov		worst_play, dx

load_avg:
		inc si
		inc si
		mov		dx, stats_string[si]
		mov		average_play, dx
		jmp sai

erro_ler:
        mov     ah,09h
        lea     dx,Erro_Ler_Msg
        int     21h

fecha_ficheiro:					; vamos fechar o ficheiro 
        mov     ah,3eh
        mov     bx,HandleFich
        int     21h
        jnc     load_ng

        mov     ah,09h			; o ficheiro pode não fechar correctamente
        lea     dx,Erro_Close
        Int     21h
sai:	  
		pop dx
		pop cx
		pop bx
		pop ax
		RET
LoadStats endp

SaveStats proc
		push	ax
		push	bx
		push	cx
		push 	dx

		mov ax, nr_games
		mov stats_string[0], ax
		mov ax, best_play
		mov stats_string[2], ax		
		mov ax, worst_play
		mov stats_string[4], ax		
		mov ax, average_play
		mov stats_string[6], ax



		mov		ah, 3ch				; Abrir o ficheiro para escrita
		mov		cx, 00H				; Define o tipo de ficheiro 
		lea		dx, statsFile			; DX aponta para o nome do ficheiro 
		int		21h				; Abre efectivamente o ficheiro (AX fica com o Handle do ficheiro)
		jnc		escreve				; Se não existir erro escreve no ficheiro
	
		mov		ah, 09h
		lea		dx, msgErrorCreate
		int		21h
	
		jmp		save_stats_fim

escreve:
		mov		bx, ax				; Coloca em BX o Handle
		mov		ah, 40h				; indica que é para escrever
    	
		lea		dx, stats_string		; DX aponta para a informação a escrever
		mov		cx, 8			; CX fica com o numero de bytes a escrever
		int		21h					; Chama a rotina de escrita
		jnc		close				; Se não existir erro na escrita fecha o ficheiro
	
		mov		ah, 09h
		lea		dx, msgErrorWrite
		int		21h
close:
		mov		ah,3eh				; fecha o ficheiro
		int		21h
		jnc		save_stats_fim
	
		mov		ah, 09h
		lea		dx, msgErrorClose
		int		21h
save_stats_fim:
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		ret
SaveStats endp

UpdateStats proc
		push bx
		push ax
		push cx
		xor bx, bx
		xor ax, ax
		xor cx, cx
		inc nr_games
		mov	bx, pontos

		cmp	bx, worst_play
		jbe	update_wp

valid_1:
		cmp bx, best_play
		jge	update_bp

		jmp	update_avg

update_wp:
		mov	worst_play, bx
		jmp valid_1

update_bp:
		mov	best_play, bx

update_avg:
		mov	cx, nr_games
		mov	ax, average_play
		dec cx
		mul	cx					; total de pontos acumulados em nr_games jogos
		add	ax, bx				; adicionar os pontos do jogo atual
		inc	cx
		div	cx
		mov	average_play, ax
fim_update:
		pop cx
		pop ax
		pop bx
		call SaveStats
		ret
UpdateStats endp
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
	jmp fim

get_menu_option endp

get_char PROC
	mov			ah,	07h 		; read char from input with echo
	int			21h

	ret
get_char endp
; :::::::::::::::::: Obter Opção ::::::::::::::::::

; :::::::::::::::::: Movimento da Cobra ::::::::::::::::::
move_snake PROC
CICLO:
	call		add_ratos
	call 		dir_vector
	goto_xy		head_x,head_y		; Vai para nova posição
	mov 		ah, 08h				; Guarda o Caracter que está na posição do Cursor
	mov			bh,0				; numero da página
	int			10h
	
	cmp 		al, '#'				;  na posição do Cursor
	je			fim_jogo
	cmp 		al, 'V'
	je			maca_verde
	cmp			al, 'M'
	je 			maca_madura
	cmp			al, '.'
	je			rato

	jmp cont_ciclo

maca_verde:
	xor 	ax,ax
	mov 	al, difficulty
	add 	pontos, ax				; adiciona 1*dificuldade pontos
	call	mostra_pontuacao 	; Mostra prontuação
	inc conta_MV
	call 	add_apple
	inc 	maca
	dec		nr_macas
	call 	limpa_maca
	dec	nr_macas
	jmp 	cont_ciclo

maca_madura:
	xor 	ax,ax
	mov 	al, difficulty
	mov 	bl, 2
	mul 	bl					
	add 	pontos, ax				; adiciona 2*dificuldade pontos
	call	mostra_pontuacao 	; Mostra prontuação
	inc conta_MM
	call 	add_apple
	inc	 	maca
	inc	 	maca
	dec		nr_macas
	call 	limpa_maca
	dec	nr_macas
	jmp 	cont_ciclo

rato:
	xor ax,ax
	mov al, difficulty
	mov bl, 3
	mul bl
	cmp pontos, ax
	jae neg_points				; se tiver menos pontos que os que deve retirar, retira todos os pontos que tem
	mov ax, pontos

neg_points:
	sub pontos, ax
	call mostra_pontuacao 	; Mostra prontuação
	inc conta_RD
	call limpa_maca
	call come_rato

cont_ciclo:
		cmp maca, 0
		ja dec_maca

	;; Limpar a cauda da cobra

		goto_xy		tail_x,tail_y		; Vai para a posição anterior do cursor
		

		xor ax,ax
		xor bx,bx
		mov al, 160
		mul tail_y
		mov si,ax
		mov al, 2
		mul tail_x
		mov bx,ax
		xor ax, ax
		mov		al, ' '
		mov		ah, 0fh
		mov		es:[si][bx], ax
		mov		es:[si][bx+2], ax


		; mov			ah, 02h
		; mov			dl, ' ' 		; Coloca ESPAÇO
		; int			21H
		; mov 		ah, tail_x
		; mov 		posxa, ah
		; inc			POSxa
		; goto_xy		POSxa,tail_y	
		; mov			ah, 02h
		; mov			dl, ' '			;  Coloca ESPAÇO
		; int			21H	
		call 		move_tail



IMPRIME:
	;; Atualizar a cabeça da cobra
		goto_xy		head_x,head_y		; Vai para posição do cursor
		;call		verifica_rato
		mov 		ah, 08h				; Guarda o Caracter que está na posição do Cursor
		mov			bh,0				; numero da página
		int			10h

		cmp 		al, '('				;  se houver cobra na posição atual, game over
		je			fim_jogo

		; mov			ah, 02h
		; mov			dl, '('				; Coloca AVATAR1
		; int			21H

		mov		al, head_y
		mov		bx, 160
		mul		bx
		mov		bx, ax
		mov		al, head_x
		mov		dx, 2
		mul		dx
		add		bx, ax
		xor		ax, ax

		xor ax,ax
		xor bx,bx
		mov al, 160
		mul head_y
		mov si,ax
		mov al, 2
		mul head_x
		mov bx,ax
		xor ax, ax
		mov		al, '('
		mov		ah, 66h;22h
		mov		es:[si][bx], ax


		mov		al, ')'
		mov		es:[si][bx+2], ax

		; mov 		ah, head_x
		; mov 		posx, ah
		; inc			POSx
		; goto_xy		posx,head_y		
		; mov			ah, 02h
		; mov			dl, ')'			; Coloca AVATAR2
		; int			21H	

		goto_xy		head_x, head_y		; Vai para posição do cursor
		cmp			nr_macas, 0
		je			spawn_maca

		jmp			LER_SETA

spawn_maca:
		call 	add_apple
		inc		nr_macas
		
LER_SETA:	
		call 		LE_TECLA_0
		cmp			ah, 1
		je			ESTEND
		CMP 		AL, 27			; ESCAPE
		jne			TESTE_END
		jmp			fim
		; call		are_you_sure_about_that
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
		add			head_x, 2		;Direita
		jmp			CICLO
		
verifica_1:	
		mov 		al, direccao
		cmp			al, 1
		jne			verifica_2
		dec			head_y		;cima
		jmp			CICLO
		
verifica_2:	
		mov 		al, direccao
		cmp			al, 2
		jne			verifica_3
		sub 		head_x, 2		;Esquerda
		jmp			CICLO
		
verifica_3:	
		mov 		al, direccao
		cmp			al, 3	
		jne			CICLO
		inc			head_y		;BAIXO	
		jmp			CICLO
		
ESTEND:		
		cmp 		al,48h
		jne			BAIXO
		cmp			snake_dir[0], 3
		je			LER_SETA
		mov			direccao, 1
		jmp			LER_SETA

BAIXO:
		cmp			al,50h
		jne			ESQUERDA
		cmp			snake_dir[0], 1
		je			LER_SETA
		mov			direccao, 3
		jmp			LER_SETA

ESQUERDA:
		cmp			al,4Bh
		jne			DIREITA
		cmp			snake_dir[0], 0
		je			LER_SETA
		mov			direccao, 2
		jmp			LER_SETA

DIREITA:
		cmp			al,4Dh
		jne			LER_SETA 
		cmp			snake_dir[0], 2
		je			LER_SETA
		mov			direccao, 0
		jmp			LER_SETA

fim_jogo:
		call		clear_screen
		call		game_over
		RET

dec_maca:
		dec 		maca
		inc 		tam
		jmp 		imprime

move_snake ENDP

tp_snake proc
	push ax
	push bx
	xor ax, ax
	xor bx, bx

	mov	bl, tail_x
	mov bh, tail_y

	cmp tail_x, 2
	je tp_dir1
ctn_01:
	cmp	tail_x, 66
	je tp_esq1
ctn_02:
	cmp tail_y, 1
	je	tp_bx1
ctn_03:
	cmp tail_y, 22
	je	tp_cm1

	jmp	avalia_tail

tp_dir1:
	mov	bl, direccao
	; cmp	bl, 2     ; se a direcao da cabeca for para a esquerdar
	; jne	ctn_01
	mov	bh, 64
	mov	tail_x, bh
	jmp ctn_01
tp_esq1:
	mov bl, direccao
	; cmp bl, 0	; se a direcao da cabeca for para a direita
	; jne ctn_02
	mov	bh, 4
	mov	tail_x, bh
	jmp ctn_02
tp_bx1:
	mov bl, direccao
	; cmp bl, 1  ; se a direcao da cabeca for para cima
	; jne ctn_03
	mov bh, 21
	mov	tail_y, bh
	jmp ctn_03
tp_cm1:
	mov bl, direccao
	; cmp bl, 3		; se a direcao da cabeca for para baixo
	; jne avalia_tail
	mov bh, 2
	mov tail_y, bh


avalia_tail:

	mov al, head_x
	mov ah, head_y

	cmp head_x, 2
	je tp_dir				; se esta no limite do lado esquerdo tp to lado direito
ctn_1:
	cmp	head_x, 66
	je tp_esq
ctn_2:
	cmp head_y, 1
	je	tp_bx
ctn_3:
	cmp head_y, 22
	je	tp_cm
	xor ax, ax
	jmp fim_tp_snake
tp_dir:
	mov	al, direccao
	cmp	al, 2				; se a cobra se estiver a mover para a esquerda
	jne	ctn_1
	mov	ah, 64
	mov	head_x, ah
	jmp ctn_1
tp_esq:
	mov al, direccao
	cmp al, 0
	jne ctn_2
	mov	ah, 4
	mov	head_x, ah
	jmp ctn_2
tp_bx:
	mov al, direccao
	cmp al, 1
	jne ctn_3
	mov ah, 21
	mov	head_y, ah
	jmp ctn_3
tp_cm:
	mov al, direccao
	cmp al, 3
	jne fim_tp_snake
	mov ah, 2
	mov head_y, ah

fim_tp_snake:
	goto_xy head_x, head_y
	pop bx
	pop ax
	ret
tp_snake endp

bonus_move_snake PROC
CICLO:
	call		mostra_vidas
	call		add_ratos
	call 		dir_vector
	;goto_xy		head_x,head_y		; Vai para nova posição
	
	call tp_snake

	mov 		ah, 08h				; Guarda o Caracter que está na posição do Cursor
	mov			bh,0				; numero da página
	int			10h

	cmp 		al, '#'				;  na posição do Cursor
	je			fim_jogo
	cmp 		al, 'V'
	je			maca_verde
	cmp			al, 'M'
	je 			maca_madura
	cmp			al, '.'
	je			rato

	jmp cont_ciclo

maca_verde:
	xor 	ax,ax
	mov 	al, difficulty
	add 	pontos, ax				; adiciona 1*dificuldade pontos
	call	mostra_pontuacao 	; Mostra prontuação
	call 	add_apple
	inc 	maca
	dec		nr_macas
	call 	limpa_maca
	dec	nr_macas
	jmp 	cont_ciclo

maca_madura:
	xor 	ax,ax
	mov 	al, difficulty
	mov 	bl, 2
	mul 	bl					
	add 	pontos, ax				; adiciona 2*dificuldade pontos
	call	mostra_pontuacao 	; Mostra prontuação
	call 	add_apple
	inc	 	maca
	inc	 	maca
	dec		nr_macas
	call 	limpa_maca
	dec	nr_macas
	jmp 	cont_ciclo

rato:
	xor ax,ax
	mov al, difficulty
	mov bl, 3
	mul bl
	cmp pontos, ax
	jae neg_points				; se tiver menos pontos que os que deve retirar, retira todos os pontos que tem
	mov ax, pontos

neg_points:
	sub pontos, ax
	call mostra_pontuacao 	; Mostra prontuação
	call limpa_maca
	call come_rato

cont_ciclo:
		cmp maca, 0
		ja dec_maca

	;; Limpar a cauda da cobra

		goto_xy		tail_x,tail_y		; Vai para a posição anterior do cursor
		
		xor ax,ax
		xor bx,bx
		mov al, 160
		mul tail_y
		mov si,ax
		mov al, 2
		mul tail_x
		mov bx,ax
		xor ax, ax
		mov		al, ' '
		mov		ah, 0fh
		mov		es:[si][bx], ax
		mov		es:[si][bx+2], ax


		; mov			ah, 02h
		; mov			dl, ' ' 		; Coloca ESPAÇO
		; int			21H
		; mov 		ah, tail_x
		; mov 		posxa, ah
		; inc			POSxa
		; goto_xy		POSxa,tail_y	
		; mov			ah, 02h
		; mov			dl, ' '			;  Coloca ESPAÇO
		; int			21H	
		call 		move_tail



IMPRIME:
	;; Atualizar a cabeça da cobra
		goto_xy		head_x,head_y		; Vai para posição do cursor
		;call		verifica_rato
		mov 		ah, 08h				; Guarda o Caracter que está na posição do Cursor
		mov			bh,0				; numero da página
		int			10h

		cmp 		al, '('				;  se houver cobra na posição atual, game over
		je			fim_jogo

		; mov			ah, 02h
		; mov			dl, '('				; Coloca AVATAR1
		; int			21H

		mov		al, head_y
		mov		bx, 160
		mul		bx
		mov		bx, ax
		mov		al, head_x
		mov		dx, 2
		mul		dx
		add		bx, ax
		xor		ax, ax

		xor ax,ax
		xor bx,bx
		mov al, 160
		mul head_y
		mov si,ax
		mov al, 2
		mul head_x
		mov bx,ax
		xor ax, ax
		mov		al, '('
		mov		ah, 66h;22h
		mov		es:[si][bx], ax


		mov		al, ')'
		mov		es:[si][bx+2], ax

		; mov 		ah, head_x
		; mov 		posx, ah
		; inc			POSx
		; goto_xy		posx,head_y		
		; mov			ah, 02h
		; mov			dl, ')'			; Coloca AVATAR2
		; int			21H	

		goto_xy		head_x, head_y		; Vai para posição do cursor
		cmp			nr_macas, 0
		je			spawn_maca

		jmp			LER_SETA

spawn_maca:
		call 	add_apple
		inc		nr_macas
		
LER_SETA:	
		call 		LE_TECLA_0
		cmp			ah, 1
		je			ESTEND
		CMP 		AL, 27			; ESCAPE
		jne			TESTE_END
		jmp			fim
		; call		are_you_sure_about_that
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
		add			head_x, 2		;Direita
		jmp			CICLO
		
verifica_1:	
		mov 		al, direccao
		cmp			al, 1
		jne			verifica_2
		dec			head_y		;cima
		jmp			CICLO
		
verifica_2:	
		mov 		al, direccao
		cmp			al, 2
		jne			verifica_3
		sub 		head_x, 2		;Esquerda
		jmp			CICLO
		
verifica_3:	
		mov 		al, direccao
		cmp			al, 3	
		jne			CICLO
		inc			head_y		;BAIXO	
		jmp			CICLO
		
ESTEND:		
		cmp 		al,48h
		jne			BAIXO
		cmp			snake_dir[0], 3
		je			LER_SETA
		mov			direccao, 1
		jmp			LER_SETA

BAIXO:
		cmp			al,50h
		jne			ESQUERDA
		cmp			snake_dir[0], 1
		je			LER_SETA
		mov			direccao, 3
		jmp			LER_SETA

ESQUERDA:
		cmp			al,4Bh
		jne			DIREITA
		cmp			snake_dir[0], 0
		je			LER_SETA
		mov			direccao, 2
		jmp			LER_SETA

DIREITA:
		cmp			al,4Dh
		jne			LER_SETA 
		cmp			snake_dir[0], 2
		je			LER_SETA
		mov			direccao, 0
		jmp			LER_SETA

fim_jogo:
		dec vidas
		call		clear_screen
		call		bonus_game_over
		RET

dec_maca:
		dec 		maca
		inc 		tam
		jmp 		imprime

bonus_move_snake ENDP


dir_vector PROC
	xor si,si
	xor ax,ax
	mov al, tam
	mov cx, ax
	inc cx					; como tam = tamanho da cobra - 1,  inc no cx
	mov al, direccao
ccl:
	xchg al, snake_dir[si]		; al = direçao que a 'peça' seguinte mais perto da cauda vai ter,  snake_dir(si) = dir que a posição anterior tinha
	inc si			; basicamente AL=0   snake dir=3,1,3,2,1   ->   snake_dir=0,3,1,3,2
	loop ccl
	ret
dir_vector endp

move_tail proc
	xor ax,ax
	mov al,tam
	mov si,ax
	mov al, snake_dir[si]		;al passa a ter direção que a cauda se deve mexer
	cmp al, 0 ;direita
	je tail_dir
	cmp al, 1 ;cima
	je tail_cima
	cmp al, 2 ;esquerda
	je tail_esq
	cmp al, 3 ;baixo
	je tail_baix
	ret
	tail_dir:
	add tail_x,2			;mexe para direita
	jmp fim_tail
	tail_cima:
	dec tail_y				;mexe para cima
	jmp fim_tail
	tail_esq:				
	sub tail_x, 2			;mexe para esquerda
	jmp fim_tail
	tail_baix:				
	inc tail_y				;mexe para baixo
	fim_tail:
	ret
move_tail endp

limpa_maca proc

	xor ax,ax
	xor bx,bx
	mov al, 160
	mul head_y
	mov si,ax
	mov al, 2
	mul head_x
	mov bx,ax
	mov dx, 0720h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx

	ret

limpa_maca endp

come_rato proc
	xor cx,cx
	xor bx,bx
	cmp tam, 0
	je 	fim_come_rato
	mov cx, 5
	cmp tam, 5
	jae ciclo_rato
	mov cl, tam
ciclo_rato:
	push ax
	push bx
	push dx

	xor ax,ax
	xor bx,bx
	mov al, 160
	mul tail_y
	mov si,ax
	mov al, 2
	mul tail_x
	mov bx,ax

	mov dx, 0720h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx
	
	pop dx
	pop bx
	pop ax

	; mov ah, tail_x
	; mov posx, ah
	; goto_xy tail_x, tail_y
	; mov dl,' '
	; mov ah,02h
	; int 21h
	; inc posx
	; goto_xy posx, tail_y
	; mov dl, ' '
	; int 21h
	mov bl, tam
	cmp snake_dir[bx], 0
	jne dir_cim
	add tail_x, 2
	jmp fim_rato
dir_cim:
	cmp snake_dir[bx], 1
	jne dir_esq
	dec tail_y
	jmp fim_rato
dir_esq:
	cmp snake_dir[bx], 2
	jne dir_baix
	sub tail_x, 2
	jmp fim_rato
dir_baix:
	inc tail_y
fim_rato:
	dec tam
loop ciclo_rato
fim_come_rato:
	mov nr_ratos, 0
	mov rato_mov, 0
	ret
come_rato endp
; :::::::::::::::::: Movimento da Cobra ::::::::::::::::::

; :::::::::::::::::: Mostra Pontuação ::::::::::::::::::
mostra_pontuacao proc 
	push	ax
	push	bx
	push	cx
	push	dx
	xor		si, si
	xor		dx, dx
	xor		ax, ax
	xor		bx, bx
	mov		cx, cx
	mov		bx, 10
	mov		AX, pontos

break_chars:
	xor		dx, dx
	div		bx					; ah fica com o caracter a converter para ascii
	add		dl, 30h				; para converter para ascii
	mov		str_aux[si], dl
	cmp		ax, 0
	je		display
	inc		si
	jmp		break_chars
	
display:
	goto_xy	posxpont, posypont
display_pont:
	xor		dl, dl
	mov		ah, 02h
	mov		dl, str_aux[si]
	int		21h
	cmp		si, 0
	je		fim_mostra
	dec		si
	jmp		display_pont

fim_mostra:
	goto_xy	posx, posy
	call 	limpa_aux
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	ret
mostra_pontuacao endp

mostra_vidas proc
	push	ax
	push	bx
	push	cx
	push	dx
	xor		si, si
	xor		dx, dx
	xor		ax, ax
	xor		bx, bx
	mov		cx, cx
	mov		bx, 10
	mov		Al, vidas

break_chars:
	xor		dx, dx
	div		bx					; ah fica com o caracter a converter para ascii
	add		dl, 30h				; para converter para ascii
	mov		str_vidas[si], dl
	cmp		ax, 0
	je		display
	inc		si
	jmp		break_chars
	
display:
	goto_xy	72, 3
display_pont:
	xor		dl, dl
	mov		ah, 02h
	mov		dl, str_vidas[si]
	int		21h
	cmp		si, 0
	je		fim_mostra
	dec		si
	jmp		display_pont

fim_mostra:
	goto_xy	posx, posy
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	ret
mostra_vidas endp
; :::::::::::::::::: Mostra Pontuação ::::::::::::::::::

limpa_aux proc
	push cx
	push si
	mov	cx, 12
	xor si,si
limpa_aux_1:
	mov	str_aux[si], '$'
	inc si
	loop limpa_aux_1
	pop si
	pop cx
	ret
limpa_aux endp

; recebe nr. para converter em ax
NumbersIntoChars proc
	push	bx
	push	cx
	push	dx
	xor		si, si
	xor		dx, dx
	xor		bx, bx
	mov		cx, cx
	mov		bx, 10

break_chars_0:
	xor		dx, dx
	div		bx					; ah fica com o caracter a converter para ascii
	add		dl, 30h				; para converter para ascii
	mov		str_aux[si], dl
	cmp		ax, 0
	je		fim_transform
	inc		si
	jmp		break_chars_0

fim_transform:
	;call 	limpa_aux
	pop		dx
	pop		cx
	pop		bx
	ret
NumbersIntoChars endp

show_str proc
	push si
	push ax
	push cx
	mov cx, 10
	mov si, 9
count_loop:
	push cx
	cmp str_aux[si], '$'
	je dont
	mov dl, str_aux[si]
	mov ah, 02H
	int 21h
dont:
	pop cx
	dec si
loop count_loop
	pop cx
	pop ax
	pop si
	ret
show_str endp
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
		mov		ah, 07h
		goto_xy	posx, posy		; volta para a posição antiga do cursor
		call 	get_menu_option
		call	clear_screen
		ret
wrong_input endp
; :::::::::::::::::: Imprime avisos de wrong input ::::::::::::::::::

; :::::::::::::::::: Calcula Aleatorio ::::::::::::::::::
; author: Professor -> A MERDA QUE O STOR FEZ NAO FUNCIONAVA, POR ISSO EU FIZ UM QUE FUNCIONA
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

	push ax
	push dx
	push cx

	mov ah, 2Ch
	int 21H
	xor ax,ax
	mov al, dh
	xor dh, dh
	mul dx
	xchg dx,ax
	xchg dl, dh
	MOV AX, ultimo_num_aleat
	CMP ultimo_num_aleat, 0
	JNE not_0
	mov ax, 65521 
	jmp fim_rand
not_0:
	MOV AX, ultimo_num_aleat
	XOR AH,AH
fim_rand:
	mul dx
	xchg al,ah
	mov ultimo_num_aleat, ax

	pop cx
	pop dx
	pop ax
	ret

	; sub		sp,2		; 
	; push	bp
	; mov		bp,sp
	; push	ax
	; push	cx
	; push	dx	
	; mov		ax,[bp+4]
	; mov		[bp+2],ax

	; mov		ah,00h
	; int		1ah

	; add		dx,ultimo_num_aleat	; vai buscar o aleat�rio anterior
	; add		cx,dx
	; mov		ax,65521
	; push	dx
	; mul		cx			
	; pop		dx			 
	; xchg	dl,dh
	; add		dx,32749
	; add		dx,ax

	; mov		ultimo_num_aleat,dx	; guarda o novo numero aleat�rio

	; mov		[BP+4],dx		; o aleat�rio � passado por pilha

	; pop		dx
	; pop		cx
	; pop		ax
	; pop		bp
	; ret

CalcAleat endp
; :::::::::::::::::: Calcula Aleatorio ::::::::::::::::::

; :::::::::::::::::: Gera Coordenada de X válida ::::::::::::::::::
; param : recebe em dl um aleatorio de 8 bits
; NOTA: devolve sempre a mini celula da esquerda
; return: Ah - x coord
valid_Xcoord proc
	xor		dx, dx
	mov		dx,	ultimo_num_aleat
	xor 	ax,	ax
	xor		cx, cx

	mov		al, dh
	mov		cl, 31
	mul		cl
	xor		cx, cx
	mov		cl, 255
	div		cl
	cmp al, 31
	jne not_31
	mov al, 30
not_31:
	mov cl, 2
	mul cl

	add		al, 4	 			; garantir que o nr e superior a 4

	mov		posx, al
	ret
valid_Xcoord endp
; :::::::::::::::::: Gera Coordenada de X válida ::::::::::::::::::

; :::::::::::::::::: Gera Coordenada de Y válida ::::::::::::::::::
; param : recebe em dl um aleatorio de 8 bits
; NOTA: devolve sempre a mini celula da esquerda
; return: Al - y coord
valid_Ycoord proc
	xor		dx, dx
	mov		dx,	ultimo_num_aleat
	xor		ax,	ax
	xor 	cx, cx
	; cmp		dl, 20			
	; jge		invalid_0
	; cmp		dl, 2
	; jb		invalid_2
	; ret
; invalid_0:
	mov		al, dl
	mov		cl, 20
	mul		cl
	xor		cx, cx
	mov		cl, 255
	div		cl
	add		al, 2
	cmp al, 20
	jne not_20
	mov al, 19
not_20:

	; jmp		valid_fim
; invalid_2:
	; add		al, 4
; valid_fim:
	mov		posy, al	
	ret
valid_Ycoord endp
; :::::::::::::::::: Gera Coordenada de Y válida ::::::::::::::::::

; :::::::::::::::::: Adiciona Macas ::::::::::::::::::

add_apple proc
	; xor		ax, ax				
	; mov		al, posx			; guardar a posicao anterior
	; mov		posxa, al
	; mov		ah, posy
	; mov		posya, ah
	mov		bl, 1
	mov		nr_macas, bl
generate_position:
	;call 	CalcAleat
	xor		ax, ax
	xor		dx, dx
	xor		bx, bx
	call 	CalcAleat
	call	valid_Xcoord		; obter uma posicao valida no gameboard
	mov		posx, al
	call 	CalcAleat
	call	valid_Ycoord
	mov		posy, al
	goto_xy	posx, posy			; colocar o cursor nessa posicao
	
	mov		ah, 08H
	mov		bh, 0				; le o caracter que esta na posicao atual do cursor
	int		10h

	cmp		al, '('
	je		generate_position  ; se a maca for gerada estiver em cima da cobra
	cmp		al, '.'
	je		generate_position	; se a maca a ser gerada estiver em cima do rato
	cmp 	al, '#'
	je 		generate_position
	cmp		al, 'M'
	je 		generate_position
	cmp 	al, 'V'
	je 		generate_position
	mov al, head_x
	cmp 	posx, al
	jne cont_macas
	mov al, head_y
	cmp 	posy, al
	je 		generate_position

cont_macas:
	xor		cx, cx
	xor		ax, ax
	xor		dx, dx
	mov		dx, ultimo_num_aleat
	mov		al, dl
	mov		cl, 2
	div		cl
	cmp		ah, 0
	je		maca_verde_0

	xor ax,ax
	xor bx,bx
	mov al, 160
	mul posy
	mov si,ax
	mov al, 2
	mul posx
	mov bx,ax
	mov dl,'M'
	mov dh, 44h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx
	jmp fim_add


maca_verde_0:
	xor ax,ax
	xor bx,bx
	mov al, 160
	mul posy
	mov si,ax
	mov al, 2
	mul posx
	mov bx,ax
	mov dl,'V'
	mov dh, 22h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx

fim_add:
	ret
add_apple endp
; :::::::::::::::::: Adiciona Macas ::::::::::::::::::

; :::::::::::::::::: Adiciona Ratos ::::::::::::::::::
add_ratos proc
	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx

	cmp		nr_ratos, 0
	je		add_rato
	jmp		verifica_rato

add_rato:
	cmp rato_mov, 20
	jb wait_to_spawn

	xor ax,ax
	call	CalcAleat
	call	valid_Xcoord
	mov		rato_x, al
	call	CalcAleat
	call	valid_Ycoord
	mov		rato_y, al

	goto_xy	rato_x, rato_y			; colocar o cursor nessa posicao
	
	mov		ah, 08H
	mov		bh, 0				; le o caracter que esta na posicao atual do cursor
	int		10h

	cmp		al, '('
	je		add_rato  ; se o rato for gerado estiver em cima da cobra
	cmp		al, 'M'
	je		add_rato	; se o rato for gerada estiver em cima das macas verdes
	cmp		al, 'V'
	je 		add_rato	; se o rato for gerada estiver em cima das macas maduras
	cmp		al, '#'
	je		add_rato	; se o rato gerado estiver em cima do muro
	cmp 	al, '.'
	je 		add_rato
	mov al, head_x
	cmp 	rato_x, al
	jne cont_rato
	mov al, head_y
	cmp 	rato_y, al
	je 		add_rato

cont_rato:
  	xor ax,ax
	xor bx,bx
	mov al, 160
	mul rato_y
	mov si,ax
	mov al, 2
	mul rato_x
	mov bx,ax
	mov dl,'.'
	mov dh, 0ffh;78h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx



	; xor		ax, ax
	; mov		ah, posx
	; mov		al, posy
	; mov		rato_x, ah
	; mov		rato_y, al
	; goto_xy rato_x, rato_y
	
	; mov		ah, 02H
	; mov		dl, 'R'
	; int		21H
	; inc		rato_x
	; goto_xy rato_x, rato_y
	; ;dec		rato_x

	; mov		ah, 02H
	; mov		dl, 'R'
	; int		21H
	;goto_xy rato_x, rato_y

	mov		bl, nr_ratos
	inc		bl
	mov		nr_ratos, bl


	mov		ah, 2ch			; tempo do sistema
	int		21h
	mov		rato_nasce, dh

verifica_rato:
	mov	ah, 2ch
	int	21h
	cmp	dh, rato_nasce
	jb	add60
	jmp	TempoDeVida
add60:
	add dh, 60
TempoDeVida:
	sub	dh, rato_nasce
	cmp	dh, 4
	jge	mata_rato
	jmp fim_add_rato
mata_rato:

	xor ax,ax
	xor bx,bx
	mov al, 160
	mul rato_y
	mov si,ax
	mov al, 2
	mul rato_x
	mov bx,ax
	mov dl,' '
	mov dh, 7h;67h
	mov es:[si][bx], dx
	mov es:[si][bx+2], dx

	mov nr_ratos, 0
	mov rato_mov, 0
	jmp fim_add_rato

	; goto_xy rato_x, rato_y
	; mov	ah, 02H
	; mov	dl, ' '
	; int	21H
	; inc rato_x
	; goto_xy rato_x, rato_y
	; dec rato_x
	; mov	ah, 02H
	; mov	dl, ' '
	; int	21h
	
	; mov	bl, 0
	; mov	rato_nasce, bl
	; mov ax, 0ee2eh     -> teste... apagar antes de enviar
	; mov es:[0], ax		-> same ^
wait_to_spawn:
	inc rato_mov

fim_add_rato:
	ret
add_ratos endp
; :::::::::::::::::: Adiciona Ratos ::::::::::::::::::
; verifica_rato proc
; 	push ax
; 	push bx
; 	push dx
; 	xor	ax, ax
; 	mov	ah, 2ch
; 	int	21H

; 	mov al, dh
; 	mov bl, 4
; 	mul	bl
; 	xor	bx, bx
; 	mov	bl, 60
; 	div	bl
; 	xor	bx, bx
; 	mov bl, tp_vida
; 	sub	al, bl
; 	cmp	al, 0
; 	jbe	mata_rato
; 	jmp	fim_1

; mata_rato:
; 	goto_xy rato_x, rato_y
; 	mov	ah, 02H
; 	mov	dl, ' '
; 	int	21H
; 	mov	bl, rato_x
; 	mov	posx, bl
; 	inc	posx
; 	goto_xy posx, rato_y
; 	mov	ah, 02H
; 	mov	dl, ' '
; 	int 21H
; 	goto_xy posx, posy

; fim_1:
; 	pop dx
; 	pop	bx
; 	pop	ax
; 	ret
; verifica_rato endp
; :::::::::::::::::: Start Game ::::::::::::::::::
start_game proc
	lea		dx, GameBoardView
	mov		ah, 09h
	int		21H

	cmp		difficulty, 1
	je		slug_level
	cmp		difficulty, 2
	je		hare_level
	goto_xy	posxlevel, posylevel
	lea		dx, cheetah_label
	mov		ah,	09h
	int		21h
	jmp		@@asd

slug_level:
	goto_xy	posxlevel, posylevel
	lea		dx, slug_label
	mov		ah,	09h
	int		21h
	jmp		@@asd
hare_level:
	goto_xy	posxlevel, posylevel
	lea		dx, hare_label
	mov		ah,	09h
	int		21h

@@asd:
	xor		ax,	ax
	xor		bx, bx
	call 	CalcAleat
	call	valid_Xcoord
	mov 	head_x, al
	mov 	tail_x, al
	call	CalcAleat
	call	valid_Ycoord
	cmp al, 12
	ja abv12
	mov 	tail_y, al
	inc 	al
	mov 	head_y, al
	mov 	direccao, 3
continue_setup:	
	mov  	tam, 0
	mov 	nr_ratos, 0
	mov 	rato_mov, 99
	xor		ax, ax
	call	mostra_pontuacao
	call 	move_snake
	; cmp		al, 1Bh		; considerando que sempre o jogo acaba o jogador perdeu
	; call	are_you_sure_about_that
	; call	game_over		; podemos validar o ESC para perguntar se quer mesmo sair
	ret
abv12:
	mov 	tail_y, al
	dec 	al
	mov 	head_y, al
	mov 	direccao, 1
	jmp continue_setup
start_game endp

start_bonus_game proc
	lea		dx, map_editor
	call	LoadEditorToMemory
start_game_1:
	lea	dx, MapEditor
	mov		ah, 09H
	int		21h

	cmp		difficulty, 1
	je		slug_level

	cmp		difficulty, 2
	je		hare_level
	goto_xy	posxlevel, posylevel

	lea		dx, cheetah_label
	mov		ah,	09h
	int		21h

	jmp		@@asd

slug_level:
	goto_xy	posxlevel, posylevel
	lea		dx, slug_label
	mov		ah,	09h
	int		21h
	jmp		@@asd
hare_level:
	goto_xy	posxlevel, posylevel
	lea		dx, hare_label
	mov		ah,	09h
	int		21h

@@asd:
	xor		ax,	ax
	xor		bx, bx
	; TODO: validar se a cabeça da cobra não nasce em cima de um muro   -> DONE! maybe
	call 	CalcAleat
	call	valid_Xcoord
	mov 	head_x, al
	mov 	tail_x, al
	call	CalcAleat
	call	valid_Ycoord
	mov 	tail_y, al
	goto_xy	head_x, tail_y			; colocar o cursor nessa posicao
	
	mov		ah, 08H
	mov		bh, 0				; le o caracter que esta na posicao atual do cursor
	int		10h
	cmp al, '#'
	je @@asd	
	cmp al, 12
	ja abv12
	mov 	al, tail_y
	inc 	al
	mov 	head_y, al
	mov 	direccao, 3
	jmp test_pos

continue_setup:	
	mov  	tam, 0
	mov		nr_macas, 0
	mov 	rato_mov, 99
	xor		ax, ax
	call	mostra_pontuacao
	call 	bonus_move_snake
	cmp		vidas, 0
	JE		fim_bonus_game
	jmp	start_game_1

fim_bonus_game:
	call	regista_nome
	ret

abv12:
	mov 	al, tail_y
	dec 	al
	mov 	head_y, al
	mov 	direccao, 1
	jmp test_pos

test_pos:
	goto_xy head_x, head_y
	mov		ah, 08H
	mov		bh, 0				; le o caracter que esta na posicao atual do cursor
	int		10h
	cmp al, '#'
	je @@asd
	jmp continue_setup

start_bonus_game endp
; :::::::::::::::::: Start Game ::::::::::::::::::

regista_nome proc
	call clear_screen
	push ax
	lea dx, SaveNameView
	mov	ah, 09H
	int 21h
	call get_player_name

	; call clear_screen
	; lea dx, player_name
	; mov ah, 09H
	; int 21H
	; call get_menu_option

	pop ax
	ret
regista_nome endp

get_player_name proc
	push ax
	push bx
	push cx
	push dx
	xor si, si
	mov cx, 4
	mov posx, 32
ciclo:
	goto_xy		posx, 19			; Vai para posição do cursor
	call get_char
	cmp	al, 13				; enter
	je	fim_name
	cmp al, 08 			; backspace
	je	apaga_char
	
	cmp al, 61h  ; 'a'
	jge to_caps

tb:
	mov ah, 02
	mov dl, al
	int 21h
	jmp add_char

to_caps:
	sub al, 32
	jmp tb

add_char:
	mov player_name[si], al
	add posx, 2
	inc si
	loop ciclo
	jmp fim_name

apaga_char:
	mov	ah, 02
	mov dl, '_'
	int 21h

	cmp	posx, 32
	jbe	ciclo

	dec si
	sub posx, 2
	inc cx
	jmp	ciclo	

fim_name:
	goto_xy 40, 19
	mov			ah,	07h
	int			21h
	pop dx
	pop cx
	pop bx
	pop ax
	ret
get_player_name endp
; :::::::::::::::::: are_you_sure_about_that? ::::::::::::::::::
are_you_sure_about_that proc
ciclo:
	lea		dx, YouSureAboutThatView
	mov		ah, 09H
	int		21h

	call	get_menu_option
	cmp		al, '0'
	JE		fim
	cmp	 	al, '1'
	je		game
	call	wrong_input
	jmp   	ciclo

game:
	call		start_game
	ret
are_you_sure_about_that endp
; :::::::::::::::::: are_you_sure_about_that? ::::::::::::::::::

; :::::::::::::::::: Game Over ::::::::::::::::::
bonus_game_over proc
	; TODO: rest em tudo o que é dados de jogo (para o caso do jogador querer voltar a jogar)
	; acho que já está feito verificar
	push ax
	push dx
	push bx
wrong_0:
	cmp vidas, 0
	jne fim_game_over

	call	UpdateStats
	call	clear_screen
	mov		tam, 0
; 	lea		dx, GameOverView
; 	mov		ah, 09h
; 	int 	21h
; 	call	get_menu_option
; 	cmp		al, '1'					; jogador nao quer voltar a jogar
; 	je		fim_game_over
; 	cmp		al, '0'					; jogador quer voltar a jogar
; 	je		restart_game
	
; 	call	wrong_input
; 	jmp		wrong_0

; restart_game:
	mov		nr_ratos, 0
	mov		nr_macas, 0
	mov		pontos, 0
	mov 	conta_MV, 0
	mov 	conta_MM, 0
	mov 	conta_RD, 0
	;call	menu_controller

fim_game_over:
	pop bx
	pop dx
	pop ax
	ret
bonus_game_over endp

game_over proc
	; TODO: rest em tudo o que é dados de jogo (para o caso do jogador querer voltar a jogar)
	; acho que já está feito verificar
	push ax
	push dx
	push bx
wrong_0:
	call	regista_nome
	call 	historico_jogos
	call	UpdateStats
	call	clear_screen
	mov		tam, 0
; 	lea		dx, GameOverView
; 	mov		ah, 09h
; 	int 	21h
; 	call	get_menu_option
; 	cmp		al, '1'					; jogador nao quer voltar a jogar
; 	je		fim_game_over
; 	cmp		al, '0'					; jogador quer voltar a jogar
; 	je		restart_game
	
; 	call	wrong_input
; 	jmp		wrong_0

; restart_game:
	mov		nr_ratos, 0
	mov		nr_macas, 0
	mov		pontos, 0
	mov 	conta_MV, 0
	mov 	conta_MM, 0
	mov 	conta_RD, 0
	;call	menu_controller

fim_game_over:
	pop bx
	pop dx
	pop ax
	ret
game_over endp
; :::::::::::::::::: Game Over ::::::::::::::::::

historico_jogos proc
	xor ax,ax
	xor bx,bx
	xor dx,dx
	xor cx,cx




	mov		ah, 3Dh					; Abrir o ficheiro
	mov 	al, 02h					; Abrir para ler e escrever 
	lea		dx, history_file		; DX aponta para o nome do ficheiro 
	int		21h						; Abre efectivamente o ficheiro (AX fica com o Handle do ficheiro)
	jc		erro_fich				; Se não existir erro escreve no ficheiro
	mov bx,ax




; append:
; 	xor dx,dx
; 	xor cx,cx
; 	mov ah, 42h
; 	mov al, 02h
; 	int 21H
; 	jc		erro_fich
	xor ax,ax
	xor si,si
	xor cx,cx
	xor dx,dx
	mov ax, pontos
	mov aux_hist_value[0], ax
	mov ax, conta_MV
	mov aux_hist_value[2], ax
	mov ax, conta_MM
	mov aux_hist_value[4], ax
	mov ax, conta_RD
	mov aux_hist_value[6], ax
	mov ah, player_name[1]
	mov al, player_name[0]
	mov aux_hist_value[8], ax
	mov ah, player_name[3]
	mov al, player_name[2]
	mov aux_hist_value[10], ax
 
order_cycle:
	mov ah, 3fh
	lea dx, aux_hist_test
	mov cx, 12
	int 21H	
	jc		erro_fich
	cmp ax, 0
	je empty
	mov ax, aux_hist_test[0]
	cmp ax, pontos
	jae test_next
	jmp write_curr

test_next:
; 	mov ah, 42h
; 	mov al, 01h
; 	xor cx,cx
; 	mov dx, 8
; 	int 21h
	jmp order_cycle

write_curr:
	mov ah, 42h
	mov al, 01h
	mov cx, -1
	mov dx, -12
	int 21h
	mov ah, 40h
	lea dx, aux_hist_value
	mov cx, 12
	int 21H	
	jc		erro_fich
	mov ax, aux_hist_test[0]
	mov aux_hist_value[0], ax
	mov ax, aux_hist_test[2]
	mov aux_hist_value[2], ax
	mov ax, aux_hist_test[4]
	mov aux_hist_value[4], ax
	mov ax, aux_hist_test[6]
	mov aux_hist_value[6], ax
	mov ax, aux_hist_test[8]
	mov aux_hist_value[8], ax
	mov ax, aux_hist_test[10]
	mov aux_hist_value[10], ax
	
rewrite_rest:
	mov ah, 3fh
	lea dx, aux_hist_test
	mov cx, 12
	int 21H	
	jc		erro_fich
	cmp ax, 0
	je empty
	mov ah, 42h
	mov al, 01h
	mov cx, -1
	mov dx, -12
	int 21h
	mov ah, 40h
	lea dx, aux_hist_value
	mov cx, 12
	int 21H	
	jc		erro_fich
	mov ax, aux_hist_test[0]
	mov aux_hist_value[0], ax
	mov ax, aux_hist_test[2]
	mov aux_hist_value[2], ax
	mov ax, aux_hist_test[4]
	mov aux_hist_value[4], ax
	mov ax, aux_hist_test[6]
	mov aux_hist_value[6], ax
	mov ax, aux_hist_test[8]
	mov aux_hist_value[8], ax
	mov ax, aux_hist_test[10]
	mov aux_hist_value[10], ax

	jmp rewrite_rest

empty:

	mov ah, 40h
	lea dx, aux_hist_value
	mov cx, 12
	int 21H


close:
	mov		ah,3eh				; fecha o ficheiro
	int		21h
	ret

erro_fich:
	mov		ah, 09h
	lea		dx, msgErrorWrite
	int		21h
	ret

erro_close_fich:
	mov		ah, 09h
	lea		dx, msgErrorClose
	int		21h	
	ret

erro_abrir_fich:
	mov		ah, 09h
	lea		dx, msgErrorCreate
	int		21h
	ret
	
historico_jogos	endp


show_history proc
	mov ah, 3Dh
	mov al, 00h
	lea dx, history_file
	int 21H
	jc erro_open_hist
	mov bx,ax
show_cycle:
	call clear_screen
	mov tam,0
	lea		dx, GameHistoryView
	mov		ah, 09H
	int		21H
	mov 	posy, 16
page_cycle:
	mov 	posx, 23
	mov ah, 3Fh 
	lea dx, aux_hist_value
	mov cx, 12
	int 21H
	jc erro_read_hist
	cmp ax, 0
	je close_hist
	xor si,si
show_single_loop:
	call limpa_aux
	mov ax, aux_hist_value[si]
	push si
	call NumbersIntoChars
	pop si
	goto_xy posx,posy
	call show_str
	add posx, 14
	add si, 2
	cmp si, 8
	jb show_single_loop
	mov posx, 9
	goto_xy posx, posy
	mov cx, 4
write_name:
	mov dx, aux_hist_value[si]
	mov ah, 02H
	int 21h
	inc si
	loop write_name
	inc posy
	inc tam
	cmp tam, 8
	jb page_cycle
page_wait:
	call get_menu_option
	cmp al, 0
	je page_wait
	jmp show_cycle

close_hist:
	mov		ah,3eh				; fecha o ficheiro
	int		21h
	ret

erro_read_hist:
	mov		ah, 09h
	lea		dx, Erro_Ler_Msg 
	int		21h	
	ret

erro_open_hist:
	mov		ah, 09h
	lea		dx, Erro_Open
	int		21h	
	ret

erro_close_hist:
	mov		ah, 09h
	lea		dx, msgErrorClose
	int		21h	
	ret

show_history endp

test_shit PROC
start_shit:
	goto_xy		21, 20			; Vai para posição do cursor
	mov			ah,	07h
	int			21h
	cmp			al, 1Bh			; ESC - Fast Ending
	jne			start_shit
	ret

test_shit endp


INICIO:
	mov     	ax, DADOS
	mov     	ds, ax
	MOV			AX,0B800H 		
	MOV			ES,AX			
	CALL 		clear_screen
	call		LoadStats
	call		menu_controller
fim:
	call clear_screen	
	mov     ah,4ch
	int     21h


CODIGO	ENDS
END	INICIO