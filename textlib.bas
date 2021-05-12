10 rem *** text graphic lib ***
20 rem  *** color constants ***
21 rem *copiare direttamente
22 rem in VICE con copia-incolla
25 rem black
30 let c0$=chr$(144)
35 rem white
40 let c1$=chr$(5)
45 rem red
50 let c2$=chr$(28)
55 rem cyan
60 let c3$=chr$(159)
65 rem purple
70 let c4$=chr$(156)
75 rem green
80 let c5$=chr$(30)
85 rem blue
90 let c6$=chr$(31)
95 rem yellow
100 let c7$=chr$(158)
105 rem orange
110 let c8$=chr$(129)
115 rem brown
120 let c9$=chr$(149)
125 rem light red
130 let ca$=chr$(150)
135 rem gray1
140 let cb$=chr$(151)
145 rem gray2
150 let cc$=chr$(152)
155 rem light green
160 let cd$=chr$(153)
165 rem light blue
170 let ce$=chr$(154)
172 rem gray
174 let cf$=chr$(155)
175 rem indirizzi memoria per background e border
180 let bg=53281
185 let bd=53280
190 rem *** globals ***
191 rem *** function parameters ***
195 rem gen purpose coords
200 let x=0:let y=0
202 rem text or graphics color
205 let c=14:c1=6:c2=14
208 rem width and height
210 let w=0:let h=0
212 let t$="":let ll=0
215 rem *** utility functions ***
220 goto 1000
225 rem *** clear screen ***
230 print chr$(147)
235 return
240 rem *** setta colore sfondo e bordo ***
241 rem *** c1=sfondo c2=bordo
250 poke 53280,c2:poke 53281,c1
255 return
260 rem *** stampa stringa alle coordinate ***
262 rem x=colonna y=riga t$=testo c=colore
270 ll=len(t$):aa=1024+y*40+x
272 ac=55296+y*40+x
275 for i=1 to ll
280 ch=asc(mid$(t$,i))-64
285 if(ch>0) then 290
288 aa=aa+1:ac=ac+1
289 goto 310
290 poke aa,ch:aa=aa+1
291 rem setta il colore
295 poke ac,c:ac=ac+1
310 next
320 return
330 rem *** stampa stringa centrata ***
332 rem t$=testo y=riga c=colore
335 ll=len(t$)
340 x=(40-ll)/2
345 gosub 260:return
350 rem *** barra orizzontale di caratteri ***
355 rem x=colonna y=riga ch=carattere ll=numero di caratteri
360 aa=1024+y*40+x
365 ac=55296+y*40+x
370 for i=1 to ll
375 poke aa,ch:poke ac,c
380 aa=aa+1:ac=ac+1
385 next
390 return
1000 rem *** inizio programma ***
1010 ch=66:c=12:x=6:ll=20:y=8
1020 gosub 225:gosub 350


