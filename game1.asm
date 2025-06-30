INCLUDE Irvine32.inc
INCLUDE macros.inc
includelib winmm.lib

PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

.data
	; sound 
	soundName BYTE "sound.wav", 0
	SND_FILENAME DWORD 20001h			; play sound from a file
	

	; title page variables
		message1 db " _           _   _______   _         _______   _______   __    __   _______",0
        message2 db "\ \         / / |  _____| | |       |  _____| | _____ | |  \  /  | |   ____|",0
        message3 db " \ \       / /  | |__     | |       | |       | |   | | | \ \/ / | |  |__",0
        message4 db "  \ \  _  / /   |  __|    | |       | |       | |   | | | |    | | |   __|",0
        message5 db "   \ \/_\/ /    | |_____  | |_____  | |_____  | |___| | | |    | | |  |____",0
        message6 db "    \_/ \_/     |_______| |_______| |_______| |_______| |_|    |_| |_______|",0
        message7 db " _______    _______",0
        message8 db "|__   __|  |  ___  |",0
        message9 db "   | |     | |   | |",0
        message10 db "   | |     | |   | |",0
        message11 db "   | |     | |___| |",0
        message12 db "   |_|     |_______|",0
        message19 db "  _____   _____   ___   _____   _   __ ",0
        message20 db " |  _  \ |  _  \ |   | | ____| | | / / ",0
        message21 db " | |_| | | |_| |  | |  | |     | |/ /  ",0
        message22 db " |  _  { |  _  /  | |  | |     |    \  ",0
        message23 db " | |_| | | | \ \  | |  | |___  | |\  \ ",0
        message24 db " |_____/ |_|  \_\|___| |_____| |_| \__\ ",0
        message13 db "  _____   _____    ______       ___       _   __   ______   _____ ",0
        message14 db " |  _  \ |  _  \  |  ____|     /   \     | | / /  |  ____| |  _  \ ",0
        message15 db " | |_| | | |_| |  | |___      /  ^  \    | |/ /   | |___   | |_| | ",0
        message16 db " |  _  { |  _  /  |  ___|    /  /_\  \   |    \   |  ___|  |  _  /",0
        message17 db " | |_| | | | \ \  | |____   /  _____  \  | |\  \  | |____  | | \ \ ",0
        message18 db " |_____/ |_|  \_\ |______| /__/     \__\ |_| \__\ |______| |_|  \_\ ",0
        message25 db "Please enter your name: ",0
        
	;leaderboard variables
	fileName BYTE "input.txt", 0
	inputString BYTE 300 DUP(0)
	outputString BYTE 300 DUP(0)
	fileHandle DD 0
	tempString BYTE 5 DUP(0)
	tempInteger DD 0

	string1 byte 20 DUP(0)
	string2 byte 20 DUP(0)
	string3 byte 20 DUP(0)
	string4 byte 20 DUP(0)
	string5 byte 20 DUP(0)
	string6 byte 20 DUP(0)
	string7 byte 20 DUP(0)
	string8 byte 20 DUP(0)
	string9 byte 20 DUP(0)
	string10 byte 20 DUP(0)
	result DD 0

	nameArray DD OFFSET string1, OFFSET string2, OFFSET string3, OFFSET string4, OFFSET string5, OFFSET string6, OFFSET string7, OFFSET string8, OFFSET string9, OFFSET string10
	scoreArray DD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
	levelArray BYTE 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	

	; coordinates of the bricks
	xStart	BYTE 1 , 13, 25, 37, 49, 61, 1 , 13, 25, 37, 49, 61, 1 , 13, 25, 37, 49, 61, 1 , 13, 25, 37, 49, 61
	xxEND	BYTE 12, 24, 36, 48, 60, 72, 12, 24, 36, 48, 60, 72, 12, 24, 36, 48, 60, 72, 12, 24, 36, 48, 60, 72
	yStart	BYTE 1 , 1 , 1 , 1 , 1 , 1 , 3 , 3 , 3 , 3 , 3 , 3 , 5 , 5 , 5 , 5 , 5 , 5 , 7 , 7 , 7 , 7 , 7 , 7
	yEnd	BYTE 2 , 2 , 2 , 2 , 2 , 2 , 4 , 4 , 4 , 4 , 4 , 4 , 6 , 6 , 6 , 6 , 6 , 6 , 8 , 8 , 8 , 8 , 8 , 8
	toDraw	BYTE 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1
	color	BYTE 11, 14, 11, 14, 11, 14, 14, 11, 14, 11, 14, 11, 11, 14, 11, 14, 11, 14, 14, 11, 14, 11, 14, 11
	color2	BYTE 3 , 12, 3 , 12, 3 , 12, 12, 3 , 12, 3 , 12, 3 , 3 , 12, 3 , 12, 3 , 12, 12, 3 , 12, 3 , 12, 3
	color3	BYTE 1 , 4 , 1 , 4 , 1 , 4 , 4 , 1 , 4 , 1 , 4 , 1 , 1 , 4 , 1 , 4 , 1 , 4 , 8 , 1 , 4 , 1 , 4 , 8


	; menu Variables
	menuPrompt1 BYTE "Start", 0
	menuPrompt2 BYTE "LeaderBoard", 0
	menuPrompt3 BYTE "Instruction", 0
	menuPrompt4 BYTE "Exit Game", 0
	addresses DWORD OFFSET menuPrompt1, OFFSET menuPrompt2, OFFSET menuPrompt3, OFFSET menuPrompt4
	menuX	  BYTE  34, 31, 31, 32
	menuY	  BYTE  14, 16, 18, 20
	menuControl BYTE 0

	; level Variables
	levelPrompt1 BYTE "Level 1", 0
	levelPrompt2 BYTE "Level 2", 0
	levelPrompt3 BYTE "Level 3", 0
	levelAddresses DWORD OFFSET levelPrompt1, OFFSET levelPrompt2, OFFSET levelPrompt3
	levelY	  BYTE 14, 16, 18
	levelX    BYTE 33, 33, 33
	levelControl BYTE 0
	
	; bar variables
	barX	BYTE 31						; x coordinate of bar
	barX1   BYTE 38
	barY	BYTE 28						; y coordinate of bar
	bar1Lenh BYTE 7						; length of the bar of level 1
	bar2Lenh BYTE 5						; length of the bar of level 2
	bar1Len BYTE 14
	bar2Len BYTE 10

	; ball variables
	posX	BYTE 0
	posY	BYTE 27
	ballCh	BYTE 'O'
	directX BYTE 1						; 0 for left and 1 for right
	directY BYTE 1						; 0 for down and 1 for up

	; boundary variables
	boundX BYTE	0 , 73, 0 , 0
	boundY BYTE 0 , 1 , 0 ,29
	boundASCII BYTE 219, 219, 220, 223

	; menu boundary variables
	menuBoundX BYTE 25, 47, 25, 25
	menuBoundY BYTE 11, 12, 11, 22
	menuBoundAscii BYTE 186, 186, 205, 205
	menuCornerX BYTE 25, 47, 25, 47
	menuCornerY BYTE 11, 11, 22, 22
	menuCornerAscii BYTE 201, 187, 200, 188

	; variables for game control
	pages	BYTE 0						; variable to identify the current page of the game
										; 0 for title page
										; 1 for menu page
										; 2 for levels page
										; 3 for game page
										; 4 for leaderboard
										; 5 for instructions
										; 6 for exit
	level	BYTE 1						; Variable to identify the level of the game (1 for level 1, 2 for level 2 and 3 for level 3)
	gamePlay BYTE 1
	randomBrick BYTE 22
	randomIndex BYTE 0
	randomCount BYTE 0
	cornerHit BYTE 0
	time DD 240000
	cornerCheck BYTE 0

	; Variables to iterate different loops
	i BYTE 0
	j BYTE 0
	k BYTE 0
	l BYTE 0
	a DD 0
	b DD 0


	; input variables
	playername BYTE 30 DUP(0)
	inputChar BYTE 0

	; variables
	lifeNum BYTE 3
	score DD 0

.code

;----------------------------------------------------------- STRING TO INT ----------------------------------------------------
stringToInt PROC								; NOOR
	DEC ecx
	MOV result, 0
	MOV eax, 1											; ecx = length of string
LOOP1:													; esi address of string
	MOV ebx, eax
	MOV eax, 0
	MOV al, [esi + (ecx - 1)]
	SUB al, '0'										; converting it into integer
	MUL ebx
	ADD eax, result
	MOV result, eax
	MOV eax, ebx
	MOV ebx, 10										
	MUL ebx											; multiplying by 10 after every loop
	DEC ecx
	CMP ecx, 0
	JNE LOOP1								
													; answer stored in result
	ret
stringToInt ENDP
;--------------------------------------------------------- READ FILE DATA ------------------------------------------------------
readFileData PROC								; MOEEZ
	MOV eax, 0
	MOV edx, OFFSET fileName
	CALL OpenInputFile
	MOV fileHandle, eax

	MOV eax, filehandle
	MOV edx, OFFSET inputString					; reading data from file in inputString
	MOV ecx, LENGTHOF inputString
	CALL ReadFromFile

	MOV eax, filehandle
	CALL CloseFile


	ret
readFileData ENDP
;-------------------------------------------------------- SEPARATE STRINGS -----------------------------------------------------
separateStrings PROC							;MOEEZ
	MOV a, 0
	MOV ecx, 0									; initializing the iterators with 0
	MOV ebx, 0
