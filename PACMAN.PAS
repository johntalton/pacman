program pacman(input,output,infile);
{
               ---------==========================-------
                              Date 6-20-96
                             By John Talton
               ---------==========================--------

Notes to me:
   Make pacman be able to eat ghosts when eats a power pellet
   Make ghosts not go through secret walls
   Make you be able to save more than one game

               THIS PROGRAM RUNS BEST ON A 486-66 OR BETTER
}
uses crt,graph,dos;
const
   ver='2.2';{version}
   code_num=1977;{registration code num}
   maxlevelsize=44;{maximum level size}
   maxspace=40;{maximum space size}
   maxghosts=6;{max number of ghosts}
type
   leveltype=record{define level game board}
      map:array[1..maxlevelsize,1..maxlevelsize] of integer;{actual layout of board}
      eaten:array[1..maxlevelsize,1..maxlevelsize] of boolean;{whether the space has been eaten or not}
   end;
   pacmantype=array[1..maxspace,1..maxspace] of integer;{pic of pacman}
   gtype=record{ghost info record}
      ghostx,ghosty,ghost_val:integer;{x and y position and ghost direction}
      alive:boolean;{still alive or dead}
   end;
   ghosttype=array[1..maxghosts] of gtype;{set of all ghosts}
   warptype=record{holds warp data}
      a,b,c,d,stuff:integer;{warp locations }
      last:boolean;{last warp visited}
   end;
   cherrytype=array[1..maxspace,1..maxspace] of integer;{pic of the cherry}
var
    infile:text;
    level:leveltype;
    exit_code,locx,locy,{warp_stuff,}life,
    space,levelsize,gd,gm,x,y,last_level,
    speed,rep,level_num,m,numofghosts,win,
    lose,homex,homey:integer;
    score:longint;
    pac_man,blank,ghost:pacmantype;
    ghostxy:ghosttype;
    ch:char;
    credit:array[1..20] of string;
    reg,cheat1,freeze:boolean;
    warp:warptype;
    cherry:cherrytype;
    score_string:string;
{**********************************************************}
procedure credits;
{
this is a procedure that just scrols the cool credits in the
end of the game
}
var x,y,a,b:integer;
    ch:char;
begin
   reset(input);
   setcolor(0);
   for x:=getmaxx downto 1 do circle(getmaxx div 2,getmaxy div 2,x);
   b:=14;
   if reg then
      credit[1]:='PACMAN Ver '+ver+'.1 beta(c)'
   else
      credit[1]:='PACMAN Ver '+ver+'.0 beta(c)';
   credit[2]:='Created by: John Talton';
   credit[3]:='YNOP@AOL.COM';
   credit[4]:='Thanks to:';
   credit[5]:='Josh Parrish for all his help debuging.';
   credit[6]:='Melissa Thrash for giving me the idea.';
   credit[7]:=' ';
   credit[8]:='Graphics by ''The Abstract Company''(c)1996';
   credit[9]:='Writen in Turbo Pascal 7.0';
   credit[10]:=' ';
   credit[11]:='Register me for free and get cheat codes,';
   credit[12]:='and the latest version';
   credit[13]:=' ';
   credit[14]:='Press Space Bar to End';
   credit[15]:=' ';
   credit[16]:=' ';
   credit[17]:=' ';
   credit[18]:=' ';
   credit[19]:=' ';
   credit[20]:=' ';
   y:=getmaxy;
   repeat
      if keypressed then ch:=readkey;
      setbkcolor(0);
      y:=y-5;
      if y<=-100 then y:=getmaxy;
      setcolor(15);
      for a:=1 to b do
         outtextxy((getmaxx div 2)-(8*(length(credit[a]) div 2)),y+(10*a),credit[a]);
      delay(250);
      setcolor(0);
      for a:=1 to b do
         outtextxy((getmaxx div 2)-(8*(length(credit[a]) div 2)),y+(10*a),credit[a]);
   until ch=' ';
