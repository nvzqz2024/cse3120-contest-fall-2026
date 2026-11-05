INCLUDE Irvine32.inc

; Static_Grid.asm implements the game as a static,
; pre-made grid instead of a randomly generated one.
; This allows you to author every individual level
; and ensure the player never encounters an impossible
; level. However, may get boring faster.

.data
	rows = 8
	cols = 8

    health DWORD 100               ; Player starts with 100 health
    gold DWORD 0                   ; Player starts with no gold
    healthMsg BYTE "Health: ",0     ; Null-terminated health label
    goldMsg BYTE "Gold: ",0         ; Null-terminated gold label

	base BYTE '#', '#', '#', '#', '#', '#', '#', '#'
	     BYTE '#', '.', '.', '.', '.', '.', 'E', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '.', '.', '.', '.', '.', '.', '#'
	     BYTE '#', 'P', '.', '.', '.', '.', '.', '#'
	     BYTE '#', '#', '#', '#', '#', '#', '#', '#'

	levelSafe BYTE '#', '#', '#', '#', '#', '#', '#', '#'
		      BYTE '#', '.', '.', '.', '.', '.', 'E', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', '.', '#', '#', '.', '#', '#', '#'
	          BYTE '#', 'P', '#', '#', 'G', 'G', '#', '#'
	          BYTE '#', '#', '#', '#', '#', '#', '#', '#'


.code
main PROC
    call DrawGrid                 ; Display dungeon and player stats
    exit                          ; End program after drawing
main ENDP

DrawGrid PROC
    mov esi, 0                    ; Start at row zero

LO:		; Loop Outer
	cmp esi, rows		; compare current row count in esi to rows
	jge done			; end
	mov edi, 0			; Column count

LI:		; Loop Inner
	cmp edi, cols		; compare current cols cound in edi to cols
	jge nextRow

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