SEPARATE_LOOP:					
	
	MOV b, 0
	STRINGS_LOOP:								; loop to store the name of the player
		MOV ecx, a
		MOV esi, nameArray[ecx * 4]				; loading the address of the strings from array of addresses of strings in esi
		MOV al, inputString[ebx]				; storing the character from the inputString 
		CMP al, '.'								; comparing it with '.'
		JE STRINGS_LOOP_SKIP1					; if it is a dot then skip to store the score of the player
		MOV ecx, b
		MOV [esi + ecx], al						; if not equal to dot, then append it in name of the player

		INC ebx									; incrementing the counters
		INC b
		JMP STRINGS_LOOP
	STRINGS_LOOP_SKIP1:
	INC ebx										; to skip the '.'

	MOV b, 0
	STRINGS_LOOP1:								; loop to store the score of the player
		MOV esi, OFFSET tempString				; storing the address of temostring in esi
		MOV al, inputString[ebx]
		CMP al, '.'								; comparing character with dot '.'
		JE STRINGS_LOOP_SKIP2					; if it is a dot then skip and break loop
		MOV ecx, b
		MOV [esi + ecx], al						; if it is not a dot then store it in tempstring

		INC ebx
		INC b
		JMP STRINGS_LOOP1
	
	STRINGS_LOOP_SKIP2:

	PUSH edx								; pushing in stack to save values before function call
	PUSH ecx
	PUSH ebx

	MOV ecx, b
	MOV edx, 0
	MOV [esi + ecx], dl						; putting null character at the end of the tempString
	INC b

	MOV esi, OFFSET tempString				; arguments for function, offset of tempstring (string to convert to int)	
	MOV ecx, b								; argument for function, length of string
	CALL stringToInt						; converting it to int
	MOV ecx, a
	MOV ebx, result
	MOV scoreArray[ecx * 4], ebx			; storing integer value in score Array

	POP ebx
	POP ecx
	POP edx

	INC ebx

	MOV al, inputString[ebx]
	SUB al, '0'
	MOV ecx, a
	MOV levelArray[ecx], al
	INC ebx
	INC ebx									; incrementing the iterators
	INC a
	CMP a, 5
	JL SEPARATE_LOOP
;;;;;;;
SEPARATE_LOOP2:
	MOV b, 0
	STRINGS_LOOP2:								; loop to store the name of the player
		MOV ecx, a
		MOV esi, nameArray[ecx * 4]				; loading the address of the strings from array of addresses of strings in esi
		MOV al, inputString[ebx]				; storing the character from the inputString 
		CMP al, '.'								; comparing it with '.'
		JE STRINGS_LOOP_SKIP3					; if it is a dot then skip to store the score of the player
		MOV ecx, b
		MOV [esi + ecx], al						; if not equal to dot, then append it in name of the player

		INC ebx									; incrementing the counters
		INC b
		JMP STRINGS_LOOP2
	STRINGS_LOOP_SKIP3:
	INC ebx										; to skip the '.'

	MOV b, 0
	STRINGS_LOOP3:								; loop to store the score of the player
		MOV esi, OFFSET tempString				; storing the address of temostring in esi
		MOV al, inputString[ebx]
		CMP al, '.'								; comparing character with dot '.'
		JE STRINGS_LOOP_SKIP4					; if it is a dot then skip and break loop
		MOV ecx, b
		MOV [esi + ecx], al						; if it is not a dot then store it in tempstring

		INC ebx
		INC b
		JMP STRINGS_LOOP3
	
	STRINGS_LOOP_SKIP4:

	PUSH edx								; pushing in stack to save values before function call
	PUSH ecx
	PUSH ebx

	MOV ecx, b
	MOV edx, 0
	MOV [esi + ecx], dl						; putting null character at the end of the tempString
	INC b

	MOV esi, OFFSET tempString				; arguments for function, offset of tempstring (string to convert to int)	
	MOV ecx, b								; argument for function, length of string
	CALL stringToInt						; converting it to int
	MOV ecx, a
	MOV ebx, result
	MOV scoreArray[ecx * 4], ebx			; storing integer value in score Array

	POP ebx
	POP ecx
	POP edx

	INC ebx

	MOV al, inputString[ebx]
	SUB al, '0'
	MOV ecx, a
	MOV levelArray[ecx], al
	INC ebx
	INC ebx									; incrementing the iterators
	INC a
	CMP a, 10
	JL SEPARATE_LOOP2

	ret
separateStrings ENDP
;--------------------------------------------------------- SORT LEADER BOARD -------------------------------------------------------
setLeaderBoard PROC										; MOEEZ
	MOV eax, 10											; storing 10 in eax to check if the score board is changed or not
	MOV edx, score

	MOV ebx, -1
POSITION_CHECK_LOOP:
	CMP ebx, 10
	JE EXIT_LOOP
	INC ebx
	CMP edx, scoreArray[ebx * 4]					; comparing current score with all other scores in leaderboard
	JLE POSITION_CHECK_LOOP
	CMP ebx, 10
	JE EXIT_LOOP
	MOV ecx, 9								; using formula, (9 - ebx) will give us the number of shifts we have to apply
	SUB ecx, ebx
	MOV eax, ecx

EXIT_LOOP:
	CMP eax, 10
	JE NOT_CHANGE
	MOV ecx, eax
	MOV ebx, 8											; starting shifting from second last player
SHIFT_LOOP:
	CMP ecx, 0
	JE SKIP_LOOP
	MOV edx, scoreArray[ebx * 4]
	MOV scoreArray[(ebx * 4) + 4], edx					; shifting the score of players down

	MOV dl, levelArray[ebx]								; shifting the levels of the players down
	MOV levelArray[ebx + 1], dl

	MOV esi, nameArray[ebx * 4]							; shifting the names of the players down
	MOV edi, nameArray[(ebx * 4) + 4]
	INVOKE Str_copy, esi, edi							; copying data of esi in edi

	DEC ebx
	DEC ecx
	CMP ecx, 0
	JNE SHIFT_LOOP

	CMP ecx, 0
	JE SKIP_LOOP

	;MOV edx, scoreArray[ebx * 4]
	;MOV scoreArray[(ebx * 4) + 4], edx				; shifiting the score of the player
	;
	;MOV dl, levelArray[ebx]
	;MOV levelArray[ebx + 1], dl						; shifting the score of the player
	;
	;MOV esi, nameArray[ebx * 4]
	;MOV edi, nameArray[(ebx * 4) + 4]				; shifting the score of the player
	;INVOKE Str_copy, esi, edi

SKIP_LOOP:
	MOV ebx, 9
	SUB ebx, eax						; using formula, (9 - eax) will give us the index in which we have to place the data
	MOV eax, score
	MOV scoreArray[ebx * 4], eax			; storing the current score at that place
	INVOKE Str_copy, OFFSET playerName, nameArray[ebx * 4]			; copying the name of the current player at that place

	MOV dl, level
	MOV levelArray[ebx], dl					; moving the level at that place

NOT_CHANGE:
	MOV score, 0
	ret
setLeaderBoard ENDP
;-------------------------------------------------------------- INT TO STRING -------------------------------------------------
intToString PROC									; NOOR
	PUSH eax					; pushing all registers in stack to save their values
	PUSH ebx
	PUSH ecx
	PUSH edx
	; integer is passed in tempInteger
	; answer string is returned in tempString
	MOV ecx, 0
	MOV eax, tempInteger
	MOV ebx, 10
DIGIT_COUNT_LOOP:
	MOV edx, 0
	INC ecx									; incrementing the number of digits in a integer
	DIV ebx
	CMP eax, 0
	JE EXIT_DIGIT_COUNT_LOOP
	JMP DIGIT_COUNT_LOOP
EXIT_DIGIT_COUNT_LOOP:
	;now ecx contains the count of digits
	MOV tempString[ecx], 0					; moving null character at the end of the string
	MOV eax, tempInteger							
	MOV ebx, 10
CONVERSION_LOOP:
	MOV edx, 0
	DIV ebx
	ADD dl, '0'
	MOV tempString[ecx - 1], dl
	DEC ecx
	CMP ecx, 0
	JG CONVERSION_LOOP

	POP edx									; popping the values of the registers from the stack
	POP ecx
	POP ebx
	POP eax

	ret
intToString ENDP
;----------------------------------------------------------- APPEND TWO STRINGS ------------------------------------------------------
appendTwoStrings PROC								; NOOR				
	; esi -> contains address of string 1
	; edi -> contains address of string 2
	; appending esi in edi
	; ebx, contains index for edi
	; ecx, contains index for esi
	MOV ecx, 0
APPEND_LOOP:
	MOV al, [esi + ecx]
	CMP al, 0							; checking if the character is null character 
	JE STOP_APPENDING					; if null, then stop loop
	MOV [edi + ebx], al					; else append it in parent string
	INC ebx								; incrementing index of parent string (outputString)
	INC ecx
	JMP APPEND_LOOP
STOP_APPENDING:
	MOV al, '.'
	MOV [edi + ebx], al					; moving '.' after appending every string
	INC ebx
	ret
appendTwoStrings ENDP
;------------------------------------------------------------ WRITE DATA IN FILE -----------------------------------------------
writeDataInFile PROC						; BOTH
	MOV ebx, 0							; index for parent string (outputString)
	MOV edx, 0							; index to traverse strings array and control the loop (10 times repetition)
