;Program FLASH  per Commodore 64
;flash video border
;assembler win2c64
;Code by Leonardo Berti  2009

;fa in modo che si possa eseguire il proramma digitando RUN
;inserisce la riga di BASIC SYS 2064
.org $0800 ; start at BASIC
.byte $00 $0c $08 $0a $00 $9e $20 $32 ; encode SYS 2064
.byte $30 $36 $34 $00 $00 $00 $00 $00 ; as BASIC line

;indirizzo 2064
main   INC $D020
       JMP main
       RTS