end;
{**********************************************************}
procedure get_level(levelfile:string; var level:leveltype);
{
Gets the level information and lay out
}
var x,y:integer;
begin
   for x:=1 to maxlevelsize do
      for y:=1 to maxlevelsize do
         level.map[x,y]:=0;
   assign(infile,levelfile);
   reset(infile);
   read(infile,levelsize);
   read(infile,space);
   for x:=1 to (levelsize) do
      for y:=1 to (levelsize) do
         read(infile,level.map[x,y]);
   close(infile);
   for x:=1 to (levelsize) do
      for y:=1 to (levelsize) do
         if (level.map[x,y]=1) then
            level.eaten[x,y]:=false
         else if level.map[x,y]=2 then
            level.eaten[x,y]:=false
         else if level.map[x,y]=5 then
            level.eaten[x,y]:=false
         else
            level.eaten[x,y]:=true;
end;
{**********************************************************}
procedure draw_box(x,y:integer);
{
Draws the cool red and blue boxes
}
var a,b,c:integer;
begin
   setcolor(4);
   x:=x-space;
   y:=y-space;
   for a:=1 to space do
       for b:=1 to space do
   putpixel(x+a,y+b,1);
   setcolor(1);
   line(x+space,y+space,x,y+space);
   setcolor(4);
   for c:=1 to (space div 2) do
      line(x+c,y+1,x+c,y+c);
   for c:=(space div 2) to space-1 do
      line(x+c,y+1,x+c,y-c+space);
   for c:=1 to (space div 2) do
      line(x+c,y+space,x+c,y+space-c);
   for c:=(space div 2) to space do
      line(x+c,y+space,x+c,y+c);
end;
{**********************************************************}
procedure draw_warp(x,y:integer);
{
Draws the warp box.
}
var a,b,c:integer;
begin
   setcolor(2);
   x:=x-space;
   y:=y-space;
   for a:=1 to space do
       for b:=1 to space do
   putpixel(x+a,y+b,2);
   setcolor(2);
end;
{**********************************************************}
procedure draw_dot(x,y:integer);
{
Draws the greens dots
}
var a,b,r:integer;
begin
   setcolor(2);
   a:=x+(space div 2)-space;
   b:=y+(space div 2)-space;
   for r:=(space div 4) downto 1 do
      circle(a,b,r);
end;
{**********************************************************}
procedure draw_power(x,y:integer);
{
Draws the power pellet
}
var a,b,r:integer;
begin
   setcolor(4);
   a:=x+(space div 2)-space;
   b:=y+(space div 2)-space;
   for r:=(space div 4) downto 1 do
      circle(a,b,r);
end;
{**********************************************************}
procedure draw_cherry(x,y:integer);
{
Draws cherry
}
   var a,b:integer;
begin
   x:=x-space;
   y:=y-space;
   for a:=1 to space do
      begin
        for b:=1 to space do
            begin
               if cherry[a,b]=0 then
                  begin
                    putpixel(x+b,y+a,0);
                  end
               else if cherry[a,b]=1 then
                  begin
                     putpixel(x+b,y+a,2);
                  end
               else if cherry[a,b]=2 then
                  begin
                     putpixel(x+b,y+a,4);
                  end;
             end;
       end;
end;
{**********************************************************}
procedure draw_level(level:leveltype);
{
Draws the level using draw_box, draw_power, draw_dot, draw_warp
}
var x,y:integer;
begin
   cleardevice;
      for x:=1 to levelsize do
         begin
            for y:=1 to levelsize do
               begin
                  case level.map[x,y] of
                     0:draw_box(space*y,space*x);{box or wall}
                     1:draw_dot(space*y,space*x);{green dot}
                     2:draw_power(space*y,space*x);{red power}
                     3:draw_warp(space*y,space*x);{green warp}
                     4:draw_box(space*y,space*x);{secret wall}
                     5:draw_cherry(space*y,space*x);{500pt cherry + extra life}
                  end;{case}
               end;
         end;
end;
{**********************************************************}
procedure get_pacman(pacmanfile:string; var pac_man:pacmantype);
{
gets the right size pacman for the level
}
var x,y:integer;
begin
   assign(infile,pacmanfile);
   reset(infile);
   for x:=1 to space do
      for y:=1 to space do
         read(infile,pac_man[x,y]);
   close(infile);
