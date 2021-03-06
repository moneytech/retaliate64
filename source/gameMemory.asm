;===============================================================================
;  gameMemory.asm - Game Memory Map
;
;  Copyright (C) 2017,2018 Marcelo Lv Cabral - <https://lvcabral.com>
;
;  Distributed under the MIT software license, see the accompanying
;  file LICENSE or https://opensource.org/licenses/MIT
;
;===============================================================================
; $00-$FF  PAGE ZERO (256 bytes)
 
                ; $00-$01   Reserved for IO
ZeroPageTemp    = $02
                ; $03-$8F   Reserved for BASIC
                ; using $73-$8A CHRGET as BASIC not used for our game
ZeroPageParam1  = $73
ZeroPageParam2  = $74
ZeroPageParam3  = $75
ZeroPageParam4  = $76
ZeroPageParam5  = $77
ZeroPageParam6  = $78
ZeroPageParam7  = $79
ZeroPageParam8  = $7A
ZeroPageParam9  = $7B
ZeroPageTemp1   = $80
ZeroPageTemp2   = $81
                ; $90-$FA   Reserved for Kernal
ZeroPageLow     = $FB
ZeroPageHigh    = $FC
ZeroPageLow2    = $FD
ZeroPageHigh2   = $FE
                ; $FF       Reserved for Kernal

;===============================================================================
; $0100-$01FF  STACK (256 bytes)


;===============================================================================
; $0200-$9FFF  RAM (40K)

; $0801
; Game code is placed here by using the *=$0801 directive on gameMain.asm

; Splash screen bitmap
* = $4000
        incbin "splash.kla",2

SCREENRAM       = $6800
SPRITE0         = $6BF8

; 176 decimal * 64(sprite size) = 11264 (hex $2C00)
; VIC II is looking at $4000 adding $2C00 we have $6C00
SPRITERAM       = 176
* = $6C00
        incbin "sprites.spt",1,35,true

; The character set ($D018) pointing to 14 decimal (%xxxx101x)
; So charmem is at $3800 adding bank start $4000 we have $7800
CHARSETPOS      = 14
* = $7800
        ; letters and numbers from the font "Teggst shower 5"
        ; http://kofler.dot.at/c64/download/teggst_shower_5.zip
        incbin "characters.cst",0,102

; Menu screens
* = $8000
MAPRAM
        ; Export List: 1-5(9),1-5(10),1-5(11),1-5(12),1-5(13),1-5(14),1-5(15),1-5(16),1-5(17),1-5(18),1-5(19),1-5(20),1-5(21),1-5(22),1-5(24)
        incbin "screens.bin"

;===============================================================================
; $A000-$BFFF  BASIC ROM (8K)

;===============================================================================
; $C000-$CFFF  RAM (4K)

; SID music
SIDINIT = $C000
SIDPLAY = $C006
SIDSONG = $00   ; Id of the song (inside the SID file)

* = $C000
SIDLOAD
        ; Music: Scout (c)1988 by Jeroen Tel
        ; http://csdb.dk/sid/?id=28205
        incbin "music.sid", $7E

;===============================================================================
; $D000-$DFFF  IO (4K)

; These are some of the C64 registers that are mapped into
; IO memory space
; Names taken from 'Mapping the Commodore 64' book

SP0X            = $D000
SP0Y            = $D001
MSIGX           = $D010
SCROLY          = $D011
RASTER          = $D012
SPENA           = $D015
SCROLX          = $D016
VMCSB           = $D018
SPBGPR          = $D01B
SPMC            = $D01C
SPSPCL          = $D01E
EXTCOL          = $D020
BGCOL0          = $D021
BGCOL1          = $D022
BGCOL2          = $D023
BGCOL3          = $D024
SPMC0           = $D025
SPMC1           = $D026
SP0COL          = $D027
FRELO1          = $D400 ;(54272)
FREHI1          = $D401 ;(54273)
PWLO1           = $D402 ;(54274)
PWHI1           = $D403 ;(54275)
VCREG1          = $D404 ;(54276)
ATDCY1          = $D405 ;(54277)
SUREL1          = $D406 ;(54278)
FRELO2          = $D407 ;(54279)
FREHI2          = $D408 ;(54280)
PWLO2           = $D409 ;(54281)
PWHI2           = $D40A ;(54282)
VCREG2          = $D40B ;(54283)
ATDCY2          = $D40C ;(54284)
SUREL2          = $D40D ;(54285)
FRELO3          = $D40E ;(54286)
FREHI3          = $D40F ;(54287)
PWLO3           = $D410 ;(54288)
PWHI3           = $D411 ;(54289)
VCREG3          = $D412 ;(54290)
ATDCY3          = $D413 ;(54291)
SUREL3          = $D414 ;(54292)
SIGVOL          = $D418 ;(54296)      
COLORRAM        = $D800
CIAPRA          = $DC00
CIAPRB          = $DC01

;===============================================================================
; $E000-$FFFF  KERNAL ROM (8K)

; Kernal Subroutines
SCNKEY          = $FF9F
GETIN           = $FFE4
CLOSE           = $FFC3
OPEN            = $FFC0
SETNAM          = $FFBD
SETLFS          = $FFBA
CLRCHN          = $FFCC
CHROUT          = $FFD2
LOAD            = $FFD5
SAVE            = $FFD8

;===============================================================================