APPEND_LOOP_FOR_ALL:
	MOV ecx, 0							; index for substrings
	MOV esi, nameArray[edx * 4]
	MOV edi, OFFSET outputString
	CALL appendTwoStrings

	MOV eax, scoreArray[edx * 4]
	MOV tempInteger, eax					; moving score in tempinteger to convert it into string
	CALL intToString
	MOV esi, OFFSET tempString
	MOV edi, OFFSET outputString
	CALL appendTwoStrings					; appending the score in the outputString

	MOV al, levelArray[edx]
	ADD al, '0'								; converting the level into its ascii
	MOV outputString[ebx], al				; appending it in the parent string 
	INC ebx
	MOV al, '.'								; appending dot after level 
	MOV outputString[ebx], al				
	INC ebx
	INC edx

	CMP edx, 10
	JL APPEND_LOOP_FOR_ALL


	; function to open existing file and the filehandle is stored in eax
	INVOKE CreateFile, ADDR fileName, GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    MOV fileHandle, eax                 ; Store the file handle

	MOV eax, filehandle
	MOV edx, OFFSET outputString					; writing outputString in file
	MOV ecx, LENGTHOF outputString
	DEC ecx
	CALL writetofile


	MOV eax, filehandle
	CALL CloseFile


	ret
writeDataInFile ENDP
;-------------------------------------------------------------- DISPLAY LEADER BOARD -------------------------------------------
displayLeaderBoard PROC							; MOEEZ
	MOV eax, 3
	CALL SetTextColor
	MOV dh, 3
	MOV dl, 28
	CALL Gotoxy
	MOV eax, 201
	CALL WriteChar								; printing top left corner
	MOV ecx, 0
LINE_LOOP1:										; loop to print upper horizontal boundary
	MOV eax, 205
	CALL WriteChar						
	INC ecx
	CMP ecx, 15
	JNE LINE_LOOP1

	MOV eax, 187								; printing the top right corner
	CALL WriteChar

	MOV dh, 5
	MOV dl, 28
	CALL Gotoxy
	MOV eax, 200
	CALL WriteChar								; printing the bottom left corner
	MOV ecx, 0
LINE_LOOP2:
	MOV eax, 205
	CALL WriteChar								; printing the lower horizontal boundary
	INC ecx
	CMP ecx, 15
	JNE LINE_LOOP2

	MOV eax, 188								; printing the bottom right corner
	CALL WriteChar

	MOV dh, 4
	MOV dl, 28
	CALL Gotoxy
	MOV eax, 186								; printing the left vertical boundary
	CALL WriteChar
	MOV dl, 44
	CALL Gotoxy									
	CALL WriteChar								; printing the right vertical boundary

	MOV dh, 4
	MOV dl, 31
	CALL Gotoxy
	MOV eax, 14
	CALL SetTextColor
	MWRITE "LeaderBoard"						; printing the leader board in the box
	MOV eax, 15
	CALL SetTextColor
	CALL displayBoundary
	
	MOV eax, 1
	MOV ebx, 0
	MOV dh, 8
	MOV dl, 15
NAME_PRINT_LOOP:
	CALL Gotoxy
	CMP eax, 10									; printing the numbers in leaderboard
	JE SPACE_SKIP
	MWRITE " "
SPACE_SKIP:
	CALL WriteDec
	MWRITE ". "
	MOV cx, dx	
	MOV edx, nameArray[ebx * 4]					; printing the names of the players
	CALL WriteString
	MOV dx, cx
	ADD dh, 2
	INC eax
	INC ebx
	CMP eax, 11
	JNE NAME_PRINT_LOOP

	MOV ebx, 0
	MOV dh, 8
	MOV dl, 46
SCORE_PRINT_LOOP:
	CALL Gotoxy
	MOV eax, scoreArray[ebx * 4]
	CALL WriteDec
	ADD dh, 2
	INC ebx
	CMP ebx, 10
	JNE SCORE_PRINT_LOOP

	MOV ebx, 0
	MOV dh, 8
	MOV dl, 57
LEVEL_PRINT_LOOP:
	CALL Gotoxy
	MOVZX eax, levelArray[ebx]
	CALL WriteDec
	ADD dh, 2
	INC ebx
	CMP ebx, 10
	JNE LEVEL_PRINT_LOOP

	MOV eax, 3
	CALL SetTextColor
	MOV dh, 7
	MOV dl, 21
	CALL Gotoxy									; printing the heading "Name"
	MWRITE "Name"
	
	MOV dh, 7
	MOV dl, 45
	CALL Gotoxy									; printing the heading "Score"
	MWRITE "Score"

	MOV dh, 7
	MOV dl, 55
	CALL Gotoxy									; printing the heading "Level"
	MWRITE "Level"

	ret
displayLeaderBoard ENDP
;---------------------------------------------------- DISPLAY INSTRUCTIONS ---------------------------------------------
displayInstructions PROC						; NOOR
	MOV eax, 3
	CALL SetTextColor
	MOV dh, 3
	MOV dl, 28
	CALL Gotoxy
	MOV eax, 201
	CALL WriteChar								; printing top left corner
	MOV ecx, 0
LINE_LOOP1:										; loop to print upper horizontal boundary
	MOV eax, 205
	CALL WriteChar						
	INC ecx
	CMP ecx, 15
	JNE LINE_LOOP1

	MOV eax, 187								; printing the top right corner
	CALL WriteChar

	MOV dh, 5
	MOV dl, 28
	CALL Gotoxy
	MOV eax, 200
	CALL WriteChar								; printing the bottom left corner
	MOV ecx, 0
LINE_LOOP2:
	MOV eax, 205
	CALL WriteChar								; printing the lower horizontal boundary
	INC ecx
	CMP ecx, 15
	JNE LINE_LOOP2

	MOV eax, 188								; printing the bottom right corner
	CALL WriteChar

	MOV dh, 4
	MOV dl, 28
	CALL Gotoxy
	MOV eax, 186								; printing the left vertical boundary
	CALL WriteChar
	MOV dl, 44
	CALL Gotoxy									
	CALL WriteChar								; printing the right vertical boundary

	MOV dh, 4
	MOV dl, 31
	CALL Gotoxy
	MOV eax, 14
	CALL SetTextColor
	MWRITE "Instruction"						; printing the instructions in the box
	MOV eax, 15
	CALL SetTextColor
	CALL displayBoundary
	
	MOV dh, 8
	MOV dl, 10
	CALL Gotoxy
	MWRITE "1. Use arrow keys to navigate through menu and press "
	ADD dh, 1
	CALL Gotoxy
	MWRITE "   enter to select"
	ADD dh, 2
	CALL Gotoxy
    MWRITE "2. Press B to go back to previous pages",0
	ADD dh, 2
	CALL Gotoxy
    MWRITE "3. Press x to exit the game",0
	ADD dh, 2
	CALL Gotoxy
    MWRITE "4. Use left and right arrow keys to control paddle",0
	ADD dh, 2
	CALL Gotoxy
    MWRITE "5. press to p to play/pause game",0



	ret
displayInstructions ENDP

;----------------------------------------------------- DISPLAY NAME ----------------------------------------------------
displayName PROC									; NOOR
	MOV eax, 15
	CALL SetTextColor
	MOV dh, 0
	MOV dl, 80
	CALL Gotoxy					; go to (80, 0) coordinates to print name
	MWRITE "Name: "
	MOV edx, OFFSET playername
	CALL WriteString

	ret
displayName ENDP

;----------------------------------------------------- DISPLAY LIVES ----------------------------------------------------
displayLives PROC									; NOOR

	MOV eax, 15
	CALL SetTextColor
	MOV dh, 3
	MOV dl, 80
	CALL Gotoxy
	MWRITE "Lives: "
	MWRITE "   "
	MOV ecx, 0
	MOV dl, 87
	CALL Gotoxy
	CMP lifeNum, 0
	JE SKIP1
LOOP1:							; loop to print lives of a player 
	MWRITE '*'
	INC ecx
	CMP cl, lifeNum
	JNE LOOP1
SKIP1:

	ret
displayLives ENDP

;----------------------------------------------------- DISPLAY SCORE ----------------------------------------------------
displayScore PROC									; NOOR
	MOV eax, 15
	CALL SetTextColor
	MOV dh, 5
	MOV dl, 80
	CALL Gotoxy
	MWRITE "Score: "
	MOV eax, 0
	MOV eax, score
	CALL WriteDec

	ret
displayScore ENDP

;----------------------------------------------------- DISPLAY BAR ----------------------------------------------------
displayBar PROC
	MOV dh, barY				; moving the bar coordinates
	MOV dl, barX
	CMP level, 1				; checking for the level
	JNE SKIP1
	CALL Gotoxy
	MOV ecx, 0
	
	MOV eax, 14
	CALL SetTextColor			; setting color to yellow
LOOP1:							; loop to print bar, by ascii of 254 of length 14
	MOV eax, 223				
	CALL WriteChar				; printing the bar for level 1
	INC ecx
	CMP cl, bar1Len
	JNE LOOP1
	
	JMP SKIP2
SKIP1:
	CALL Gotoxy
	MOV ecx, 0
	MOV eax, 14
	CALL SetTextColor			; setting color to yellow
LOOP2:							; loop to print bar, by ascii of 254 of length 10
	MOV eax, 223
	CALL WriteChar				; printing the bar for level 2
	INC ecx
	CMP cl, bar2Len
	JNE LOOP2
SKIP2:
	MOV eax, 15
	CALL SetTextColor

	ret
displayBar ENDP

; --------------------------------------------- DISPLAY BOUNDARY --------------------------------------------------------
displayBoundary PROC							; MOEEZ
	MOV eax, 15							; setting color to white again (white = 15)
	CALL SetTextColor
		
	MOV ebx, 0
