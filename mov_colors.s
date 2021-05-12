;Assembler win2c64
;progrmma per Commodore 64
;scambia il colore del bordo con quello dello sfondo
;$D020 è l'indirizzo del colore del colore del bordo
;$D021 è l'indirizzo del colore di sfondo

;fa in modo che si possa eseguire il proramma digitando RUN
;inserisce la riga di BASIC SYS 2064
.org $0800 ; start at BASIC
.byte $00 $0c $08 $0a $00 $9e $20 $32 ; encode SYS 2064
.byte $30 $36 $34 $00 $00 $00 $00 $00 ; as BASIC line


;il C64 ha tre registri da 8 bit : A,X, e Y a=accumulatore
;indirizzo 2064=entry point
main   LDA  $D020     ;salva il colore del bordo nell'accumulatore
       LDX  $D021     ;salva il colore di sfondo in X
       STA  $D021     ;copia il valore di A nell'indirizzo che cambia lo sfondo
       STX  $D020     ;copia il alore di X nello sfondo
       JMP  main      ;loop infinito
       BRK            ;fine programma