///////////////////////////////////////
// Kickassembler plugin for
// using Meatloaf HiScore API
// By Deadline / CityXen
// 2024

#import "MLHS_API_CONFIG.asm"

MLHS_API_USER_CONTACT:
.text "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
.byte 0
MLHS_API_USER_NAME:
.text "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
.byte 0
MLHS_API_USER_SCORE:
.byte 0,0,0,0

///////////////////////////////////////
// DATA AREA FOR TOP 10 SCORES
MLHS_API_TOP_10_TABLE:
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
//     012345678901234567890123456789012
//               1         2         3 
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "
.byte 0,0,0,0 // lo byte, hi byte score
.text "NOT YET COULD YOU BE HERE?       "

MLHS_API_URL_RETURN_CODE:
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

///////////////////////////////////////
// URL TABLES
MLHS_API_URL_ADD_SCORE: // text table used for meatloaf file name
.text "http://meatloaf.cc/api/hiscore/" // add real URL here
///////0123456789012345678901234567890
///////          1         2         3
// parameters
.text "?s="  // 36
MLHS_API_URL_AS_SCORE:
.text "SSSS" // 4 byte score // 40
.text "&c=" // 43
MLHS_API_URL_AS_CONTACT:
.text "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN" // 75
.text "&n=" // 78
MLHS_API_URL_AS_NAME:
.text "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN" // 110
//     012345678901234567890123456789012
.text "&x=" // 113
MLHS_API_URL_AS_TOKEN: // 16 byte security token (this is not the name of the game)
.text "XXXXXXXXXXXXXXXXX" // 129
.text "&end" // 4 byte end header // 134
.byte 0
MLHS_API_URL_ADD_SCORE_LENGTH:
.byte 134
///////////////////////////////////////
///////////////////////////////////////
MLHS_API_URL_GET_SCORE:  // get all scores unless n=NUM, then it will return NUM results
                // in our case we want 10
.text "http://meatloaf.cc/api/hiscore/" // add real URL here
.text "?n=" // 33
MLHS_API_URL_GS_NUM: // top 10 designation
.text "10" // 35
.text "&x=" // set game identifier // 38
MLHS_API_URL_GS_TOKEN: // 16 byte security token (this is not the name of the game)
.text "XXXXXXXXXXXXXXXXX" // 54
.text "&end" // 4 byte end header // 58
.byte 0
MLHS_API_URL_GET_SCORE_LENGTH:
.byte 58
///////////////////////////////////////
// END URL TABLES
///////////////////////////////////////

MLHS_API_URL_CLEAR: // clear user datas in url
    lda #$20
    ldx #$00
!:
    sta MLHS_API_URL_AS_NAME,x // fill name and contact with spaces
    sta MLHS_API_URL_AS_CONTACT,x // (add score url)
    inx
    cpx #33
    bne !-
    ldx #$00
!:
    lda MLHS_API_TOKEN,x
    sta MLHS_API_URL_AS_TOKEN,x
    sta MLHS_API_URL_GS_TOKEN,x
    inx
    cpx #17
    bne !-
    rts

MLHS_API_SET_SCORE:
    jsr MLHS_API_URL_CLEAR // reset url
    // fill in user name and contact in the url
    ldx #$00
!:
    lda MLHS_API_USER_NAME,x
    sta MLHS_API_URL_AS_NAME,x
    lda MLHS_API_USER_CONTACT,x
    sta MLHS_API_URL_AS_CONTACT,x
    inx
    cpx #33
    bne !-
    // fill in the score into the url
    lda #$00
    sta MLHS_API_URL_AS_SCORE
    lda #$00
    sta MLHS_API_URL_AS_SCORE+1
    lda MLHS_API_SCORE+2
    sta MLHS_API_URL_AS_SCORE+2
    lda MLHS_API_SCORE+3
    sta MLHS_API_URL_AS_SCORE+3
MLHS_API_LOAD_ADD: // Load routine for Meatloaf URLS
    lda #$0f
    ldx MLHS_API_DRIVE_NUMBER
    ldy #$ff
    jsr KERNAL_SETLFS
    lda #MLHS_API_URL_ADD_SCORE_LENGTH // url length
    ldx #<MLHS_API_URL_ADD_SCORE
    ldy #>MLHS_API_URL_ADD_SCORE
    jsr KERNAL_SETNAM
    ldx #01 // Set Load Address
    ldy #<MLHS_API_URL_RETURN_CODE
    lda #>MLHS_API_URL_RETURN_CODE
    jsr KERNAL_LOAD
    rts

MLHS_API_GET_SCORE:
    // reset url
    jsr MLHS_API_URL_CLEAR
MLHS_API_LOAD_GET: // Load routine for Meatloaf URLS
    lda #$0f
    ldx MLHS_API_DRIVE_NUMBER
    ldy #$ff
    jsr KERNAL_SETLFS
    lda #MLHS_API_URL_GET_SCORE_LENGTH // url length
    ldx #<MLHS_API_URL_GET_SCORE
    ldy #>MLHS_API_URL_GET_SCORE
    jsr KERNAL_SETNAM
    ldx #01 // Set Load Address
    ldy #<MLHS_API_TOP_10_TABLE
    lda #>MLHS_API_TOP_10_TABLE
    jsr KERNAL_LOAD
    rts

load_loading:
.encoding "screencode_mixed"
.text "loading "
.byte 0
