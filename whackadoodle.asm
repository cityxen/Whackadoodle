//////////////////////////////////////////////////////////////////////////////////////
// WHACKADOODLE for C64 by Deadline / CityXen 2024
//////////////////////////////////////////////////////////////////////////////////////

#import "../Commodore64_Programming/include/Constants.asm"
#import "../Commodore64_Programming/include/Macros.asm"
#import "../Commodore64_Programming/include/DrawPetMateScreen.asm"
#import "wad_constants.asm"

.var music = LoadSid("whackadoodle.sid")		//<- Here we load the sid file

.segment Music [allowOverlap]
*=music.location "Music"
.fill music.size, music.getData(i) // <- Here we put the music in memory

.segment Sprites [allowOverlap]
*=$3000 "SPRITES"
#import "sprites/was-sprites - Sprites.asm"

.segment Screens [allowOverlap]
*=$4000 "SCREENS"
#import "petmate/screen.asm"
#import "petmate/qr_code.asm"

.file [name="wad-cxn.prg", segments="Main,Sprites,Screens,Music"]

CityXenUpstart()
#import "config.asm"
* = $34c0 "PRG"

start:
#import "start.asm"
#import "main_loop.asm"
#import "game_loop.asm"
#import "game_over_loop.asm"
#import "doodles.asm"
#import "messages.asm"
#import "draw_screens.asm"
#import "init_sprites.asm"
#import "debug.asm"
#import "sound.asm"
#import "timers.asm"
#import "util.asm"