BOUNDARY_LOOP:									; Nested loop to print the boundaries
	MOV dh, boundY[ebx]
	MOV dl, boundX[ebx]
	MOV ecx, 0
	LOOP1:									
		CALL Gotoxy
		MOV eax, 0
		MOV al, boundASCII[ebx]
		CALL WriteChar
		CMP ebx, 2
		JGE SKIP1
		INC dh
		CMP dh, 30
		JNE LOOP1
		JMP SKIP2
	SKIP1:
		INC dl
		CMP dl, 74
		JNE LOOP1
SKIP2:
	INC ebx
	CMP ebx, 4
	JNE BOUNDARY_LOOP

	ret
displayBoundary ENDP
;------------------------------------------------- DISPLAY MENU BOUNDARY -------------------------------------------------
displayMenuBoundary PROC							; moeez

	MOV eax, 3
	CALL SetTextColor
	
	MOV ebx, 0
MENU_BOUNDARY_LOOP:									; Nested loop to print the menu boundaries
	MOV dh, menuBoundY[ebx]
	MOV dl, menuBoundX[ebx]
	MOV ecx, 0
	LOOP1:									
		CALL Gotoxy
		MOV eax, 0
		MOV al, menuBoundASCII[ebx]
		CALL WriteChar
		CMP ebx, 2
		JGE SKIP1
		INC dh
		CMP dh, 22
		JNE LOOP1
		JMP SKIP2
	SKIP1:
		INC dl
		CMP dl, 48
		JNE LOOP1
SKIP2:
	INC ebx
	CMP ebx, 4
	JNE MENU_BOUNDARY_LOOP

	MOV ebx, 0
LOOP2:										; loop to print corners of menu boundary
	MOV dh, menuCornerY[ebx]
	MOV dl, menuCornerX[ebx]
	CALL Gotoxy
	MOV eax, 0
	MOV al, menuCornerAscii[ebx]
	CALL WriteChar
	INC ebx
	CMP ebx, 4
	JNE LOOP2

	MOV eax, 15							; setting color to white again (white = 15)
	CALL SetTextColor

	ret
displayMenuBoundary ENDP
;----------------------------------------------------- DISPLAY LEVELS -----------------------------------------------------
; function to print the prompts of level 1, 2 or 3
displayLevel PROC										; moeez
	MOV ecx, 0
LEVEL_PRINT_LOOP:
	MOV dh, levelY[ecx]
	MOV dl, levelX[ecx]
	SUB dl, 4
	CALL Gotoxy
	CMP cl, levelControl
	JNE LEVEL_PRINT_SKIP1
	MOV eax, 3
	CALL SetTextColor
	MWRITE ">>> "
	MOV eax, 14
	CALL SetTextColor
	JMP LEVEL_PRINT_SKIP2
LEVEL_PRINT_SKIP1:
	MWRITE "    "
LEVEL_PRINT_SKIP2:
	MOV edx, levelAddresses[ecx * 4]
	CALL WriteString
	CMP cl, levelControl
	JNE LEVEL_PRINT_SKIP3
	MOV eax, 3
	CALL SetTextColor
	MWRITE " <<<"
	MOV eax, 15
	CALL SetTextColor
	JMP LEVEL_PRINT_SKIP4
LEVEL_PRINT_SKIP3:
	MWRITE "    "
LEVEL_PRINT_SKIP4:
	ADD dh, 2
	INC ecx
	CMP ecx, 3
	JNE LEVEL_PRINT_LOOP

	ret
displayLevel ENDP
; ----------------------------------------------------- DISPLAY MENU -----------------------------------------------------
displayMenu PROC								; moeez
	MOV ecx, 0
MENU_PRINT_LOOP:
	MOV dh, menuY[ecx]
	MOV dl, menuX[ecx]
	SUB dl, 4
	CALL Gotoxy
	CMP cl, menuControl
	JNE MENU_PRINT_SKIP1
	MOV eax, 3
	CALL SetTextColor
	MWRITE ">>> "
	MOV eax, 14
	CALL SetTextColor
	JMP MENU_PRINT_SKIP2
MENU_PRINT_SKIP1:
	MWRITE "    "
MENU_PRINT_SKIP2:
	MOV edx, addresses[ecx * 4]
	CALL WriteString
	CMP cl, menuControl
	JNE MENU_PRINT_SKIP3
	MOV eax, 3
	CALL SetTextColor
	MWRITE " <<<"
	MOV eax, 15
	CALL SetTextColor
	JMP MENU_PRINT_SKIP4
MENU_PRINT_SKIP3:
	MWRITE "    "
MENU_PRINT_SKIP4:
	INC ecx
	CMP ecx, 4
	JNE MENU_PRINT_LOOP

	ret
displayMenu ENDP
;-------------------------------------------------------- MENU PAGE ------------------------------------------------------
menuPage PROC										; moeez
	MOV menuControl, 0
	MOV levelControl, 0
	CALL displayMenuBoundary

	MOV dh, 8
	MOV dl, 35
	CALL Gotoxy
	MWRITE "\/"
	DEC dh
	INC dl
	INC dl
	MOV eax, '/'							; printing the ball and paddle in menu screen
	CALL Gotoxy
	CALL WriteChar
	DEC dh
	INC dl
	CALL Gotoxy
	CALL WriteChar							; printing the diagonal line
	DEC dh
	INC dl
	CALL Gotoxy
	MOV eax, 1
	CALL SetTextColor
	MOV eax, 'O'							; printing the ball
	CALL WriteChar
	MOV eax, 15
	CALL SetTextColor

	MOV eax, 14
	CALL SetTextColor
	MOV dh, 9
	MOV dl, 32
	CALL Gotoxy
	MOV ecx, 0
	MOV eax, 223
PRINT_BAR_LOOP:
	CALL WriteChar
	INC ecx
	CMP ecx, 9								; printing the bar
	JNE PRINT_BAR_LOOP

	MOV eax, 3
	CALL SetTextColor
	MOV dh, 24
	MOV dl, 17
	CALL Gotoxy
	MOV ecx, 0
LINE_LOOP1:								; to print the line above the given prompt
	MOV eax, 205
	CALL WriteChar
	INC ecx
	CMP ecx, 40
	JNE LINE_LOOP1

	MOV dh, 26
	CALL Gotoxy
	MOV ecx, 0
LINE_LOOP2:								; to print the line below the given prompt
	MOV eax, 205
	CALL WriteChar
	INC ecx
	CMP ecx, 40
	JNE LINE_LOOP2
	MOV eax, 15
	CALL SetTextColor
	MOV dh, 25
	MOV dl, 17
	CALL Gotoxy
	MWRITE "Use Arrow Keys to choose and Press Enter"
	MOV dh, 3
	MOV dl, 25
	CALL Gotoxy
	MWRITE "WELCOME TO BRICK BREAKER"

	CALL displayBoundary
	CMP pages, 1
	JNE PAGE_SKIP1
	CALL displayMenu
	JMP MENU_LOOP
PAGE_SKIP1:
	CALL displayLevel
MENU_LOOP:
	MOV eax, 50
	CALL delay										; calling delay of 50 milliseconds
	MOV eax, 0
	CALL ReadKey
	MOV dh, 0
	MOV dl, 80
	CALL Gotoxy
	CMP ah, 28
	JE MENU_EXIT
	CMP eax, 0
	JE MENU_PRINT_SKIP
	CMP pages, 1
	JNE PAGE_SKIP3
	CMP ah, 72
	JNE MENU_SKIP1
	CMP menuControl, 0
	JLE MENU_PRINT_SKIP
	DEC menuControl
	JMP MENU_SKIP2
MENU_SKIP1:
	CMP ah, 80
	JNE MENU_PRINT_SKIP
	CMP menuControl, 3
	JGE MENU_PRINT_SKIP
	INC menuControl
MENU_SKIP2:
	CALL displayMenu
	JMP MENU_PRINT_SKIP
PAGE_SKIP3:
	CMP ah, 72
	JNE LEVEL_SKIP1
	CMP levelControl, 0
	JLE MENU_PRINT_SKIP
	DEC levelControl
	JMP LEVEL_SKIP2
LEVEL_SKIP1:
	CMP ah, 80
	JNE MENU_PRINT_SKIP
	CMP levelControl, 2
	JGE MENU_PRINT_SKIP
	INC levelControl
LEVEL_SKIP2:
	CALL displayLevel
MENU_PRINT_SKIP:
	JMP MENU_LOOP
MENU_EXIT:

	CMP pages, 1
	JNE PAGE_SKIP4
	CMP menuControl, 0
	JNE TRANSFER_SKIP1
	INC menuControl
	INC menuControl
	JMP TRANSFER_SKIP2
TRANSFER_SKIP1:
	INC menuControl
	INC menuControl
	INC menuControl
TRANSFER_SKIP2:
	MOV al, menuControl
	MOV pages, al
	JMP PAGE_SKIP5
PAGE_SKIP4:
	INC levelControl
	MOV al, levelControl
	MOV level, al
	INC pages
PAGE_SKIP5:

	ret
menuPage ENDP
;-------------------------------------------------------- PAUSE GAME -----------------------------------------------------
pauseGame PROC								; noor
	MOV eax, 0
LOOP1:
	CALL Readkey
	CMP al, 'p'											; if the pressed key is p or not
	JE SKIP1
	MOV dh, 20
	MOV dl, 80
	CALL Gotoxy
	MOV eax, 14
	CALL SetTextColor
	MWRITE "Game Paused. Press 'p' to resume"
	MOV eax, 500
	CALL delay											; calling delay to create a blinking effect (in loop)				
	CALL Gotoxy
	MWRITE "                                "
	MOV eax, 350
	CALL delay
	JMP LOOP1

