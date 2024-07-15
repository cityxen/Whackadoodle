///////////////////////////////////////
// Kickassembler plugin for
// using Meatloaf HiScore API
// By Deadline / CityXen
// 2024
// CONFIG FILE
// You will want to add your
// security token here from your
// Meatloaf HiScore API
// Information Panel

MLHS_API_TOKEN: // 16 byte token from meatloaf.cc
.text "123456789012345"
.byte 0

MLHS_API_SCORE: // 4 Bytes
.byte 0
.byte 0
.byte whack_score_lo
.byte whack_score_hi

MLHS_API_DRIVE_NUMBER:
.byte 9
