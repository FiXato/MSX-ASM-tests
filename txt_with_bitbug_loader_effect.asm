FORCLR:  EQU     $0f3e9  ; Foreground colour
BAKCLR:  EQU     $0f3ea  ; Background colour
BDRCLR:  EQU     $0f3eb  ; Border colour
CHGCLR:  EQU     $0062
JIFFY:   EQU     $FC9E
CHRTBL:  EQU     $0000   ; Pattern table
NAMTBL:  EQU     $1800   ; Name table
CLRTBL:  EQU     $2000   ; Colour table
SPRTBL:  EQU     $3800   ; Sprite pattern table
SPRATR:  EQU     $1b00   ; Sprite attributtes
INITXT:  EQU     $006c
INIT32:  EQU     $006f
INITGRP: EQU     $0072
INIMLT:  EQU     $0075
CHPUT:   EQU     $00A2
LDIRVM:  EQU     $005C


ORG $4000
FNAME "txt_with_bitbug_loader_effect.rom"
DW "AB",START,0,0,0,0,0,0

SETUP:
  LD HL,JIFFY
  RET

  call    INITXT
  LameText:
  DB 'UAEAEAEAEAEAE!',00
  AnotherText:
  DB 'DUMSKALLE!',00

BitBugEffect:
  LD A,R
  XOR [HL]
  LD [BDRCLR],A

  ld      B,A
  inc     B

  call CHGCLR
  RET

PRINTTEXT: ;gets text from HL
  LD A,(HL)
  call CHPUT
  inc HL
  ld a,0
  cp (HL)
  JR NZ, PRINTTEXT ;jump to next letter in buffer?
  RET

START:
  call SETUP
  LD HL,LameText
  call PRINTTEXT
  LD HL,AnotherText
  call PRINTTEXT
  loop:
    call BitBugEffect
    jp loop

DS $8000 - $, $FF ; Fill up rom.