SKIP1:
	MOV dh, 20
	MOV dl, 80
	CALL Gotoxy
	MWRITE "                                "			; clearing the space, if the game is resumed
	MOV eax, 15
	CALL SetTextColor
	ret
pauseGame ENDP

;----------------------------------------------------- DISPLAY BRICKS ----------------------------------------------------
; function to print the whole page and bricks
displayBricks PROC								; noor
	MOV i, 0
FIRST_LOOP:
	; loop to iterate through the array of starting coordinates
	MOV ebx, 0
	MOV bl, i
	MOV dl, toDraw[ebx]					; todraw array tells whether to draw the brick or not
	CMP dl, 0							; if the brick is hit by ball then its value becomes zero
	JNE COLOR_SKIP1						; if value is zero so skip this brick
	MOV eax, 0
	JMP COLOR_SKIP2
COLOR_SKIP1:
	MOV eax, 0
	CMP dl, 1							; checking if the todraw value is 1
	JNE COLOR_ASSIGN1
	MOV al, color[ebx]					; if 1 then setting the color from the first color array
	JMP COLOR_SKIP2
COLOR_ASSIGN1:
	CMP dl, 2							; checking if the todraw value is 2
	JNE COLOR_ASSIGN2
	MOV al, color2[ebx]					; if 2 then setting the color from the second color array
	JMP COLOR_SKIP2
COLOR_ASSIGN2:
	CMP dl, 3							; checking if the todraw value is 3
	JNE COLOR_SKIP2
	MOV al, color3[ebx]					; if 3 then setting the color from the third color array
COLOR_SKIP2:
	CALL SetTextColor					; setting color of the ith brick

	MOV dl, xStart[ebx]					; storing the starting x coordinate 
	MOV dh, yStart[ebx]					; storing the starting y coordinate
	CALL Gotoxy							; moving our cursor to starting x y coordinates of ith brick
	MOV j, dh							; storing the starting y coordinate of ith brick in j

	SECOND_LOOP:
		; loop to iterate y coordinates of ith block
		MOV k, dl						; storing the starting x coordinate of ith brick in k
		CALL Gotoxy

		THIRD_LOOP:
			; loop to iterate through x coordinates of ith block
			MOV eax, 219				; ascii of a character
			CALL WriteChar				; writing that character
			INC k						; increasing the x coordinate
			MOV ebx, 0
			MOV bl, i
			MOV cl, xxEND[ebx]			
			CMP cl, k					; comparing it with end x coordinate
			JGE THIRD_LOOP				; if k is less than equal to x end coordinate then loop

		CALL Crlf
		INC dh							; incrementing y coordinate
		INC j							; incrementing j (same as dh)
		MOV ebx, 0
		MOV bl, i
		MOV cl, yEnd[ebx]				
		CMP cl, j						; comparing it with end y coordinate
		JGE SECOND_LOOP					; if k is less than equal to y end coordinate then loop

	INC i
	MOV cl, i
	CMP cl, 12							; comparing i with the size of the coordinates array
	JNE FIRST_LOOP	

FIRST_LOOP1:
	MOV ebx, 0
	MOV bl, i
	MOV dl, toDraw[ebx]
	CMP dl, 0
	JNE COLOR_SKIP3
	MOV eax, 0
	JMP COLOR_SKIP4
COLOR_SKIP3:
	MOV eax, 0
	CMP dl, 1
	JNE COLOR_ASSIGN3
	MOV al, color[ebx]
	JMP COLOR_SKIP4
COLOR_ASSIGN3:
	CMP dl, 2							; checking if the todraw value is 2
	JNE COLOR_ASSIGN4
	MOV al, color2[ebx]					; if 2 then setting the color from the second color array
	JMP COLOR_SKIP4
COLOR_ASSIGN4:
	CMP dl, 3							; checking if the todraw value is 3
	JNE COLOR_SKIP4
	MOV al, color3[ebx]					; if 3 then setting the color from the third color array
COLOR_SKIP4:
	CALL SetTextColor					; setting color of the ith brick
	MOV dl, xStart[ebx]					; storing the starting x coordinate 
	MOV dh, yStart[ebx]					; storing the starting y coordinate
	CALL Gotoxy							; moving our cursor to starting x y coordinates of ith brick
	MOV j, dh							; storing the starting y coordinate of ith brick in j

	SECOND_LOOP1:
		; loop to iterate y coordinates of ith block
		MOV k, dl						; storing the starting x coordinate of ith brick in k
		CALL Gotoxy

		THIRD_LOOP1:
			; loop to iterate through x coordinates of ith block
			MOV eax, 219				; ascii of a character
			CALL WriteChar				; writing that character
			INC k						; increasing the x coordinate
			MOV ebx, 0
			MOV bl, i
			MOV cl, xxEND[ebx]			
			CMP cl, k					; comparing it with end x coordinate
			JGE THIRD_LOOP1				; if k is less than equal to x end coordinate then loop

		CALL Crlf
		INC dh							; incrementing y coordinate
		INC j							; incrementing j (same as dh)
		MOV ebx, 0
		MOV bl, i
		MOV cl, yEnd[ebx]				
		CMP cl, j						; comparing it with end y coordinate
		JGE SECOND_LOOP1				; if k is less than equal to y end coordinate then loop

	INC i
	MOV cl, i
	CMP cl, 24							; comparing i with the size of the coordinates array
	JNE FIRST_LOOP1
	CALL displayBoundary

	ret
displayBricks ENDP
;---------------------------------------------------- DISPLAY TITLE ---------------------------------------------------------
titlePage PROC
	mov dh,1
    mov dl,5
    call Gotoxy
    mov edx, offset message1
    call WriteString
    call CRLF
    mov dh,2
    mov dl,5
    call Gotoxy
    mov edx, offset message2
    call WriteString
    call CRLF
    mov dh,3
    mov dl,5
    call Gotoxy
    mov edx, offset message3
    call WriteString
    call CRLF
    mov dh,4
    mov dl,5
    call Gotoxy
    mov edx, offset message4
    call WriteString
    call CRLF
    mov dh,5
    mov dl,5
    call Gotoxy
    mov edx, offset message5
    call WriteString
    call CRLF
    mov dh,6
    mov dl,5
    call Gotoxy
    mov edx, offset message6
    call WriteString
    call CRLF
    mov dh,7
    mov dl,35
    call Gotoxy
    mov edx, offset message7
    call WriteString
    call CRLF
    mov dh,8
    mov dl,35
    call Gotoxy
    mov edx, offset message8
    call WriteString
    call CRLF
    mov dh,9
    mov dl,35
    call Gotoxy
    mov edx, offset message9
    call WriteString
    call CRLF
    mov dh,10
    mov dl,35
    call Gotoxy
    mov edx, offset message10
    call WriteString
    call CRLF
    mov dh,11
    mov dl,35
    call Gotoxy
    mov edx, offset message11
    call WriteString
    call CRLF
    mov dh,12
    mov dl,35
    call Gotoxy
    mov edx, offset message12
    call WriteString
    call CRLF
    mov dh,13
    mov dl,25
    call Gotoxy
    mov edx, offset message19
    call WriteString
    call CRLF
    mov dh,14
    mov dl,25
    call Gotoxy
    mov edx, offset message20
    call WriteString
    call CRLF
    mov dh,15
    mov dl,25
    call Gotoxy
    mov edx, offset message21
    call WriteString
    call CRLF
    mov dh,16
    mov dl,25
    call Gotoxy
    mov edx, offset message22
    call WriteString
    call CRLF
    mov dh,17
    mov dl,25
    call Gotoxy
    mov edx, offset message23
    call WriteString
    call CRLF
    mov dh,18
    mov dl,25
    call Gotoxy
    mov edx, offset message24
    call WriteString
    call CRLF
    mov dh,19
    mov dl,9
    call Gotoxy
    mov edx, offset message13
    call WriteString
    call CRLF
    mov dh,20
    mov dl,9
    call Gotoxy
    mov edx, offset message14
    call WriteString
    call CRLF
    mov dh,21
    mov dl,9
    call Gotoxy
    mov edx, offset message15
    call WriteString
    call CRLF
    mov dh,22
    mov dl,9
    call Gotoxy
    mov edx, offset message16
    call WriteString
    call CRLF
    mov dh,23
    mov dl,9
    call Gotoxy
    mov edx, offset message17
    call WriteString
    call CRLF
    mov dh,24
    mov dl,9
    call Gotoxy
    mov edx, offset message18
    call WriteString
    call CRLF
    mov dh,25
    mov dl,29
    call Gotoxy
	MOV eax, 15
	CALL SetTextColor
    mov edx, offset message25
    call WriteString
    mov edx, offset playerName
    mov ecx, lengthof playerName
    call ReadString

	INC pages

	ret
titlePage ENDP

;----------------------------------------------------- CONTROL BALL ----------------------------------------------------
; function to control the movement of the ball
controlBall PROC								; moeez
	MOV cornerCheck, 0
	CMP posX, 1							; if it hits the left wall
	JNE ASSIGN_SKIP1
	MOV directX, 1						; then assign right x direction
ASSIGN_SKIP1:
	CMP posX, 72						; if the ball hits the right ball
	JNE ASSIGN_SKIP2
	MOV directX, 0						; then assign left x direction
ASSIGN_SKIP2:
	MOV al, barX
	CMP posX, al						; checking the x coordinate of ball and bar (starting coordinate of bar)
	JL ASSIGN_SKIP3						; if x coordinate of ball is less than starting x coordinate of bar then skip
	CMP level, 1
	JNE SKIP1
	ADD al, bar1Lenh						; if level is 1 then length of bar is 14 and half is 7
	JMP SKIP2