end;
{**********************************************************}
procedure draw_pacman(x,y:integer;dir:char; pac_man:pacmantype);
{
Draws pacman in the right place
}
var a,b,c,d:integer;
begin
   case dir of
   'u':begin
      c:=0;
      for a:=1 to space do
         begin
            c:=0;
            for b:=space downto 1 do
               begin
                  inc(c);
                  if pac_man[a,b]=0 then
                     begin
                       putpixel(x+a,y+c,0);
                     end
                  else if pac_man[a,b]=1 then
                     begin
                        putpixel(x+a,y+c,14);
                     end;
                end;
         end;
   end;
   'r':for a:=1 to space do
      begin
        for b:=1 to space do
            begin
               if pac_man[a,b]=0 then
                  begin
                    putpixel(x+b,y+a,0);
                  end
               else if pac_man[a,b]=1 then
                  begin
                     putpixel(x+b,y+a,14);
                  end;
             end;
       end;
   'd':for a:=1 to space do
      begin
        for b:=1 to space do
            begin
               if pac_man[b,a]=0 then
                  begin
                    putpixel(x+b,y+a,0);
                  end
               else if pac_man[b,a]=1 then
                  begin
                     putpixel(x+b,y+a,14);
                  end;
             end;
       end;
   'l':begin
      c:=1;
      for a:=space downto 1 do
         begin
            inc(c);
            for b:=1 to space do
               begin
                  if pac_man[b,a]=0 then
                     begin
                       putpixel(x+c,y+b,0);
                     end
                  else if pac_man[b,a]=1 then
                     begin
                        putpixel(x+c,y+b,14);
                     end;
                end;
         end;
   end;
   end;{case}
end;
{**********************************************************}
procedure get_ghost(ghostfile:string; var ghost:pacmantype);
{
Gets the ghost in the right size for the level
}
var x,y:integer;
begin
   assign(infile,ghostfile);
   reset(infile);
   for x:=1 to space do
      for y:=1 to space do
         read(infile,ghost[x,y]);
   close(infile);
end;
{**********************************************************}
procedure draw_ghost(x,y:integer; ghost:pacmantype);
{
Draws the ghost in the right place
}
var a,b:integer;
begin
   for a:=1 to space do
      begin
        for b:=1 to space do
            begin
               if ghost[a,b]=0 then
                  begin
                    putpixel(x+b,y+a,0);
                  end
               else if ghost[a,b]=1 then
                  begin
                     putpixel(x+b,y+a,15);
                  end;
             end;
       end;
