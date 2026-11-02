INCLUDE Irvine32.inc

; Static_Grid.asm implements the game as a static,
; pre-made grid instead of a randomly generated one.
; This allows you to author every individual level
; and ensure the player never encounters an impossible
; level. However, may get boring faster.

.data
	rows = 8
	cols = 8

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

	mov esi, 0			; Row count

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
	exit

main ENDP
END main