SKIP1:
	ADD al, bar2Lenh						; if level is 2 then length of bar is 10 and half is 5
SKIP2:
	CMP posX, al						; checking the x coordinate of ball and bar (ending coordinate of half of the bar)
	JG ASSIGN_SKIP3						; if x coordinate of ball is greater than ending x coordinate of bar then skip
	CMP posY, 27						; checking if the ball is hitting the bar or not
	JNE ASSIGN_SKIP3					; if not then skip, otherwise change its direction to up
	MOV directY, 1
	MOV directX, 0						; if hits the left half, then always goes left
ASSIGN_SKIP3:
;
	MOV al, barX1
	CMP posX, al						; checking the x coordinate of ball and bar (starting coordinate of second half of bar)
	JL ASSIGN_SKIP6						; if x coordinate of ball is less than starting x coordinate of second half of bar then skip
	CMP level, 1
	JNE SKIP3
	ADD al, bar1Lenh						; if level is 1 then length of bar is 14 and half is 7
	JMP SKIP4
SKIP3:
	ADD al, bar2Lenh						; if level is 2 then length of bar is 10 and half is 5
SKIP4:
	CMP posX, al						; checking the x coordinate of ball and bar (ending coordinate of bar)
	JG ASSIGN_SKIP6						; if x coordinate of ball is greater than ending x coordinate of bar then skip
	CMP posY, 27						; checking if the ball is hitting the bar or not
	JNE ASSIGN_SKIP6					; if not then skip, otherwise change its direction to up
	MOV directY, 1
	MOV directX, 1						; if hits the right half, then always goes right
ASSIGN_SKIP6:

	MOV l, 0
BRICKS_CHECK_LOOP:
	MOV ecx, 0
	MOV cl, l
	MOV al, toDraw[ecx]					; checking if the brick is present or not
	CMP al, 0
	JE LOOP_CONTINUE
	MOV al, xStart[ecx]					
	CMP posX, al						; comparing x coordinate of ball and starting x coordinate of lth brick
	JL LOOP_CONTINUE					; if x coordinate of ball is less then skip (because it is not hitting that brick)
	MOV al, xxEnd[ecx]
	CMP posX, al						; comparing x coordinate of ball and ending x coordinate of lth brick
	JG LOOP_CONTINUE					; if x coordinate of ball is greater then skip (because it is not hitting that brick)
	MOV al, yStart[ecx]					; checking if the ball is coming from upward or downward
	DEC al
	CMP posY, al
	JE BRICK_HIT						; if the brick is coming from upward
	MOV al, yEnd[ecx]
	INC al								
	CMP posY, al
	JE BRICK_HIT						; if the brick is coming from downward
	JMP LOOP_CONTINUE
BRICK_HIT:
	PUSH eax
	PUSH ebx
	PUSH ecx
	PUSH edx
	invoke PlaySound, ADDR soundName, 0, SND_FILENAME
	POP edx
	POP ecx
	POP ebx
	POP eax
	MOV cornerCheck, 1
	CMP level, 3
	JNE NOT_LEVEL_3
	CMP ecx, 18							; fixed brick1
	JE SCORE_NOT_COUNT
	CMP ecx, 23							; fixed brick2
	JE SCORE_NOT_COUNT

NOT_LEVEL_3:
	MOV al, toDraw[ecx]
	DEC al								; decreasing the number of lives of brick
	MOV toDraw[ecx], al
	JNE SCORE_NOT_COUNT
	CMP level, 3
	JNE RANDOM_BRICK_SKIP
	CMP cl, randomBrick					
	JNE RANDOM_BRICK_SKIP
	MOV randomIndex, 23
	MOV randomCount, 0
RANDOM_BRICK_LOOP:
	MOV eax, 0
	MOV al, randomIndex					; index to traverse all bricks
	CMP toDraw[eax], 0					; checking if the brick is a valid brick or not
	JE RANDOM_NOT_SKIP
	CMP eax, 18							; skipping fixed brick 1
	JE RANDOM_NOT_SKIP
	CMP eax, 23							; skipping fixed brick 2
	JE RANDOM_NOT_SKIP
	MOV toDraw[eax], 0					; breaking the current brick
	INC randomCount
RANDOM_NOT_SKIP:

	CMP randomCount, 5					; if 5 bricks are broken down
	JE RANDOM_BRICK_SKIP
	DEC randomIndex
	CMP randomIndex, -1					; if there are less than 5 bricks then this condition will occur
	JG RANDOM_BRICK_LOOP
RANDOM_BRICK_SKIP:

	MOV eax, 0
	CMP level, 1
	JNE LEVEL2_SCORE
	MOV al, color3[ecx]					; for level 1, add score from color array
	JMP SCORE_SKIP1
LEVEL2_SCORE:
	CMP level, 2
	JNE LEVEL3_SCORE
	MOV al, color2[ecx]					; for level 2, add score from color2 array
	JMP SCORE_SKIP1	
LEVEL3_SCORE:
	MOV al, color[ecx]					; for level 3, add score from color3 array
SCORE_SKIP1:
	ADD eax, score						; adding score of brick in total score
	MOV score, eax
SCORE_NOT_COUNT:
	MOV al, directY
	XOR al, 1							; inverting the vertical direction of the ball
	MOV directY, al
	CALL displayBricks
	CALL displayScore
	JMP LOOP_EXIT1
LOOP_CONTINUE:
	INC l
	CMP l, 24
	JNE BRICKS_CHECK_LOOP

LOOP_EXIT1:

	MOV l, 0
BRICKS_CHECK_LOOP2:
	MOV ecx, 0
	MOV cl, l
	MOV al, toDraw[ecx]					
	CMP al, 0							; checking if the brick is present or not
	JE LOOP_CONTINUE2
	MOV al, yStart[ecx]
	CMP posY, al						; comparing y coordinate of ball and starting y coordinate of lth brick
	JL LOOP_CONTINUE2					; if y coordinate of ball is less then skip (because it is not hitting that brick)
	MOV al, yEnd[ecx]
	CMP posY, al						; comparing y coordinate of ball and ending y coordinate of lth brick
	JG LOOP_CONTINUE2					; if y coordinate of ball is greater then skip (because it is not hitting that brick)
	MOV al, xStart[ecx]					; checking if the ball is coming from left or right
	DEC al
	CMP posX, al
	JE BRICK_HIT2						; if the brick is coming from left	
	MOV al, xxEnd[ecx]
	INC al
	CMP posX, al
	JE BRICK_HIT2						; if the brick is coming from right
	JMP LOOP_CONTINUE2
BRICK_HIT2:
	PUSH eax
	PUSH ebx
	PUSH ecx
	PUSH edx
	invoke PlaySound, ADDR soundName, 0, SND_FILENAME
	POP edx
	POP ecx
	POP ebx
	POP eax
	MOV cornerCheck, 1
	CMP level, 3
	JNE NOT_LEVEL_3_1
	CMP ecx, 18							; fixed brick 1
	JE SCORE_NOT_COUNT1
	CMP ecx, 23							; fixed brick 2
	JE SCORE_NOT_COUNT1
NOT_LEVEL_3_1:
	MOV al, toDraw[ecx]
	DEC al								; decreasing the number of lives of brick
	MOV toDraw[ecx], al
	JNE SCORE_NOT_COUNT1
	CMP level, 3
	JNE RANDOM_BRICK_SKIP1
	CMP cl, randomBrick					; checking for the random brick
	JNE RANDOM_BRICK_SKIP1
	MOV randomIndex, 23
	MOV randomCount, 0
RANDOM_BRICK_LOOP1:
	MOV eax, 0
	MOV al, randomIndex					; index to traverse all bricks
	CMP toDraw[eax], 0					; if brick is visible then break it
	JE RANDOM_NOT_SKIP1
	CMP eax, 18							; skip fixed brick 1
	JE RANDOM_NOT_SKIP1
	CMP eax, 23							; skip fixed brick 2
	JE RANDOM_NOT_SKIP1
	MOV toDraw[eax], 0					; moving zero in todraw of the brick
	INC randomCount						; increasing the number of count of broken bricks
RANDOM_NOT_SKIP1:

	CMP randomCount, 5					; if 5 bricks are broken
	JE RANDOM_BRICK_SKIP1
	DEC randomIndex
	CMP randomIndex, -1					; if there are less than five bricks, then this check will work
	JG RANDOM_BRICK_LOOP1
RANDOM_BRICK_SKIP1:
	MOV eax, 0
	CMP level, 1
	JNE LEVEL2_SCORE_1
	MOV al, color3[ecx]					; for level 1, add score from color array
	JMP SCORE_SKIP2
LEVEL2_SCORE_1:
	CMP level, 2
	JNE LEVEL3_SCORE_1
	MOV al, color2[ecx]					; for level 2, add score from color2 array
	JMP SCORE_SKIP2
LEVEL3_SCORE_1:
	MOV al, color[ecx]					; for level 3, add score from color3 array
SCORE_SKIP2:
	ADD eax, score						; adding score of brick in total score
	MOV score, eax
SCORE_NOT_COUNT1:
	MOV al, directX
	XOR al, 1							; inverting the horizontal direction of the ball
	MOV directX, al
	CALL displayBricks
	CALL displayScore
LOOP_CONTINUE2:
	INC l
	CMP l, 24
	JNE BRICKS_CHECK_LOOP2

	CMP cornerCheck, 1		; if any brick is hit from upward or downward or from left or right, then it can not hit the corner
	JE CORNER_SKIP
	MOV l, 0
