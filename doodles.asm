
check_jitter_doodle:
	lda trig_jitter
	bne !cj+
	rts	
!cj:
	jsr reset_jitter_timer
	jsr game_setup_doodle
!cj:
	rts

game_setup_doodle:

	lda irq_timer_jitter_cmp
	clc
	sbc #$05
	sta irq_timer_jitter_cmp

	lda irq_timer_jitter_cmp
	cmp #40
	bcs !gsd+
	lda #40
	sta irq_timer_jitter_cmp
!gsd:

	jsr play_sound_ding

	// did_hit = 0 // timed out (figure out faction / if missed bad target = -1 life)
	// did_hit = 1 // hit target +1 score
	// did_hit = 2 // hit wrong target -1 score / -1 life
	// did_hit = 3 // hit wrong button -1 life

	lda did_hit
	bne !gsd+

	lda doodle
	clc
	cmp #$04
	bcc !gsd+

	jsr play_sound_miss
	lda #$02
	jsr set_message
	// life -1
	dec whack_life

!gsd:

	lda #$09
	sta button_actually_hit
!gsd:
	jsr lda_random
	and #%00000111
	cmp #$05
	bcs !gsd-
	sta button_to_hit

!gsd:
	jsr lda_random
	and #%00000111
	cmp #$07
	bcs !gsd-

	sta doodle

	cmp #$00
	bne !gsd+
	lda #sp_commodore
	sta SPRITE_0_POINTER
	jmp gsdso
!gsd:
	cmp #$01
	bne !gsd+
	lda #sp_yinyang
	sta SPRITE_0_POINTER
	jmp gsdso
!gsd:
	cmp #$02
	bne !gsd+
	lda #sp_heart
	sta SPRITE_0_POINTER
	jmp gsdso
!gsd:
	cmp #$03
	bne !gsd+
	lda #sp_star
	sta SPRITE_0_POINTER
	jmp gsdso
!gsd:
	cmp #$04
	bne !gsd+
	lda #sp_rad
	sta SPRITE_0_POINTER
	jmp gsdso
!gsd:
	cmp #$05
	bne !gsd+
	lda #sp_skull
	sta SPRITE_0_POINTER
	jmp gsdso
!gsd:
	cmp #$06
	bne !gsd+
	lda #sp_msdos
	sta SPRITE_0_POINTER
	jmp gsdso
!gsd:
	cmp #$07
	bne !gsd+
	lda #sp_dollar
	sta SPRITE_0_POINTER

gsdso:

	sta SPRITE_0_POINTER // SPRITE 0 being the doodle

	lda button_to_hit
	cmp #$00
	bne !gsd+
	lda #butt1_sprite_x
	sta SPRITE_0_X
	lda #butt1_sprite_y
	sta SPRITE_0_Y
	lda #butt1_sprite_m
	sta SPRITE_MSB_X
	lda #BUTTON_LIGHT_RED
	sta USER_PORT_DATA
	rts

!gsd:
	cmp #$01
	bne !gsd+
	lda #butt2_sprite_x
	sta SPRITE_0_X
	lda #butt2_sprite_y
	sta SPRITE_0_Y
	lda #butt2_sprite_m
	sta SPRITE_MSB_X
	lda #BUTTON_LIGHT_GREEN
	sta USER_PORT_DATA
	rts

!gsd:
	cmp #$02
	bne !gsd+
	lda #butt3_sprite_x
	sta SPRITE_0_X
	lda #butt3_sprite_y
	sta SPRITE_0_Y
	lda #butt3_sprite_m
	sta SPRITE_MSB_X
	lda #BUTTON_LIGHT_YELLOW
	sta USER_PORT_DATA
	rts

!gsd:
	cmp #$03
	bne !gsd+
	lda #butt4_sprite_x
	sta SPRITE_0_X
	lda #butt4_sprite_y
	sta SPRITE_0_Y
	lda #butt4_sprite_m
	sta SPRITE_MSB_X
	lda #BUTTON_LIGHT_BLUE
	sta USER_PORT_DATA
	rts

!gsd:
	cmp #$04
	bne !gsd+
	lda #butt5_sprite_x
	sta SPRITE_0_X
	lda #butt5_sprite_y
	sta SPRITE_0_Y
	lda #butt5_sprite_m
	sta SPRITE_MSB_X
	lda #BUTTON_LIGHT_WHITE
	sta USER_PORT_DATA
	rts

!gsd:

	rts