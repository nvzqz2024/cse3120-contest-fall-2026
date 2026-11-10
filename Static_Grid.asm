INCLUDE Irvine32.inc

; Static_Grid.asm implements the game as a static,
; pre-made grid instead of a randomly generated one.
; This allows you to author every individual level
; and ensure the player never encounters an impossible
; level. However, may get boring faster.

.data
	rows = 8
	cols = 8

	playerX DWORD 1
	playerY DWORD 6

    health DWORD 100               ; Player starts with 100 health
    gold DWORD 0                   ; Player starts with no gold
    healthMsg BYTE "Health: ",0     ; Null-terminated health label
    goldMsg BYTE "Gold: ",0         ; Null-terminated gold label

    controlsMsg BYTE "WASD to move. Q to quit.",0
    winMsg BYTE "You escaped the tomb! Final gold: ",0

	base BYTE '#', '#', '#', '#', '#', '#', '#', '#'
	     BYTE '#', '.', '.', '.', '.', '.', 'E', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '#', '#', '#', '#', '#', '#', '#'

	levelSafe BYTE '#', '#', '#', '#', '#', '#', '#', '#'
		      BYTE '#', '.', '.', '.', '.', '.', 'E', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', '.', '#', '#', 'G', 'G', '#', '#'
	          BYTE '#', '#', '#', '#', '#', '#', '#', '#'


.code
main PROC
gameLoop:
    call Clrscr                   ; Clear the previous screen
    call DrawGrid                 ; Display dungeon and stats
    mov edx, OFFSET controlsMsg    ; Load instructions
    call WriteString              ; Display instructions
    call ReadChar                 ; Wait for a key; character goes in AL
    cmp al, 'q'                   ; Check lowercase quit command
    je quitGame
    cmp al, 'Q'                   ; Check uppercase quit command
    je quitGame
     ; Handle the movement key and update the player's position if the move is valid.
    call MovePlayer

    ; Convert the player's row and column into a map index: row * cols + column.
    mov eax, playerY
    imul eax, cols
    add eax, playerX
    ; Check whether the tile under the player is the exit.
    cmp levelSafe[eax], 'E'
    je winGame
    jmp gameLoop

winGame:
    call Clrscr
    call DrawGrid
    mov edx, OFFSET winMsg
    call WriteString
    mov eax, gold
    call WriteDec
    call Crlf
    call WaitMsg

quitGame:
    exit                          ; End the game
main ENDP

MovePlayer PROC
    ; Start with the player's current coordinates.
    mov ecx, playerX
    mov edx, playerY

    or al, 20h                     ; Convert uppercase letters to lowercase
    cmp al, 'w'
    je moveUp
    cmp al, 'a'
    je moveLeft
    cmp al, 's'
    je moveDown
    cmp al, 'd'
    je moveRight
    ret                            ; Ignore other keys

moveUp:
    dec edx
    jmp checkTile

moveLeft:
    dec ecx
    jmp checkTile

moveDown:
    inc edx
    jmp checkTile

moveRight:
    inc ecx

checkTile:
    ; Unsigned checks also reject coordinates that wrapped below zero.
    cmp ecx, cols
    jae moveDone
    cmp edx, rows
    jae moveDone

    mov eax, edx
    imul eax, cols
    add eax, ecx                   ; EAX = target row * cols + target column

    cmp levelSafe[eax], '#'
    je moveDone

    mov playerX, ecx
    mov playerY, edx
    cmp levelSafe[eax], 'G'
    jne moveDone

    inc gold
    mov levelSafe[eax], '.'        ; Remove collected gold from the map

moveDone:
    ret
MovePlayer ENDP

DrawGrid PROC
    mov esi, 0                    ; Start at row zero

LO:		; Loop Outer
	cmp esi, rows		; compare current row count in esi to rows
	jge done			; end
	mov edi, 0			; Column count

LI:		; Loop Inner
	cmp edi, cols		; compare current cols count in edi to cols
	jge nextRow

	; placing character
	cmp edi, playerX	; does x match the playerX?
	jne printContinue	; if no, continue normally

	cmp esi, playerY	; does y match the playerY?
	jne printContinue	; if no, continue normally

	; print the player, since it didn't jump
	mov al, 'P'
	call WriteChar
	inc edi
	jmp LI

	printContinue:

	; index = (current row) * cols + (current column)

	mov eax, esi		; place row count into esi
	imul eax, cols		; row * cols
	add eax, edi		; result + column

	; Put current character into al and print
	mov al, levelSafe[eax]
	call WriteChar

	inc edi
	jmp LI

nextRow:
	call Crlf			; Newline \
	inc esi
	jmp LO

done:
    mov edx, OFFSET healthMsg      ; Load address of health label
    call WriteString              ; Display "Health: "
    mov eax, health                ; Load current health
    call WriteDec                 ; Display health as an unsigned decimal
    call Crlf                     ; Move to the next line

    mov edx, OFFSET goldMsg        ; Load address of gold label
    call WriteString              ; Display "Gold: "
    mov eax, gold                  ; Load current gold
    call WriteDec                 ; Display gold as an unsigned decimal
    call Crlf                     ; Move to the next line
    ret					; Return to the caller

DrawGrid ENDP
END main