BRICKS_CHECK_LOOP3:
	MOV ecx, 0
	MOV cl, l
	MOV al, toDraw[ecx]					
	CMP al, 0							; checking if the brick is present or not
	JE LOOP_CONTINUE3
	CMP directX, 1
	JNE CORNER1_NOT_HIT
	CMP directY, 0
	JNE CORNER1_NOT_HIT
	MOV al, yStart[ecx]
	MOV ah, xStart[ecx]
	DEC al
	DEC ah
	CMP posY, al					; comparing y coordinate of ball and starting y coordinate of lth brick (top left corner)
	JNE CORNER1_NOT_HIT
	CMP posX, ah						; comparing x coordinate of ball and starting x coordinate of lth brick
	JE CORNER_HIT					; if y coordinate of ball is less then skip (because it is not hitting that brick)
CORNER1_NOT_HIT:
	CMP directX, 0
	JNE CORNER2_NOT_HIT
	CMP directY, 1
	JNE CORNER2_NOT_HIT
	MOV al, yEnd[ecx]
	MOV ah, xxEnd[ecx]
	INC al
	INC ah
	CMP posY, al					; comparing y coordinate of ball and ending y coordinate of lth brick (bottom right corner)
	JNE CORNER2_NOT_HIT
	CMP posX, ah						; comparing x coordinate of ball and ending x coordinate of lth brick
	JE CORNER_HIT
CORNER2_NOT_HIT:
	CMP directX, 1
	JNE CORNER3_NOT_HIT
	CMP directY, 1
	JNE CORNER3_NOT_HIT
	MOV al, yEnd[ecx]
	MOV ah, xStart[ecx]
	INC al
	DEC ah
	CMP posY, al					; comparing y coordinate of ball and ending y coordinate of lth brick (bottom left corner)
	JNE CORNER3_NOT_HIT
	CMP posX, ah						; comparing x coordinate of ball and starting x coordinate of lth brick
	JE CORNER_HIT
CORNER3_NOT_HIT:
	CMP directX, 0
	JNE LOOP_CONTINUE3
	CMP directY, 0
	JNE LOOP_CONTINUE3
	MOV al, yStart[ecx]
	MOV ah, xxEnd[ecx]
	DEC al
	INC ah
	CMP posY, al					; comparing y coordinate of ball and starting y coordinate of lth brick	(top right corner)
	JNE LOOP_CONTINUE3
	CMP posX, ah						; comparing x coordinate of ball and ending x coordinate of lth brick
	JE CORNER_HIT
	JMP LOOP_CONTINUE3
CORNER_HIT:
	PUSH eax
	PUSH ebx
	PUSH ecx
	PUSH edx
	invoke PlaySound, ADDR soundName, 0, SND_FILENAME
	POP edx
	POP ecx
	POP ebx
	POP eax
	CMP level, 3
	JNE NOT_LEVEL_3_2
	CMP ecx, 18							; fixed brick 1
	JE SCORE_NOT_COUNT2
	CMP ecx, 23							; fixed brick 2
	JE SCORE_NOT_COUNT2
NOT_LEVEL_3_2:
	MOV al, toDraw[ecx]
	DEC al								; decreasing the number of lives of brick
	MOV toDraw[ecx], al
	JNE SCORE_NOT_COUNT2
	CMP level, 3
	JNE RANDOM_BRICK_SKIP2
	CMP cl, randomBrick					; checking for the random brick
	JNE RANDOM_BRICK_SKIP2
	MOV randomIndex, 23
	MOV randomCount, 0
RANDOM_BRICK_LOOP2:
	MOV eax, 0
	MOV al, randomIndex					; index to traverse all bricks
	CMP toDraw[eax], 0					; if brick is visible then break it
	JE RANDOM_NOT_SKIP2
	CMP eax, 18							; skip fixed brick 1
	JE RANDOM_NOT_SKIP2
	CMP eax, 23							; skip fixed brick 2
	JE RANDOM_NOT_SKIP2
	MOV toDraw[eax], 0					; moving zero in todraw of the brick
	INC randomCount						; increasing the number of count of broken bricks
RANDOM_NOT_SKIP2:

	CMP randomCount, 5					; if 5 bricks are broken
	JE RANDOM_BRICK_SKIP2
	DEC randomIndex
	CMP randomIndex, -1					; if there are less than five bricks, then this check will work
	JG RANDOM_BRICK_LOOP2
RANDOM_BRICK_SKIP2:
	MOV eax, 0
	CMP level, 1
	JNE LEVEL2_SCORE_2
	MOV al, color3[ecx]					; for level 1, add score from color array
	JMP SCORE_SKIP3
LEVEL2_SCORE_2:
	CMP level, 2
	JNE LEVEL3_SCORE_2
	MOV al, color2[ecx]					; for level 2, add score from color2 array
	JMP SCORE_SKIP3
LEVEL3_SCORE_2:
	MOV al, color[ecx]					; for level 3, add score from color3 array
SCORE_SKIP3:
	ADD eax, score						; adding score of brick in total score
	MOV score, eax
SCORE_NOT_COUNT2:
	MOV al, directX
	XOR al, 1							; inverting the both directions of the ball
	MOV directX, al
	MOV al, directY
	XOR al, 1
	MOV directY, al
	CALL displayBricks
	CALL displayScore
LOOP_CONTINUE3:
	INC l
	CMP l, 24
	JNE BRICKS_CHECK_LOOP3

CORNER_SKIP:

	CMP posY, 1								; if ball hits the upper wall
	JNE ASSIGN_SKIP4	
	MOV directY, 0							; then change direction to down
ASSIGN_SKIP4:
	CMP posY, 28							; if the ball does not hit the bar
	JNE ASSIGN_SKIP5						
	MOV gamePlay, 0
	DEC lifeNum								; decreasing the lives if ball misses the paddle or bar
	MOV dh, posY
	MOV dl, posX
	CALL Gotoxy
	MWRITE ' '
	DEC posY
	CALL displayLives
	JMP DIRECTION_SKIP4
ASSIGN_SKIP5:		
	MOV dh, posY
	MOV dl, posX
	CALL Gotoxy
	MWRITE ' '
	CMP posX, 1							; if it hits the left wall
	JNE TEMP_SKIP1
	MOV directX, 1
TEMP_SKIP1:
	CMP posX, 72						; if the ball hits the right ball
	JNE TEMP_SKIP2
	MOV directX, 0						; then assign left x direction
TEMP_SKIP2:
	CMP directX, 0							; for moving left
	JNE DIRECTION_SKIP1						; skip to move right
	DEC posX								; move left
	JMP DIRECTION_SKIP2
DIRECTION_SKIP1:
	INC posX								; move right
DIRECTION_SKIP2:
	CMP directY, 0							; for moving down
	JNE DIRECTION_SKIP3						; skip to move up
	INC posY								; move down
	JMP DIRECTION_SKIP4
DIRECTION_SKIP3:
	DEC posY								; move up
DIRECTION_SKIP4:

	ret
controlBall ENDP

;----------------------------------------------------- DISPLAY BALL ----------------------------------------------------
; function to print the ball
displayBall PROC					; NOOR
	MOV dh, posY
	MOV dl, posX
	CALL Gotoxy
	MOVZX eax, ballCh
	CALL WriteChar
	ret
displayBall ENDP

; --------------------------------------------------- DISPLAY GAME OVER ----------------------------------------------------
displayGameOver PROC				; NOOR
	MOV dh, 20
	MOV dl, 32
	CALL Gotoxy
	MWRITE "Game Over"								; displaying game over 
	MOV dh, 21
	MOV dl, 29
	CALL Gotoxy
	MWRITE "Total Score: "							; displaying the total score of the player
	MOV eax, score
	CALL WriteDec
	MOV dh, 22
	MOV dl, 30
	CALL Gotoxy
	MWRITE "Time Left: "							; displaying the time left
	MOV eax, time
	MOV ebx, 1000
	MOV edx, 0
	DIV ebx
	CALL WriteDec

	MOV dh, 23
	MOV dl, 22
	CALL Gotoxy
	MWRITE "Press Any key to continue...."
	CALL ReadChar

	ret
displayGameOver ENDP

;----------------------------------------------------- DISPLAY TIME ----------------------------------------------------
displayTime PROC
	MOV eax, time
	MOV edx, 0
	MOV ebx, 1000
	DIV ebx
	MOV dh, 10
	MOV dl, 80
	CALL Gotoxy
	MWRITE "Time Remaining: "
	CALL WriteDec

	ret
displayTime ENDP

;----------------------------------------------------- GAME PAGE ----------------------------------------------------
; main function controlling the game page
gamePage PROC

	MOV posY, 27
	MOV dh, barY
	MOV dl, barX
	CALL Gotoxy
	MWRITE "              "						; clearing the bar location
	MOV barX, 31
	CMP level, 1
	JNE SKIP10
	MOV barX1, 38								; setting the middle of the bar for level 1
	JMP SKIP11
SKIP10:
	MOV barX1, 36								; setting the middle of the bar for level 2
SKIP11:

	MOV barY, 28
	CALL displayBar
	MOV directY, 1								; initializing the direction (i.e up and right)
	MOV directX, 1
	MOV gamePlay, 1
	MOV eax, 15
	CALL RandomRange
	ADD eax, 25
	MOV posX, al								; setting initial position of ball randomly
	
