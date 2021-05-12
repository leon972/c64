10 rem *** program worms ***
20 rem *** commodore 64 code by l.berti 2009 ***
22 rem costanti colori (chr$)
23 dim c$(15)
25 rem black
30 c$(0)=chr$(144)
35 rem white
40 c$(1)=chr$(5)
45 rem red
50 c$(2)=chr$(28)
55 rem cyan
60 c$(3)=chr$(159)
65 rem purple
70 c$(4)=chr$(156)
75 rem green
80 c$(5)=chr$(30)
85 rem blue
90 c$(6)=chr$(31)
95 rem yellow
100 c$(7)=chr$(158)
105 rem orange
110 c$(8)=chr$(129)
115 rem brown
120 c$(9)=chr$(149)
125 rem light red
130 c$(10)=chr$(150)
135 rem gray1
140 c$(11)=chr$(151)
145 rem gray2
150 c$(12)=chr$(152)
155 rem light green
160 c$(13)=chr$(153)
165 rem light blue
170 c$(14)=chr$(154)
172 rem gray
174 c$(15)=chr$(155)
175 rem indirizzi memoria per background e border
180 let bg=53281
185 let bd=53280
190 rem *** globals
191 rem *** function parameters
195 rem *** gen purpose coords
200 let x=0:let y=0
202 rem text or graphics color
205 let c=14:c1=6:c2=14
208 rem width and height
210 let w=0:let h=0
212 let t$="":let ll=0
215 rem utility functions
220 goto 1000
223 rem *** cls ***
225 rem clear screen
230 print chr$(147)
235 return
239 rem *** set colors ***
240 rem setta colore sfondo e bordo
241 rem c1=sfondo c2=bordo
250 poke 53280,c2:poke 53281,c1
255 return
258 rem *** print locate ***
260 rem stampa stringa alle coordinate
262 rem x=colonna y=riga t$=testo c=colore
270 ll=len(t$):aa=1024+y*40+x
272 ac=55296+y*40+x
275 for k=1 to ll
280 ch=asc(mid$(t$,k))
285 if(ch>=65 and ch<=90) then ch=ch-64
290 poke aa,ch:aa=aa+1
291 rem setta il colore
295 poke ac,c:ac=ac+1
310 next
320 return
325 rem *** print text center ***
330 rem stampa stringa centrata
332 rem t$=testo y=riga c=colore
335 ll=len(t$)
340 x=(40-ll)/2
345 gosub 260:return
347 rem *** hbar ***
350 rem barra orizzontale di caratteri
355 rem x=colonna y=riga ch=carattere ll=numero di caratteri c=colore
360 aa=1024+y*40+x
365 ac=55296+y*40+x
370 for k=1 to ll
375 poke aa,ch:poke ac,c
380 aa=aa+1:ac=ac+1
385 next
388 return
390 rem *** vbar ***
391 rem barra verticale,x=colonna y=riga ch=carattere ll=numero di caratteri c=colore
392 aa=1024+y*40+x:ac=55296+y*40+x
393 for k=1 to ll:poke aa,ch:poke ac,c:aa=aa+40:ac=ac+40:next
394 return
395 rem *** reset c64 default screen ***
400 c1=6:c2=14:print c$(14):gosub 239:gosub 223:return
410 rem *** wai key press ***
420 get t$:if t$="" goto 420
430 return
435 rem *** set text color ***
438 rem c=colore
440 print
450 rem *** output byte char ***
455 rem stampa una carattere
458 rem ch=codice poke carattere,c=colore x,y=coords
460 aa=1024+y*40+x:ac=55296+y*40+x
465 poke aa,ch:poke ac,c
470 return
1000 rem inizio programma
1002 rem indirizzi mem. elementi
1004 dim w1(120):lw=120
1010 rem posizioni comparsa cibo
1012 rem dim ps(20)
1015 rem game state e livello
1020 let gs%=1:let l1%=1
1025 rem vite
1028 let lv=3
1029 rem numero di oggetti da prendere
1032 let nf%=20:ff%=0
1033 rem carattere cibo
1034 let fo%=90
1035 rem posizione testa e lunghezza
1037 rem carattere worm
1038 let kw%=81
1040 let wx%=0:let wy%=0:let wl%=0
1042 rem direzione corrente
1043 ld=2
1045 rem indice elemento testa
1050 ih%=0
1052 rem velocita' (delay in 1/60 sec.)
1054 wv=20
1055 rem definizione tasti right left up e down
1060 tr$=chr$(29):tl$=chr$(157):tu$=chr$(145):td$=chr$(17)
1065 rem punteggio
1070 sc=0
1072 rem punti vincita prossima vita (1up ogni nl punti)
1074 nl=50
1075 rem last eat time
1080 le=0
1085 rem carattere muro default
1090 ww%=102
1200 goto 2000
1205 rem worms subs
1210 rem *** out debug text ***
1215 rem t$=testo debug
1220 x=30:y=3:c=11:gosub 270
1230 return
1240 rem *** display lives ***
1245 if lv<=0 then return
1248 x=12:y=1:t$=chr$(211)
1250 t$="     ":gosub 270:ch=83:l1=1:c=2
1260 for i=1 to lv
1265 gosub 460:x=x+1
1270 next
1275 return
1280 rem *** gen food ***
1285 rem genera il cibo alla pos. casuale
1287 r2%=rnd(0)*32+4:r3%=rnd(0)*18+3:a=1024+r2%+40*r3%
1290 pk=peek(a)
1295 rem if ff%>=nf% then ff%=0
1300 if pk<>32 then 1287
1305 c=9:poke a,fo%
1310 poke a+54272,c
1320 return
1330 rem *** elongate ***
1335 rem allunga il verme
1340 for i=wl% to ih%+2 step -1
1345 w1(i)=w1(i-1)
1350 next
1355 rem immette valore vecchia coda e allunga
1360 w1(ih%+1)=vc:wl%=wl%+1
1365 return
1370 rem *** sleep ***
1375 rem attende tw=numero di sessantesimi di secondo
1380 a=time
1385 if (time-a)<tw goto 1385
1390 return
1400 rem *** keyboard input ***
1402 rem restituisce in i$ il carattere acquisito
1410 get i$
1420 return
1430 rem *** empty keyboard ***
1440 get i$:if i$<>"" then 1440
1445 return
2000 rem input loop
2005 rem a=time
2010 gosub 1400
2015 rem if (time-a)<wv then 2010
2026 rem game loop
2100 on gs% gosub 2110,2700,2400
2105 goto 2000
2110 rem *** splash screen ***
2120 c1=5:c2=5:gosub 239:gosub 223
2125 ll=40:x=0:y=2:ch=70:c=7:gosub 360
2130 ll=40:x=0:y=4:ch=70:c=7:gosub 360
2135 t$="--- worms ---":c=1:y=3:gosub 335
2140 t$="use arrow keys to move":c=7:y=7:gosub 335
2143 print c9$+"level "+str$(l1%)
2145 t$="press any key to start":y=14:c=7:gosub 335
2150 ll=40:x=0:y=19:ch=70:c=7:gosub 360
2152 rem attende un tasto
2155 gosub 410
2157 rem carica il livello successivo
2160 gs%=2:gosub 2500:return
2400 rem *** game over ***
2410 c1=0:c2=0:gosub 239:gosub 223
2420 t$="- game over -":c=1:y=10:gosub 335
2430 gosub 410:gosub 400
2435 c1=0:c2=0:gosub 239:gosub 223
2440 print "new game (y/n) ";
2445 input t$
2450 if t$="y" then 1020
2455 gosub 400:end
2500 rem *** load level ***
2501 rem l1=livello
2503 rem vsi. vite
2505 bk$=chr$(166):c1=5:c2=5:gosub 239:gosub 223
2507 c=14:t$="level "+str$(l1%):x=3:y=1:gosub 270
2508 gosub 1430:gosub 1240:gosub 3460:gosub 3430
2509 rem visualizza il livello corrente
2510 on l1% gosub 2515,2585,2625,3560,3590,3670,3730,3830,3910
2511 gosub 3430
2513 return
2515 rem level 1
2520 nf%=40:ff%=0
2525 rem velocità (delay)
2530 wv=10
2532 rem colore muro del livello
2535 cw%=13
2545 gosub 2650
2575 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280
2580 return
2585 rem level 2
2588 nf%=50:ff%=0
2590 wv=8
2595 cw%=12
2600 gosub 2650
2602 x=9:y=6:ch=ww%:ll=8:c=cw%:gosub 347:x=24:gosub 347
2603 y=19:gosub 347:x=9:gosub 347
2610 x=9:y=6:ll=4:gosub 390:y=16:gosub 390
2615 x=31:y=6:gosub 390:y=16:gosub 390
2618 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280:gosub 1280
2620 return
2625 rem level 3
2630 nf%=50:ff%=0:wv=8:cw%=8:gosub 2650
2635 x=20:y=2:ll=21:ch=ww%:c=cw%:gosub 390:t$=" ":y=6:gosub 258:y=18:gosub 258
2638 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280:gosub 1280
2640 return
2650 rem *** draw empty game field ***
2651 print c$(cw%):t$=""
2652 for i=1 to 36:t$=t$+bk$:next
2655 print spc(2) t$
2670 for i=1 to 20:print spc(2) bk$ spc(34) bk$:next
2675 print spc(2) t$
2680 return
2700 rem *** game action ***
2705 if i$=tr$ then gosub 3270
2710 if i$=tl$ then gosub 3230
2715 if i$=tu$ then gosub 3310
2720 if i$=td$ then gosub 3350
2730 i$=""
2735 rem delay
2740 tw=wv:gosub 1370
2743 rem 1=left 2=right 3=up 4=down
2744 rem muove in base alla dir. corrente
2745 on ld gosub 2995,2965,3015,3035
2750 return
2820 rem *** reset worm pos ***
2825 c2%=wx%-wl%:c3=c2+wl%
2830 for i=c2 to c3:w1(i-c2)=1024+i+wy%*40:next
2831 rem indice testa
2832 ih%=wl%-1:wf%=1:i$="":ld=2:ld$=tr$:gosub 2840
2835 return
2840 rem *** draw worm ***
2845 rem wf% = 1 disegna 0 cancella
2850 rem wx%,wy% coord. testa ih%=indice testa
2855 rem wl% lunghezza
2858 if wf%=1 then ch=kw%
2860 if wf%=0 then ch=32
2880 for i=0 to wl%-1:poke w1(i),ch:poke w1(i)+54272,10:next
2890 return
2900 rem *** move ***
2905 rem in crementa il puntatore testa ih% e assenga il nuovo valore
2908 rem nh=nuovo valore testa
2910 ic=ih%+1
2915 if ic>=wl% then ic=0
2920 rem memorizza e cancella la coda
2930 poke w1(ic),32
2931 rem mem coda attuale
2932 vc=w1(ic)
2935 ih%=ih%+1
2940 if ih%>=wl% then ih%=0
2945 w1(ih%)=nh
2947 pk=peek(nh)
2948 rem controlla se urta il muro
2950 if pk=ww% then gosub 3100:goto 3155
2951 rem controlla urto con se stesso
2952 if pk=kw% then goto 3100
2953 poke w1(ih%),kw%:poke w1(ih%)+54272,10
2954 rem controlla se prende il cibo
2955 if pk=fo% then gosub 1330:gosub 1280:gosub 3390:gosub 3460
2958 return
2960 rem *** move right ****
2961 rem controlla se inverte la dir.
2965 nh=w1(ih%)+1:ld$=tr$
2980 gosub 2910
2990 return
2995 rem *** move left ***
3000 nh=w1(ih%)-1:ld$=tl$
3005 gosub 2910
3010 return
3015 rem *** move up ***
3020 nh=w1(ih%)-40:ld$=tu$
3030 gosub 2910
3032 return
3035 rem *** move down
3040 nh=w1(ih%)+40:ld$=td$
3045 gosub 2910
3050 return
3100 rem *** border hit ***
3110 rem impatto con il muro
3115 lv=lv-1:i$="":ld=2
3120 gosub 1240
3130 if lv=0 then 2400
3135 rem cancella il worm
3140 gosub 3180
3150 wl%=3:wx%=20:wy%=12:gosub 2820
3152 return
3155 rem **** riprstina elemento muro ***
3160 poke nh,ww%
3165 poke nh+54272,cw%
3170 return
3180 rem *** delete worm after hit ***
3185 rem cancella il verme a partire dalla coda dopo l'urto
3190 ic=ih%+1
3195 if ic>=wl% then ic=0
3200 i=ic
3205 poke w1(i),32:tw=10:gosub 1370
3208 if i=ih% then return
3210 i=i+1
3215 if i>=wl% then i=0
3220 goto 3205
3230 rem *** key left ***
3240 if ld=2 then return
3245 gosub 2995
3250 ld=1
3260 return
3270 rem *** key right ***
3280 if ld=1 then return
3290 ld=2
3295 gosub 2960
3300 return
3310 rem *** key up ***
3320 if ld=4 then return
3325 gosub 3015
3330 ld=3
3350 rem *** key down ***
3360 if ld=3 then return
3365 gosub 3035
3370 ld=4
3380 return
3385 rem *** eat ***
3390 ff%=ff%+1
3392 rem se il tempo dall'ultimo evento not piccolo da piu' punti
3395 if le<>0 and time-le<340 then sc=sc+5
3397 sc=sc+1:le=time
3400 rem vincita vita
3405 if sc>=nl then gosub 3540
3418 rem controlla se ha completato il livello
3420 if ff%>=nf% then 3500
3430 rem *** display food ***
3440 x=18:y=1:t$=str$(nf%-ff%)+"  ":c=1:gosub 258
3450 return
3460 rem *** display score ***
3470 x=23:y=1:t$="score "+str$(sc):c=1:gosub 258
3480 return
3500 rem *** goto next level ***
3510 wl%=3
3515 l1%=l1%+1
3519 rem carica il livello
3520 gosub 2500
3530 return
3540 rem *** vincita vita ***
3542 if lv<5 then lv=lv+1
3545 nl=nl+nl:gosub 1240:rem aggiorna vite
3550 return
3560 rem level 4
3565 nf%=50:ff%=0:wv=5:cw%=2:gosub 2650
3570 x=25:ll=8:ch=ww%:c=cw%:for k3=6 to 18:y=k3:gosub 347:next
3572 for i=1 to 8
3574 x=6+i*2:y=5:ll=1:gosub 347:y=19:gosub 347:y=7:gosub 347:y=17:gosub 347
3575 next
3578 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280:gosub 1280
3580 return
3590 rem level 5
3600 nf%=55:ff%=0:wv=0:cw%=1:gosub 2650
3610 x=18:y=2:ch=ww%:c=cw%:ll=12:gosub 390
3615 x=24:y=6:ll=17:gosub 390:x=30:y=2:gosub 390
3650 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280:gosub 1280:gosub 1280
3660 return
3670 rem level 6
3680 nf%=55:ff%=0:wv=0:cw%=3:gosub 2650
3690 x=3:y=3:ch=ww%:c=cw%
3700 for i=1 to 8:x=15+i*2:y=4:ll=18:gosub 390:next
3710 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280:gosub 1280:gosub 1280
3720 return
3730 rem level 7
3780 nf%=60:ff%=0:wv=0:cw%=6:gosub 2650
3790 x=3:y=3:ch=ww%:c=cw%:ll=2
3800 for i=1 to 8
3802 x=i+10:y=4+i:gosub 347:y=20-i:gosub 347
3803 x=33-i:y=4+i:gosub 347:y=20-i:gosub 347
3805 next
3810 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280:gosub 1280:gosub 1280:gosub 1280
3820 return
3830 rem level 8
3840 nf%=60:ff%=0:wv=0:cw%=7:gosub 2650
3845 ch=ww%:c=cw%
3850 for i=1 to 6
3860 x=i+10:ll=4:y=4+i:gosub 347
3862 y=15+i:gosub 347:x=i+24:y=4+i:gosub 347:y=15+i:gosub 347
3870 next
3875 ll=22:x=15:y=13:gosub 347
3890 wl%=3:wx%=20:wy%=12:gosub 2820:gosub 1280
3900 return
3910 rem *** game completed!***
3920 c1=6:c2=1:t$="game competed!":c=1:y=12:gosub 239:gosub 223:gosub 325
3930 y=14:t$="your score is: "+str$(sc):gosub 325
3940 c=3:y=16:t$="press any key":gosub 325:gosub 410:goto 2400




