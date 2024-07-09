
//////////////////////////////////////////////////////////////////
// FLASH THE BUTTONS, CHECK FOR BUTTON SELECTION
select_buttons:

	//jsr delay
	select_buttons_loop:

	// increment flash timer for buttons
	inc flash_timer
	bne !sbl+
	inc flash_timer2
	lda flash_timer2
	cmp flash_timer_speed
	bne !sbl+
	// check flash timer for flash increment
	lda #$00
	sta flash_timer
	sta flash_timer2
	inc flash_value_count
	lda flash_value_count
	and #$01
	tax
	lda flash_value_1,x
	sta USER_PORT_DATA

	!sbl:
	
	jsr delay

rts



0 rem *** c64-wiki sound-demo ***
10 s = 54272: w = 17: on int(rnd(ti)*4)+1 goto 12,13,14,15
12 w = 33: goto 15
13 w = 65: goto 15
14 w = 129
15 poke s+24,15: poke s+5,97: poke s+6,200: poke s+4,w
16 for x = 0 to 255 step (rnd(ti)*15)+1
17 poke s,x :poke s+1,255-x
18 for y = 0 to 33: next y,x
19 for x = 0 to 200: next: poke s+24,0
20 for x = 0 to 100: next: goto 10
21 rem *** abort only with run/stop ! ***


100 poke 54272+rnd(1) *25,rnd(1) *256 : goto 100

101pO54296,15:pO54272+rN(1)*7,rN(1)*256:?cH(98.5+rN(1));:gO101



	lda play_music
	beq !it+
	jmp $ea31
!it:
	inc $0401
	// lda irq_timer_sound
	// cmp #20
	// beq !it+
	lda sound_playing
	beq !it++
	inc 54273
	inc $0402
	// lda #$01
	// sta trig_sound
	// lda #$00
	// sta irq_timer_sound
	// sta sound_playing
	jmp $ea31
!it:
	lda sound_playing
	// cmp #0
	// bne !it+
	// inc 54272
	// adc #04
	// sta 54272
	// eor #255
	// 
	// sbc #10
	// sta 54273








  



  $0801-$082d BASIC Upstart
  $0830-$0a60 vars and lib init
  $1000-$1725 Music
  $34c0-$3d3e PRG
  $3000-$34bf SPRITES
  $4000-$6719 SCREENS