RANDOM_BRICK_ASSIGN_LOOP:
	MOV eax, 24
	CALL RandomRange
	CMP eax, 18									; checking if the random is fixed brick or not
	JE RANDOM_BRICK_ASSIGN_LOOP
	CMP eax, 23									; checking if the random is fixed brick or not
	JE RANDOM_BRICK_ASSIGN_LOOP
	MOV randomBrick, al

	CALL displayTime
	CALL displayBall
	CALL ReadChar
GAME_LOOP:
	;INVOKE PlaySound, OFFSET death, NULL, 1
	MOV ebx, 0
LEVEL_COMPLETE_LOOP_CHECK:
	CMP level, 3
	JNE NO_FIXED_BRICKS
	CMP ebx, 18									; checking if the brick is fixed, then this does not apply for it
	JE FIXED_BRICK_SKIP
	CMP ebx, 23									; checking for the fixed brick
	JNE NO_FIXED_BRICKS
	INC level									; level completed, so incrementing the level variable
	JMP EXITGAME
NO_FIXED_BRICKS:
	MOV al, toDraw[ebx]
	CMP al, 0									; checking if the brick is valid or not
	JNE LEVEL_NOT_COMPLETE						; if there is even a single brick then break the loop
FIXED_BRICK_SKIP:
	INC ebx
	CMP ebx, 24
	JL LEVEL_COMPLETE_LOOP_CHECK
	INC level									; level completed, so incrementing the level variable
	JMP EXITGAME
LEVEL_NOT_COMPLETE:
	CALL displayTime
	CALL controlBall
	CMP gamePlay, 0							; gamePlay variable sets to zero if the ball misses the bar, and then game resets
	JE EXITGAME
	CALL displayBall
	CMP level, 1
	JNE BALL_SPEED_SKIP1
	MOV eax, 75										; delay of 75 milliseconds for level 1
	MOV ebx, time
	SUB ebx, eax
	MOV time, ebx									;subtracting delay from the total time
	CMP time, 0
	JLE EXITGAME
	JMP BALL_SPEED_SKIP3
BALL_SPEED_SKIP1:
	CMP level, 2
	JNE BALL_SPEED_SKIP2
	MOV eax, 65										; delay of 65 milliseconds for level 2
	MOV ebx, time
	SUB ebx, eax									;subtracting delay from the total time
	MOV time, ebx
	CMP time, 0
	JLE EXITGAME
	JMP BALL_SPEED_SKIP3
BALL_SPEED_SKIP2:
	MOV eax, 50										; delay of 50 milliseconds for level 3		
	MOV ebx, time
	SUB ebx, eax									;subtracting delay from the total time
	MOV time, ebx
	CMP time, 0
	JLE EXITGAME
BALL_SPEED_SKIP3:
	CALL delay
	call ReadKey
    mov inputChar,al

	
    ; exit game if user types 'x':
    cmp inputChar,"x"
    je exitGame

    cmp inputChar,"b"
    je EXITGAME
	;
    cmp inputChar,"p"
	JNE PAUSE_SKIP
    CALL pauseGame
PAUSE_SKIP:

    CMP ah, 75         ; Left arrow (scan code 4Bh -> 75 in decimal)
	JNE SKIP_TO_RIGHT
		CMP barX, 1
		JG MOVE_LEFT

SKIP_TO_RIGHT:
	CMP ah, 77         ; Right arrow (scan code 4Dh -> 77 in decimal)
	JNE GAME_LOOP
		CMP level, 1				; checking for the level, if level is 1 so boundary check is for 60 because bar length is 12
		JNE SKIP_LEVEL1
		CMP barX, 59
		JL	MOVE_RIGHT
		JMP SKIP_LEVEL2
	SKIP_LEVEL1:					; if the level is 2 so boundary check is for 64 because bar length is 8
		CMP barX, 63
		JL	MOVE_RIGHT
	SKIP_LEVEL2:
		JMP GAME_LOOP
    

MOVE_LEFT:
	MOV dh, barY
	MOV dl, barX
	CALL Gotoxy
	CMP level, 1
	JNE LEFT_SKIP1
	MWRITE "              "		; clearing the previous lovation bar so we can print it on the new coordinates (level 1)
	JMP LEFT_SKIP2
LEFT_SKIP1:
	MWRITE "          "			; clearing the previous lovation bar so we can print it on the new coordinates (level 2)
LEFT_SKIP2:
    DEC	 barX					; moving left
	DEC barX
	DEC barX1
	DEC barX1
    call displayBar
    JMP	 GAME_LOOP

MOVE_RIGHT:
	MOV dh, barY
	MOV dl, barX
	CALL Gotoxy
	CMP level, 1
	JNE RIGHT_SKIP1
	MWRITE "            "		; clearing the previous lovation bar so we can print it on the new coordinates (level 1)
	JMP RIGHT_SKIP2
RIGHT_SKIP1:
	MWRITE "        "			; clearing the previous lovation bar so we can print it on the new coordinates (level 2)
RIGHT_SKIP2:
    INC  barX					; moving right
	INC barX
	INC barX1
	INC barX1
    call displayBar
	JMP  GAME_LOOP
	
EXITGAME:


	ret
gamePage ENDP


main PROC

	CALL readFileData
	CALL separateStrings
	CALL setLeaderBoard

MAIN_LOOP:
	CALL Clrscr
	CMP pages, 0
	JNE CONTROL_SKIP1
	CALL titlePage
	JMP MAIN_LOOP
CONTROL_SKIP1:
	CMP pages, 2
	JG CONTROL_SKIP2
	CALL menuPage
	JMP MAIN_LOOP
CONTROL_SKIP2:
	CMP pages, 3
	JNE CONTROL_SKIP3
	CALL Randomize
;-------------------------------------------------------- LEVEL 1 ----------------------------------------------------------
	MOV ecx, 0
TO_DRAW_LOOP1:
	MOV al, level
	MOV toDraw[ecx], al
	INC ecx
	CMP ecx, 24
	JNE TO_DRAW_LOOP1
	MOV score, 0
	MOV lifeNum, 3
	MOV time, 240000
	CALL displayName
	CALL displayLives
	CALL displayScore
	CALL displayBricks
	CALL displayBar
LEVEL1_LOOP:
	CMP level, 1
	JNE SKIP_TO_LEVEL2							; if current level is not level 1 then skip
	CMP al, 'x'
	JE GAME_OVER									; if x is pressed, then navigate back to main menu
	CMP lifeNum, 0
	JLE GAME_OVER									; if life num is zero, then game is over, navigate back to main menu
	CMP time, 0
	JLE GAME_OVER									; if time is zero, then game is over, then navigate back to main menu
	CALL gamePage
	JMP LEVEL1_LOOP
;------------------------------------------------------- LEVEL 2 ------------------------------------------------------------
SKIP_TO_LEVEL2:
	CALL Clrscr
	MOV ecx, 0
TO_DRAW_LOOP2:
	MOV al, level
	MOV toDraw[ecx], al
	INC ecx
	CMP ecx, 24
	JNE TO_DRAW_LOOP2
	MOV posY, 27
	CALL displayName
	CALL displayLives
	CALL displayScore
	CALL displayBricks
	CALL displayBar
LEVEL2_LOOP:
	CMP level, 2
	JNE SKIP_TO_LEVEL3								; if current level is not level 1 then skip
	CMP al, 'x'
	JE GAME_OVER									; if x is pressed, then navigate back to main menu
	CMP lifeNum, 0
	JLE GAME_OVER									; if life num is zero, then game is over, navigate back to main menu
	CMP time, 0
	JLE GAME_OVER									; if time is zero, then game is over, then navigate back to main menu
	CALL gamePage
	JMP LEVEL2_LOOP
;----------------------------------------------------- LEVEL 3 ------------------------------------------------------------
SKIP_TO_LEVEL3:
	CALL Clrscr
	MOV ecx, 0
TO_DRAW_LOOP3:
	MOV al, level
	MOV toDraw[ecx], al
	INC ecx
	CMP ecx, 24
	JNE TO_DRAW_LOOP3
	MOV posY, 27
	CALL displayName
	CALL displayLives
	CALL displayScore
	CALL displayBricks
	CALL displayBar
LEVEL3_LOOP:
	CMP level, 3
	JNE GAME_OVER							; if current level is not level 1 then skip
	CMP al, 'x'
	JE GAME_OVER									; if x is pressed, then navigate back to main menu
	CMP lifeNum, 0
	JLE GAME_OVER									; if life num is zero, then game is over, navigate back to main menu
	CMP time, 0
	JLE GAME_OVER									; if time is zero, then game is over, then navigate back to main menu
	CALL gamePage
	JMP LEVEL3_LOOP

GAME_OVER:
	CMP al, 'x'									; if pressed key is 'x' then dont show game over prompt
	JE SKIP_GAME_OVER
	CALL displayGameOver
	CALL setLeaderBoard

SKIP_GAME_OVER:
	MOV pages, 1								; navigate back to main menu
	JMP MAIN_LOOP
CONTROL_SKIP3:
	CMP pages, 4
	JNE CONTROL_SKIP4
	CALL displayLeaderBoard
	CALL readChar
	MOV pages, 1
	JMP MAIN_LOOP
CONTROL_SKIP4:
	CMP pages, 5
	JNE CONTROL_SKIP5
	CALL displayInstructions
	CALL readChar
	MOV pages, 1
	JMP MAIN_LOOP
CONTROL_SKIP5:
	CMP pages, 6
	JE EXIT_GAME
	JMP MAIN_LOOP

EXIT_GAME:
	CALL writeDataInFile


	INVOKE ExitProcess, 0
main ENDP
END main