end;
{**********************************************************}
procedure check_ghost(var val:integer;var ghostx:integer;var ghosty:integer;alive:boolean; level:leveltype);
{
Checks the ghost position and moves them randomly
}
var back,valold,tempx,tempy:integer;
begin
   if alive then
      begin
         randomize;
         tempx:=(ghostx+space) div space;
         tempy:=(ghosty+space) div space;
         valold:=val;
         if ((val=1) or (val=3)) and ((level.map[tempy,tempx-1]<>0) or (level.map[tempy,tempx+1]<>0)) then val:=random(5);
         if ((val=2) or (val=4)) and ((level.map[tempy-1,tempx]<>0) or (level.map[tempy+1,tempx]<>0)) then val:=random(5);
         back:=valold+2;
         if back>4 then back:=back-4;
         if val=back then val:=valold;
         if val=0 then val:=(random(3)+1);
         case val of
            1:begin
               if (level.map[tempy-1,tempx]<>0) then
                  begin
                     draw_ghost(ghostx,ghosty,blank);
                     if level.eaten[tempy,tempx]=false then
                        case level.map[tempy,tempx] of
                           1:draw_dot(ghostx+space,ghosty+space);
                           2:draw_power(ghostx+space,ghosty+space);
                           5:draw_cherry(ghostx+space,ghosty+space);
                        end;{case}
                     if level.eaten[tempy,tempx]=true then
                        case level.map[tempy,tempx] of
                           3:draw_warp(ghostx+space,ghosty+space);
                           4:draw_box(ghostx+space,ghosty+space);
                        end;{case}
                     ghosty:=ghosty-space;
                  end
               else
                  begin
                     val:=(random(5));
                  end;
         end;
         2:begin
            if (level.map[tempy,tempx+1]<>0) then
               begin
                  draw_ghost(ghostx,ghosty,blank);
                  if level.eaten[tempy,tempx]=false then
                     case level.map[tempy,tempx] of
                        1:draw_dot(ghostx+space,ghosty+space);
                        2:draw_power(ghostx+space,ghosty+space);
                        5:draw_cherry(ghostx+space,ghosty+space);
                     end;{case}
                  if level.eaten[tempy,tempx]=true then
                     case level.map[tempy,tempx] of
                        3:draw_warp(ghostx+space,ghosty+space);
                        4:draw_box(ghostx+space,ghosty+space);
                     end;{case}
                  ghostx:=ghostx+space;
               end
            else
               begin
                  val:=(random(5));
               end;
         end;
         3:begin
            if (level.map[tempy+1,tempx]<>0)  then
               begin
                  draw_ghost(ghostx,ghosty,blank);
                  if level.eaten[tempy,tempx]=false then
                     case level.map[tempy,tempx] of
                        1:draw_dot(ghostx+space,ghosty+space);
                        2:draw_power(ghostx+space,ghosty+space);
                        5:draw_cherry(ghostx+space,ghosty+space);
                     end;{case}
                  if level.eaten[tempy,tempx]=true then
                     case level.map[tempy,tempx] of
                        3:draw_warp(ghostx+space,ghosty+space);
                        4:draw_box(ghostx+space,ghosty+space);
                     end;{case}
                  ghosty:=ghosty+space;
               end
            else
               begin
                  val:=(random(5));
               end;
         end;
         4:begin
            if (level.map[tempy,tempx-1]<>0)  then
               begin
                  draw_ghost(ghostx,ghosty,blank);
                  if level.eaten[tempy,tempx]=false then
                     case level.map[tempy,tempx] of
                        1:draw_dot(ghostx+space,ghosty+space);
                        2:draw_power(ghostx+space,ghosty+space);
                        5:draw_cherry(ghostx+space,ghosty+space);
                     end;{case}
                  if level.eaten[tempy,tempx]=true then
                     case level.map[tempy,tempx] of
                        3:draw_warp(ghostx+space,ghosty+space);
                        4:draw_box(ghostx+space,ghosty+space);
                     end;{case}
                  ghostx:=ghostx-space;
               end
            else
               begin
                  val:=(random(5));
               end;
         end;
         5:val:=(random(3)+1);
         end;{case}
      draw_ghost(ghostx,ghosty,ghost);
   end;
end;
{**********************************************************}
procedure check(ch:char;var locx:integer;var locy:integer;var level:leveltype);
{
Checks the poition of pacman and responds to users request, and keeps the
score
}
var tempx,tempy,dirx,diry:integer;
begin
   tempx:=(locx+space) div space;
   tempy:=(locy+space) div space;
   level.eaten[tempy,tempx]:=true;
   case ch of
      'u':begin dirx:=0;  diry:=-1; end;
      'd':begin dirx:=0;  diry:=1; end;
      'l':begin dirx:=-1; diry:=0; end;
      'r':begin dirx:=1;  diry:=0; end;
   end;{case}
   if level.map[tempy+diry,tempx+dirx]<>0 then
      begin
         if level.eaten[tempy+diry,tempx+dirx]=false then
            begin
               case level.map[tempy+diry,tempx+dirx] of
                  1:score:=score+50;
                  2:score:=score+100;
                  5:begin score:=score+500; inc(life); end;
               end;
            end;
         draw_pacman(locx,locy,'u',blank);
         if level.map[tempy,tempx]=4 then draw_box(locx+space,locy+space);
         case ch of
            'u':locy:=locy-space;
            'd':locy:=locy+space;
            'l':locx:=locx-space;
            'r':locx:=locx+space;
         end;{case}
      end;
   {warp code begin}
   if (level.map[tempy,tempx]=3) and (warp.last=false) then
      begin
         warp.last:=true;
         if (tempx=warp.a) and (tempy=warp.b) then
            begin
               draw_warp(warp.a*space,warp.b*space);
               locx:=warp.c*space-space;
               locy:=warp.d*space-space;
            end;
         if (tempx=warp.c) and (tempy=warp.d) then
            begin
               draw_warp(warp.c*space,warp.d*space);
               locx:=warp.a*space-space;
               locy:=warp.b*space-space;
            end;
         draw_warp(warp.a*space,warp.b*space);
         draw_warp(warp.c*space,warp.d*space);
         draw_pacman(locx,locy,ch,pac_man);
      end
   else
      warp.last:=false;
   {warp code end}
   tempx:=(locx+space) div space;
   tempy:=(locy+space) div space;
   level.eaten[tempy,tempx]:=true;
   draw_pacman(locx,locy,ch,pac_man);
