program snake_con_mele;

uses crt;

var
snake: array [1..24,1..80] of integer;
lettera: char;
i,j,k,l,m,n,vite,pt:integer;
lunghezza:integer;
mangiato,sbattuto:boolean;
riga_testa,col_testa,riga_coda,col_coda,riga_mela,col_mela:integer;

procedure istruzioni;
begin
     cursoroff;
     writeln;
     textcolor(green);
     write('                                     S');
     textcolor(lightcyan);
     write('n');
     textcolor(green);
     write('a');
     textcolor(lightcyan);
     write('k');
     textcolor(green);
     write('e');
     textcolor(white);
     write('                        page 1 of 2');
     textcolor(white);
     writeln;
     writeln;
     writeln;
     writeln(' In this game you''ll have to move a snake around the screen.');
     writeln;
     writeln(' Directions: up(',chr(24),'), left(',chr(27),'), down(',chr(25),'), right(',chr(26),').');
     writeln;
     writeln('         ',chr(218),'---|--------',chr(217),'        |        |');
     writeln('         |   _                 |        |');
     writeln('         |  |w|                |        |');
     writeln('         _   _   _             |        |');
     writeln('        |a| |s| |d| -----------|--------',chr(217));
     writeln('                               |                         ');
     writeln('             ',chr(192),'-----------------',chr(217));
     writeln;
     writeln(' Watch out! The snake will get longer and faster every movement!');
     writeln;
     writeln(' You mustn''t crash into the walls or into yourself.');
     writeln;
     writeln;
     writeln;
     writeln;
     writeln('                           press ENTER to continue');
     readln;
     clrscr;
     writeln;
     write('                                                                  page 2 of 2');
     writeln;
     writeln;
     writeln;
     writeln;
     writeln(' Try to pick up as many apples as you can before you get too long');
     writeln;
     writeln;
     writeln;
     writeln(' You''ll recieve 50 extra points for every apple you eat');
     writeln;
     writeln;
     writeln;
     writeln(' But you better be fast eating your apples to get a good score');
     writeln;
     writeln;
     writeln;
     writeln;
     writeln(' Oh, one last thing! You''ll have other two extra lives to better your score!!!');
     writeln;
     writeln;
     writeln(' good luck!');
     writeln;
     writeln('                           press ENTER to begin');
end;

procedure inizio;
begin
     for i:=1 to 24 do
         for j:=1 to 80 do
             snake[i,j]:=0;
         snake[12,41]:=1;
         snake[12,40]:=2;
         snake[12,39]:=3;
         randomize;
         repeat
               riga_mela:=random(25);
               col_mela:=random(79);
         until (riga_mela mod 2=0)and(col_mela mod 2=1)and(snake[riga_mela,col_mela]=0)and(riga_mela>1);
         snake[riga_mela,col_mela]:=4;
         lunghezza:=3;
         riga_testa:=12;
         col_testa:=41;
         riga_coda:=12;
         col_coda:=39;
end;

procedure assegnazione;
begin
     for i:=1 to 24 do
         for j:=1 to 80 do
             begin
                  if snake[i,j]=1
                  then
                      begin
                           gotoxy(j,i);
                           textcolor(green);
                           write(chr(219));
                      end
                  else
                      begin
                           if snake[i,j]=2
                           then
                               begin
                                    gotoxy(j,i);
                                    textcolor(green);
                                    write(chr(178));
                               end
                           else
                               begin
                                    if snake[i,j]=3
                                    then
                                        begin
                                             gotoxy(j,i);
                                             textcolor(green);
                                             write(chr(176));
                                        end
                                    else
                                        begin
                                             if snake[i,j]=4
                                             then
                                                 begin
                                                      gotoxy(j,i);
                                                      randomize;
                                                      textcolor(random(10));
                                                      write(chr(162));
                                                 end;
                                        end;
                               end;
                      end;
             end;
end;

procedure coda;
begin
  for i:=1 to 1(*n*) do
    begin
     if snake[riga_coda+1,col_coda]=2
     then
         begin
              snake[riga_coda,col_coda]:=0;
              gotoxy(col_coda,riga_coda);
              write(' ');
              riga_coda:=riga_coda+1;
              snake[riga_coda,col_coda]:=3;
         end;
     if snake[riga_coda-1,col_coda]=2
     then
         begin
              snake[riga_coda,col_coda]:=0;
              gotoxy(col_coda,riga_coda);
              write(' ');
              riga_coda:=riga_coda-1;
              snake[riga_coda,col_coda]:=3;
         end;
     if snake[riga_coda,col_coda+1]=2
     then
         begin
              snake[riga_coda,col_coda]:=0;
              gotoxy(col_coda,riga_coda);
              write(' ');
              col_coda:=col_coda+1;
              snake[riga_coda,col_coda]:=3;
         end;
     if snake[riga_coda,col_coda-1]=2
     then
         begin
              snake[riga_coda,col_coda]:=0;
              gotoxy(col_coda,riga_coda);
              write(' ');
              col_coda:=col_coda-1;
              snake[riga_coda,col_coda]:=3;
         end;
    end;
end;

procedure mela;
begin
     m:=m+50;
     snake[riga_mela,col_mela]:=0;
     randomize;
     repeat
           riga_mela:=random(25);
           col_mela:=random(79);
     until (riga_mela mod 2=0)and(col_mela mod 2=1)and(snake[riga_mela,col_mela]=0)and(riga_mela>1);
     snake[riga_mela,col_mela]:=4;
end;

