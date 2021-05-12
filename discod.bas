10 rem *** visualizza tabella caratteri ***
20 print chr$(147)
30 poke 53280,14:poke 53281,6:print chr$(5)
35 ch=0
40 for i=0 to 25
50 for j=0 to 9
60 poke 1024+2+j*2+40*i,ch
70 ch=ch+1:if ch>255 then end
80 next j
90 next i