end;
{**********************************************************}
procedure get_setup(setupfile:string);
{
Gets all the setup files and the paramaters for the game
}
var x:integer;
begin
   assign(infile,setupfile);
   reset(infile);
   read(infile,locx);
   locx:=locx*space; homex:=locx;
   read(infile,locy);
   locy:=locy*space; homey:=locy;
   read(infile,numofghosts);
   for x:=1 to numofghosts do
      begin
         read(infile,ghostxy[x].ghostx);
         read(infile,ghostxy[x].ghosty);
         ghostxy[x].ghostx:=ghostxy[x].ghostx*space;
         ghostxy[x].ghosty:=ghostxy[x].ghosty*space;
         ghostxy[x].alive:=true;
      end;
   read(infile,warp.stuff);{1=warp 0=no warp}
   read(infile,speed);
   close(infile);
end;
{**********************************************************}
function check_end(level:leveltype): boolean;
{
Checks if the end of the reached
}
var a,x,y:integer;
   boo:boolean;
begin
   boo:=true;
   for y:=1 to levelsize do
      for x:=1 to levelsize do
         if boo=true then
            boo:=level.eaten[y,x];
   if cheat1=false then
   for a:=1 to numofghosts do
      if (locx=ghostxy[a].ghostx) and (locy=ghostxy[a].ghosty) then
         begin
            sound(100);
            delay(100);
            nosound;
            boo:=true;
            exit_code:=1;
         end;
   if life=-1 then boo:=true;
   check_end:=boo;
end;
{**********************************************************}
procedure get_warp(warpfile:string);
{
Gets the warp info from a file
}
begin
   if fsearch(warpfile,' ')<>'' then
      begin
         assign(infile,warpfile);
         reset(infile);
         read(infile,warp.a);
         read(infile,warp.b);
         read(infile,warp.c);
         read(infile,warp.d);
         close(infile);
      end
   else
      level_num:=level_num+1;
end;
{**********************************************************}
procedure get_cherry(cherryfile:string;var cherry:cherrytype);
var a,b:integer;
begin
   assign(infile,cherryfile);
   reset(infile);
   for a:=1 to space do
      for b:=1 to space do
         read(infile,cherry[a,b]);
   close(infile);
end;
{**********************************************************}
procedure change_level(num:integer);
{
Changes to the next level
}
var ch:char;
    ch1:string[3];
    ch2:string[2];
    y:integer;
begin
   y:=100;
   ch1:='';
   while y>0 do
      begin
         ch:=chr(((num div y) mod 10)+ord('0'));
         ch1:=ch1+ch;
         y:=y div 10;
      end;
   get_level('level'+ch1+'.dat',level);
   get_setup('setup'+ch1+'.dat');
   if warp.stuff=1 then
      get_warp('warp'+ch1+'.dat');
   ch2:=(chr(ord('0')+(space div 10)))+(chr(ord('0')+(space mod 10)));
   get_pacman('pacman'+ch2+'.dat',pac_man);
   get_ghost('ghost'+ch2+'.dat',ghost);
   get_cherry('cherry'+ch2+'.dat',cherry);
   for x:=1 to numofghosts do
      ghostxy[x].ghost_val:=random(4);
end;
{**********************************************************}
procedure top_ten(score:longint);
{
Keeps the top ten winners of the game
}
var scorefile:text;
    xname:array[1..15] of char;
    topten:record
       num:array[1..10] of longint;
       name:packed array[1..10,1..15] of char;
    end;
    pos,x,y,l:integer;
    top:longint;
