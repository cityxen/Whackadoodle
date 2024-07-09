
//////////////////////////////////////////////////////////////////
// SOUND STUFF

init_sound:
	ldx #$00
	lda #$00
!is:
	sta 54272,x
	inx
	cpx #25
	bne !is-
	rts

play_init:
	rts
	lda #$00
	sta trig_sound
	sta irq_timer_sound
	lda #15
	sta 54296 // volume
	lda #15+127
	sta 54277 // attack / decay
	lda #241
	sta 54278 // sustain / release
	lda #$01	
	sta sound_playing
	rts

play_sound_ding:
	rts
	// 33, 22
	lda #33
	sta 54276 // waveform
	lda #1
	sta 54272
	lda #177
	sta 54273
	jsr play_init
	rts	
play_sound_get_ready:	
	rts
	lda #33
	sta 54276 // waveform
	lda #1
	sta 54272
	lda #185
	sta 54273
	jsr play_init
	rts
play_sound_wrong:
	rts
	lda #17
	sta 54276 // waveform
	lda #1
	sta 54272
	lda #15
	sta 54273
	jsr play_init
	rts
play_sound_pow:
	rts
	lda #33
	sta 54276 // waveform
	lda #2
	sta 54272
	lda #85
	sta 54273
	jsr play_init
	rts
play_sound_miss:
	rts
	lda #129 
	sta 54276 // waveform
	lda #1
	sta 54272
	lda #5
	sta 54273
	jsr play_init
	rts
play_sound_timedout:
	rts
	lda #33
	sta 54276 // waveform
	lda #0
	sta 54272
	lda #255
	sta 54273
	jsr play_init
	rts
play_sound_gameover:
	rts
	lda #33
	sta 54276 // waveform
	lda #0
	sta 54272
	lda #255
	sta 54273
	jsr play_init
	rts
