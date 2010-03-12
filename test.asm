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
; INIT32:  EQU     $006F   ; screen 1
INITXT: EQU     $006c
INIT32:  EQU     $006f
INITGRP: EQU     $0072
INIMLT:  EQU     $0075
CHPUT:   EQU     $00A2
LDIRVM:  EQU     $005C


ORG $4000
FNAME "test.rom"
DW "AB",START,0,0,0,0,0,0

SETUP:
;   ld      hl,BDRCLR
;   inc     [hl]
  LD HL,JIFFY
  RET

  ; SCREEN 1
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
;   ld      hl,BAKCLR
;   ld      [hl],b
;   ld      hl,BAKCLR
;   inc     [hl]

  call CHGCLR
;  jp LDR
  RET


TXTER:
  LD HL,LameText
  loop:
  LD A,(HL)
  call CHPUT
  inc HL
  ld a,0
  cp (HL)
  JR NZ, loop	
  fim:
 ; jp fim

BLAAT:
;  LD A,R
;  XOR [HL]
;  LD [BDRCLR],A
;  ld      B,A
;  inc     B
;  call CHGCLR
  LD HL,LameText
  loopa:
  LD A,(HL)
  call CHPUT
  inc HL
  ld a,0
  cp (HL)
;  JR NZ, loopa
;  jp BLAAT
  

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
  loopb:
    call BitBugEffect
    jp loopb

  
  DS $8000 - $, $FF