begin
   writeln;
   assign(scorefile,'topten.dat');
   reset(scorefile);
   readln(scorefile);
   for x:=1 to 10 do
      begin
         for y:=1 to 15 do
            read(scorefile,topten.name[x,y]);
         readln(scorefile);
      end;
   for x:=1 to 10 do
      read(scorefile,topten.num[x]);
   top:=topten.num[1];
   x:=1;
   while (x<=10) and (score<=topten.num[x]) do
      begin
         x:=x+1;
      end;
   pos:=x;
   if pos<=10 then
   begin
      writeln('Enter your name:');
      {read in the name and move all other names down the list}
      xname:='               ';
      l:=1;
      while (not eoln) and (l<=15) do
         begin
            read(xname[l]);
            l:=l+1;
         end;
      reset(input);
      for x:=10 downto pos do
         begin
            for y:=1 to 15 do
               topten.name[x,y]:=topten.name[x-1,y];
         end;
      for y:=1 to 15 do
         topten.name[pos,y]:=xname[y];
      {move scoures and insert your scoure}
      for x:=10 downto pos do
         begin
           topten.num[x]:=topten.num[x-1];
         end;
       topten.num[pos]:=score;
   end;
   rewrite(scorefile);
   writeln(scorefile);
   for x:=1 to 10 do
      begin
         for y:=1 to 15 do
            write(scorefile,topten.name[x,y]);
         writeln(scorefile);
      end;
   for x:=1 to 10 do
      writeln(scorefile,topten.num[x]);
   close(scorefile);
   {writes to screen}
   writeln;
   writeln('ษอออออออออออออออออออออออออออป');
   for x:=1 to 10 do
      begin
         write('บ ');
         for y:=1 to 15 do
            write(topten.name[x,y]);
         writeln(' -- ',topten.num[x]:6,' บ');
      end;
   writeln('ศอออออออออออออออออออออออออออผ');
readln;
end;
{**********************************************************}
procedure put_title;
{
Puts the game title on the board
}
var x:integer;
    reg_text,level_text,score_text,life_text:string;
    ch:char;
begin
   setcolor(0);
   for x:=1 to 15 do
      line(0,x,getmaxx,x);
   score_text:='';
   x:=10000;
   while x<>0 do
      begin
         ch:=chr(((score div x) mod 10)+ord('0'));
         score_text:=score_text+ch;
         x:=x div 10;
      end;
   score_text:='Your Score is: '+score_text;
   setcolor(15);
   outtextxy(5,5,score_text);
   if cheat1 then outtextxy(200,5,'Cheater')
   else outtextxy(200,5,'');
   outtextxy(300,5,'Level:  ');
   x:=10;
   level_text:='';
   while x>0 do
      begin
         ch:=chr(((level_num div x) mod 10)+ord('0'));
         level_text:=level_text+ch;
         x:=x div 10;
      end;
   outtextxy(364,5,level_text);
   outtextxy(392,5,'Lives:  ');
   life_text:='';
   x:=10;
   while x>0 do
      begin
         ch:=chr(((life div x) mod 10)+ord('0'));
         life_text:=life_text+ch;
         x:=x div 10;
      end;
   outtextxy(442,5,life_text);
   setcolor(4);
   if not reg then
      reg_text:='UNREGISTERED VER '+ver+'.0'
   else
      reg_text:='REGISTERED VER '+ver+'.1';
   outtextxy(getmaxx-(length(reg_text)*8),5,reg_text);
end;
{**********************************************************}
procedure save_game{(num:integer)};
{
Saves your curent game
}
begin
   assign(infile,'save000.dat');
   rewrite(infile);
   writeln(infile,score);
   writeln(infile,level_num-1);
   writeln(infile,win);
   writeln(infile,lose);
   close(infile);
end;
{**********************************************************}
procedure restore{(num:integer)};
{
Restores the saved game
}
begin
   assign(infile,'save000.dat');
   reset(infile);
   readln(infile,score);
   readln(infile,level_num);
   readln(infile,win);
   readln(infile,lose);
   close(infile);
   life:=5;
   ch:=#27;
