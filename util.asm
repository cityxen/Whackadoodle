
//////////////////////////////////////////////////////////////////
// Make buttons blink randomly

randomly_flash_buttons:
	jsr lda_random_kern
	sta random_num
	sta USER_PORT_DATA
	rts

get_button:
	lda trig_joystick
	beq !gb+
	lda JOYSTICK_PORT_1
	rts
!gb:
	lda #$ff
	rts

get_key:
	lda trig_input
	beq !gb+
	jsr KERNAL_GETIN
	sta whack_key
	jsr reset_input_timer
	lda whack_key
	rts
!gb:
	lda #$00
	rts

increment_score:
	inc whack_score_lo
	bne !is+
	inc whack_score_hi
!is:
	jmp update_score

decrement_score:
	lda whack_score_lo
	cmp #$00
	beq !is+
	dec whack_score_lo
	jmp !is++
!is:
	lda whack_score_hi
	cmp #$00
	beq !is+
	dec whack_score_hi
	dec whack_score_lo
!is:

update_score:
	jsr reset_whacks
	ldy whack_score_hi
	ldx whack_score_lo

	cpx #$00
	bne !us++
!us:
	cpy #$00
	bne !us+
	jsr reset_whacks
	jmp !us++

!us:
	dex
	jsr update_score_to_dec
	cpx #$00
	bne !us-
	
	cpy #$00
	beq !us+
	dey
	jmp !us-
!us:
	rts

update_score_to_dec:

	inc whack_score_1
	lda whack_score_1
	cmp #$3a
	bne isout
	lda #$30
	sta whack_score_1

	inc whack_score_2
	lda whack_score_2
	cmp #$3a
	bne isout
	lda #$30
	sta whack_score_2

	inc whack_score_3
	lda whack_score_3
	cmp #$3a
	bne isout
	lda #$30
	sta whack_score_3

	inc whack_score_4
	lda whack_score_4
	cmp #$3a
	bne isout
	lda #$30
	sta whack_score_4

	inc whack_score_5
	lda whack_score_5
	cmp #$3a
	bne isout
	lda #$30
	sta whack_score_5

	inc whack_score_6
	lda whack_score_6
	cmp #$3a
	bne isout
	lda #$30
	sta whack_score_6


isout:
	rts



draw_score_game_on:

	lda whack_score_1
	sta $0440+44+5
	lda whack_score_2
	sta $0440+44+4
	lda whack_score_3
	sta $0440+44+3
	lda whack_score_4
	sta $0440+44+2
	lda whack_score_5
	sta $0440+44+1
	lda whack_score_6
	sta $0440+44

	rts

draw_score_game_over:


	lda whack_score_1
	sta $0500+84+44+5
	lda whack_score_2
	sta $0500+84+44+4
	lda whack_score_3
	sta $0500+84+44+3
	lda whack_score_4
	sta $0500+84+44+2
	lda whack_score_5
	sta $0500+84+44+1
	lda whack_score_6
	sta $0500+84+44

	rts	

reset_whacks:
	lda #$30
	sta whack_score_1
	sta whack_score_2
	sta whack_score_3
	sta whack_score_4
	sta whack_score_5
	sta whack_score_6
	rts

reset_score:
	lda #$00
	sta whack_score_lo
	sta whack_score_hi
	jsr reset_whacks
	rts