procedure aggiorna;
begin
     if lettera='d'  (*d x dx*)
     then
         begin
              if (col_testa>78)
              then
                  sbattuto:=true
              else
              begin
                   if (snake[riga_testa,col_testa+1]=4)or(snake[riga_testa,col_testa+2]=4)
                   then
                       begin
                            n:=1;
                            mela;
                       end;
                   if (snake[riga_testa,col_testa+1]=0)and(snake[riga_testa,col_testa+2]=0)
                   then
                       begin
                            snake[riga_testa,col_testa]:=2;
                            snake[riga_testa,col_testa+1]:=2;
                            col_testa:=col_testa+2;
                            snake[riga_testa,col_testa]:=1;
                            k:=k+1;
                            l:=k;
                            m:=m+1;
                            lunghezza:=lunghezza+1;
                            n:=2;
                            coda;
                       end
                   else
                        mangiato:=true
              end;
         end;
     if lettera='a'  (*a x sx*)
     then
         begin
              if (col_testa<2)
              then
                  sbattuto:=true
              else
              begin
                   if (snake[riga_testa,col_testa-1]=4)or(snake[riga_testa,col_testa-2]=4)
                   then
                       begin
                            n:=1;
                            mela;
                       end;
                   if (snake[riga_testa,col_testa-1]=0)and(snake[riga_testa,col_testa-2]=0)
                   then
                       begin
                            snake[riga_testa,col_testa]:=2;
                            snake[riga_testa,col_testa-1]:=2;
                            col_testa:=col_testa-2;
                            snake[riga_testa,col_testa]:=1;
                            k:=k+1;
                            l:=k;
                            m:=m+1;
                            lunghezza:=lunghezza+1;
                            n:=2;
                            coda;
                       end
                   else
                        mangiato:=true
              end;
         end;
     if lettera='s'  (*s x giù*)
     then
         begin
              if (riga_testa>23)
              then
                  sbattuto:=true
              else
              begin
                   if (snake[riga_testa+1,col_testa]=4)or(snake[riga_testa+2,col_testa]=4)
                   then
                       begin
                            n:=1;
                            mela;
                       end;
                   if (snake[riga_testa+1,col_testa]=0)and(snake[riga_testa+2,col_testa]=0)
                   then
                       begin
                            snake[riga_testa,col_testa]:=2;
                            snake[riga_testa+1,col_testa]:=2;
                            riga_testa:=riga_testa+2;
                            snake[riga_testa,col_testa]:=1;
                            k:=k+1;
                            l:=k;
                            m:=m+1;
                            lunghezza:=lunghezza+1;
                            n:=2;
                            coda;
                       end
                   else
                       mangiato:=true
              end;
         end;
     if lettera='w'  (*w x su*)
     then
         begin
              if (riga_testa<2)
              then
                  sbattuto:=true
              else
              begin
                   if (snake[riga_testa-1,col_testa]=4)or(snake[riga_testa-2,col_testa]=4)
                   then
                       begin
                            n:=1;
                            mela;
                       end;
                   if (snake[riga_testa-1,col_testa]=0)and(snake[riga_testa-2,col_testa]=0)
                   then
                       begin
                            snake[riga_testa,col_testa]:=2;
                            snake[riga_testa-1,col_testa]:=2;
                            riga_testa:=riga_testa-2;
                            snake[riga_testa,col_testa]:=1;
                            k:=k+1;
                            l:=k;
                            m:=m+1;
                            lunghezza:=lunghezza+1;
                            n:=2;
                            coda;
                       end
                   else
                        mangiato:=true
              end;
         end;
end;

begin
     istruzioni;
     vite:=4;
     repeat
     vite:=vite-1;
     lettera:=readkey;
     lettera:='d';
     clrscr;
     inizio;
     k:=1;
     m:=0;
             repeat
                   gotoxy(1,1);
                   textcolor(white);
                   write('score: ',m);
                   if vite=3
                   then
                       begin
                            gotoxy(66,1);
                            textcolor(white);
                            write('lives: ',chr(3),' ',chr(3),' ',chr(3));
                       end;
                   if vite=2
                   then
                       begin
                            gotoxy(66,1);
                            textcolor(white);
                            write('lives: ',chr(3),' ',chr(3));
                       end;
                   if vite=1
                   then
                       begin
                            gotoxy(66,1);
                            textcolor(white);
                            write('lives: ',chr(3));
                       end;
                   assegnazione;
                   sbattuto:=false;
                   mangiato:=false;
                   if keypressed
                   then
                       lettera:=readkey;
                   if l>100
                   then
                       l:=110;
                   delay(250-l);
                   if not ((lettera='f')or(lettera='F'))
                   then
                       aggiorna;
             until ((lettera='f')or(lettera='F'))or(sbattuto=true)or(mangiato=true);
     gotoxy(1,1);
     textcolor(white);
     write('                        ');
     textcolor(lightcyan);
     gotoxy(30,11);
     write('                       ');
     gotoxy(30,12);
     write('     final score : ',m,'    ');
     gotoxy(30,13);
     write('                       ');
     if sbattuto=true
     then
         begin
              gotoxy(26,17);
              write('Ouch!!! That''s a quite hard wall!');
              gotoxy(18,19);
              write('              Press ENTER two times');
              textcolor(black);
         end;
     if mangiato=true
     then
         begin
              gotoxy(18,17);
              write('Hey!!! Eating yourself isn''t the best way to win!');
              gotoxy(18,19);
              write('            Press ENTER two times');
              textcolor(black);
         end;
     if vite=3
     then
         pt:=m
     else
         if m>pt
         then
             pt:=m;
     readln;
     until (vite=1)or((lettera='f')or(lettera='F'));
     delay(2000);
     clrscr;
     gotoxy(66,1);
     textcolor(white);
     write('lives: none');
     gotoxy(30,12);
     textcolor(lightcyan);
     write('     best score : ',pt,'    ');
     delay(2000);
end.