end;
{**********************************************************}
procedure menu;
{
Displays menu and options for user interface
}
var
   ch2:char;
   option,x,y,a,b:integer;
   p:pointer;
   size:word;
{
175 ฏ
174 ฎ
}
begin
   x:=275;
   y:=175;
   size:=imagesize(x,y,x+160,y+64);
   getmem(p,size);   { Allocate memory on heap }
   getimage(x,y,x+160,y+64,p^);
   setcolor(0);
   for a:=y to y+64 do
      line(x,a,x+160,a);
   setcolor(15);
   outtextxy(x,y,   'ษออออออออออออออออออป');
   outtextxy(x,y+8, 'บ      MENU        บ');
   outtextxy(x,y+16,'ฬออออออออออออออออออน');
   outtextxy(x,y+24,'บ       New        บ');
   outtextxy(x,y+32,'บ     Restore      บ');
   outtextxy(x,y+40,'บ      Save        บ');
   outtextxy(x,y+48,'บ      Quit        บ');
   outtextxy(x,y+56,'ศออออออออออออออออออผ');
   option:=1;
   repeat
      ch2:=' ';
      if keypressed then
         ch2:=readkey;
      case ch2 of
   {up}  #72:begin option:=option-1; if option=0 then option:=4; end;
  {down} #80:begin option:=option+1; if option=5 then option:=1; end;
      end;{case}
      case option of
         1:begin
            setcolor(15);
            outtextxy(x,y+24,'บ  ฏฏ   New   ฎฎ   บ');
            setcolor(0);
            outtextxy(x,y+32,'   ฏฏ         ฎฎ    ');
            outtextxy(x,y+40,'   ฏฏ         ฎฎ    ');
            outtextxy(x,y+48,'   ฏฏ         ฎฎ    ');
           end;
         2:begin
            setcolor(0);
            outtextxy(x,y+24,'   ฏฏ         ฎฎ    ');
            setcolor(15);
            outtextxy(x,y+32,'บ  ฏฏ Restore ฎฎ   บ');
            setcolor(0);
            outtextxy(x,y+40,'   ฏฏ         ฎฎ    ');
            outtextxy(x,y+48,'   ฏฏ         ฎฎ    ');
           end;
         3:begin
            setcolor(0);
            outtextxy(x,y+24,'   ฏฏ         ฎฎ    ');
            outtextxy(x,y+32,'   ฏฏ         ฎฎ    ');
            setcolor(15);
            outtextxy(x,y+40,'บ  ฏฏ  Save   ฎฎ   บ');
            setcolor(0);
            outtextxy(x,y+48,'   ฏฏ         ฎฎ    ');
           end;
         4:begin
            setcolor(0);
            outtextxy(x,y+24,'   ฏฏ         ฎฎ    ');
            outtextxy(x,y+32,'   ฏฏ         ฎฎ    ');
            outtextxy(x,y+40,'   ฏฏ         ฎฎ    ');
            setcolor(15);
            outtextxy(x,y+48,'บ  ฏฏ  Quit   ฎฎ   บ');
           end;
      end;{case}
   until ((option in [1..4]) and (ch2=#13)) or (ch2=#27);
   putimage(x,y,p^,normalput);
   if ch2=#27 then option:=0;
   case option of
      1:begin ch:=#27; life:=last_level div 2; level_num:=0; score:=0; win:=0; lose:=0; end;
      2:restore;
      3:save_game;
      4:begin ch:=#27; level_num:=last_level; life:=0; score:=00; win:=0; lose:=0; end;
   end;{case}
end;
{**********************************************************}
function get_level_num: integer;
var s:pathstr;
    found:boolean;
    ch:char;
    x,y:integer;
    numstr:string;
begin
   found:=true;
   x:=0;
   repeat
      inc(x);
      y:=100;
      numstr:='';
      while y>0 do
         begin
            ch:=chr(((x div y) mod 10)+ord('0'));
            numstr:=numstr+ch;
            y:=y div 10;
         end;
      s:= fsearch('level'+numstr+'.dat',' ');
      if s = '' then
            found:=false;
      s:= fsearch('setup'+numstr+'.dat',' ');
      if s = '' then
            found:=false;
   until not found or (x=999);
   dec(x);
   get_level_num:=x;
end;
{**********************************************************}
procedure help;
var
   ch2:char;
   option,x,y,a,b:integer;
   p:pointer;
   size:word;
begin
   x:=275;
   y:=175;
   size:=imagesize(x,y,x+160,y+72);
   getmem(p,size);   { Allocate memory on heap }
   getimage(x,y,x+160,y+72,p^);
   setcolor(0);
   for a:=y to y+72 do
      line(x,a,x+160,a);
   setcolor(15);
   outtextxy(x,y,   'ษออออออออออออออออออป');
   outtextxy(x,y+8, 'บ      HELP        บ');
   outtextxy(x,y+16,'ฬออออออออออออออออออน');
   outtextxy(x,y+24,'บ   ''H''-Help       บ');
   outtextxy(x,y+32,'บ   ''M''-Menu       บ');
   outtextxy(x,y+40,'บ  Move-Arrow Keys บ');
   outtextxy(x,y+48,'ฬออออออออออออออออออน');
   outtextxy(x,y+56,'บ  Press any Key   บ');
   outtextxy(x,y+64,'ศออออออออออออออออออผ');
   readkey;
   putimage(x,y,p^,normalput);
end;
{**********************************************************}
procedure get_reg;
{
checks to see if this ver is registered
}
var reg_num:integer;
begin
   reg:=false;
   if fsearch('reg.dat',' ')<>'' then
      begin
         assign(infile,'reg.dat');
         reset(infile);
         read(infile,reg_num);
         close(infile);
         if reg_num=code_num then
            reg:=true;
      end;
end;
{**********************************************************}
{**********************************************************}
{---------===========The Main Program===========-----------}
begin
   randomize;
   for x:=1 to space do
      for y:=1 to space do
         blank[x,y]:=0;
   gd:=detect;
   initgraph(gd,gm,' ');
   setbkcolor(0);
   get_reg;
   lose:=0;
   win:=0;
   score:=0;
   exit_code:=0;
   level_num:=0;{number of level to start on (0)}
   last_level:=get_level_num;{gets the total num of levels from num of levelxxx.dat files}
   life:=last_level div 2;
   speed:=50;
   repeat
      exit_code:=0;
      freeze:=false;
      cheat1:=false;
      level_num:=level_num+1;
      change_level(level_num);
      draw_level(level);
      draw_pacman(locx,locy,'u',pac_man);
      for m:=1 to numofghosts do
         check_ghost(ghostxy[m].ghost_val,ghostxy[m].ghostx,ghostxy[m].ghosty,ghostxy[m].alive,level);
      rep:=1;
      setcolor(15);
      outtextxy(5,getmaxy-10,'''m'' - Menu  ''h'' - Help');
      repeat
         if ((rep=30) or (speed<=30)) then put_title;
         if (rep=speed) and (not freeze) then
               begin
                  for m:=1 to numofghosts do
                     check_ghost(ghostxy[m].ghost_val,ghostxy[m].ghostx,ghostxy[m].ghosty,ghostxy[m].alive,level);
                  rep:=0;
               end;
         inc(rep);
         if keypressed then
            begin
               ch:=readkey;
               case ch of
                  #72:check('u',locx,locy,level);
                  #80:check('d',locx,locy,level);
                  #75:check('l',locx,locy,level);
                  #77:check('r',locx,locy,level);
                  #71:if reg then begin draw_pacman(locx,locy,'u',blank); locx:=homex; locy:=homey; end;
                  '~':if reg then cheat1:=not cheat1;
                  'f':if reg then begin freeze:=not freeze; rep:=0; end;
                  'm','M':menu;
                  'h','H':help;
               end;{case}
               {draw_pacman(locx,locy,pac_man);}
            end;
      until (ch=#27) or (check_end(level)=true);
      if ch=#27 then exit_code:=1;
      ch:=' ';
      if exit_code=1 then
         begin
            lose:=lose+1;
            life:=life-1;
            level_num:=level_num-1;
            setcolor(15);
            settextstyle(defaultfont,horizdir,2);
            outtextxy(180,200,'YOU LOSE THIS LEVEL');
            settextstyle(defaultfont,horizdir,1);
            delay(300);
         end
      else
         win:=win+1;
   until (level_num=last_level) or (life=-1);
   reset(input);
   credits;
   cleardevice;
   setcolor(15);
   outtextxy(10,5,'Your score is  ');
   x:=10000;
   score_string:='';
   while x>0 do
      begin
         ch:=chr(((score div x) mod 10)+ord('0'));
         score_string:=score_string+ch;
         x:=x div 10;
      end;
   outtextxy(120,5,score_string);
   readln;
   closegraph;
   clrscr;
   writeln('Your score is  ',score);
   writeln('Wins:  ',win:2,'  Loses:  ',lose);
   writeln;
   top_ten(score);
end.
{-------------==============The End============------------}
{**********************************************************}
{**********************************************************}