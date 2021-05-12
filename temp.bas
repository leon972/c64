10 rem *** program worms ***
20 rem *** len64 code by l.berti 2009 ***
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
390 return
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
1004 dim w1(60):lw=60
1010 rem posizioni comparsa cibo
1012 dim ps(20)
1015 rem game state e livello
1020 let gs%=1:let l1%=1
1025 rem vite
1028 let lv=3
1029 rem numero di oggetti da prendere
1032 let ff=20
1033 rem carattere cibo
1034 let fo%=90
1035 rem posizione testa e lunghezza
1040 let wx%=0:let wy%=0:let wl%=0
1045 rem indice elemento testa
1050 ih%=0
1055 rem definizione tasti right left up e down
1060 tr$=chr$(29):tl$=chr$(157):tu$=chr$(145):td$=chr$(17)
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
2000 rem input loop
2010 get i$
2020 gosub 2100
2026 rem game loop
2100 on gs% gosub 2110,2800,2400
2105 return
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
2508 gosub 1240
2510 on l1% goto 2515
2515 rem level 1
2520 nf%=20:ff%=0
2530 for i=0 to nf%-1:ps(i)=rnd(0)*34+4+(rnd(0)*20+2)*40:next
2532 rem colore muro del livello
2535 cw%=13
2540 print c$(13):t$=""
2550 for i=1 to 36:t$=t$+bk$:next
2551 print spc(2) t$
2565 for i=1 to 20:print spc(2) bk$ spc(34) bk$:next
2570 print spc(2) t$
2575 wl%=3:wx%=20:wy%=10:gosub 2820
2800 rem *** game action ***
2805 if i$=tr$ then gosub 2965
2810 if i$=tl$ then gosub 2995
2815 if i$=tu$ then gosub 3015
2817 if i$=td$ then gosub 3035
2818 i$="":return
2820 rem *** reset worm pos ***
2825 c2%=wx%-wl%:c3=c2+wl%
2830 for i=c2 to c3:w1(i-c2)=1024+i+wy%*40:next
2831 rem indice testa
2832 ih%=wl%-1:wf%=1:gosub 2840
2835 return
2840 rem *** draw worm ***
2845 rem wf% = 1 disegna 0 cancella
2850 rem wx%,wy% coord. testa ih%=indice testa
2855 rem wl% lunghezza
2858 if wf%=1 then ch=81
2860 if wf%=0 then ch=32
2880 for i=0 to wl%-1:poke w1(i),ch:poke w1(i)+54272,10:next
2890 return
2900 rem *** move ***
2905 rem in crementa il puntatore testa ih% e assenga il nuovo valore
2908 rem nh=nuovo valore testa
2910 ic=ih%+1
2915 if ic>=wl% then ic=0
2920 rem memorizza e cancella la coda
2925 vc=w1(ic)
2930 poke w1(ic),32
2935 ih%=ih%+1
2940 if ih%>=wl% then ih%=0
2945 w1(ih%)=nh
2947 pk=peek(nh)
2948 rem controlla se urta il muro
2950 if pk=102 then goto 3100
2953 poke w1(ih%),81:poke w1(ih%)+54272,10
2954 rem controlla se prende il cibo
2958 return
2960 rem *** move right ****
2965 nh=w1(ih%)+1
2980 gosub 2910
2990 return
2995 rem *** move left ***
3000 nh=w1(ih%)-1
3005 gosub 2910
3010 return
3015 rem *** move up ***
3020 nh=w1(ih%)-40
3030 gosub 2910
3032 return
3035 rem *** move down
3040 nh=w1(ih%)+40
3045 gosub 2910
3050 return
3100 rem *** border hit ***
3110 rem impatto con il muro
3115 lv=lv-1
3120 gosub 1240
3130 if lv=0 then 2400
3135 rem cancella il worm
3140 wf%=0:gosub 2840
3150 gosub 2820
3152 rem riprstina elemento muro
3160 poke nh,102
3165 poke nh+54272,cw%
3170 return
ready.

