program create(input,output,infile,outfile);
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
   gd,gm,
   size,a,b,pacx,pacy,
   curx,cury,numofghosts:integer;
   infile,outfile:text;
   level:leveltype;
   ch:char;
   ch2:string[2];
   load_level,reg:boolean;
   pac_man,ghost:pacmantype;
   ghostxy:ghosttype;
   cherry:cherrytype;
   warp:warptype;
   levelname:string;
{**********************************************************}
procedure draw_cur(curx,cury,color:integer);
var x,y:integer;
begin
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   setcolor(color);
   line(x+(size div 2)-5,y+(size div 2),x+(size div 2)+5,y+(size div 2));
   line(x+(size div 2),y+(size div 2)-5,x+(size div 2),y+(size div 2)+5);
end;
{**********************************************************}
procedure draw_blank(curx,cury:integer);
var x,y,c:integer;
begin
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   setcolor(0);
   for c:=1 to size do
      line(x,y+c,x+size,y+c);
end;
{**********************************************************}
procedure draw_box(curx,cury:integer);
{
Draws the cool red and blue boxes
}
var a,b,c,x,y:integer;
begin
   setcolor(4);
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   for a:=1 to size do
       for b:=1 to size do
   putpixel(x+a,y+b,1);
   setcolor(1);
   line(x+size,y+size,x,y+size);
   setcolor(4);
   for c:=1 to (size div 2) do
      line(x+c,y+1,x+c,y+c);
   for c:=(size div 2) to size-1 do
      line(x+c,y+1,x+c,y-c+size);
   for c:=1 to (size div 2) do
      line(x+c,y+size,x+c,y+size-c);
   for c:=(size div 2) to size do
      line(x+c,y+size,x+c,y+c);
end;
{**********************************************************}
procedure draw_warp(curx,cury:integer);
{
Draws the warp box.
}
var a,b,c,x,y:integer;
begin
   setcolor(2);
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   for a:=1 to size do
       for b:=1 to size do
   putpixel(x+a,y+b,2);
   setcolor(2);
end;
{**********************************************************}
procedure draw_dot(curx,cury:integer);
{
Draws the greens dots
}
var a,b,r,x,y:integer;
begin
   draw_blank(curx,cury);
   setcolor(2);
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   a:=x+(size div 2);
   b:=y+(size div 2);
   for r:=(size div 4) downto 1 do
      circle(a,b,r);
end;
{**********************************************************}
procedure draw_power(curx,cury:integer);
{
Draws the power pellet
}
var a,b,r,x,y:integer;
begin
   draw_blank(curx,cury);
   setcolor(4);
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   a:=x+(size div 2);
   b:=y+(size div 2);
   for r:=(size div 4) downto 1 do
      circle(a,b,r);
end;
{**********************************************************}
procedure draw_secret(curx,cury:integer);
var a,b,c,x,y:integer;
begin
   setcolor(2);
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   for a:=1 to size do
       for b:=1 to size do
   putpixel(x+a,y+b,1);
   setcolor(1);
   line(x+size,y+size,x,y+size);
   setcolor(2);
   for c:=1 to (size div 2) do
      line(x+c,y+1,x+c,y+c);
   for c:=(size div 2) to size-1 do
      line(x+c,y+1,x+c,y-c+size);
   for c:=1 to (size div 2) do
      line(x+c,y+size,x+c,y+size-c);
   for c:=(size div 2) to size do
      line(x+c,y+size,x+c,y+c);
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
procedure credits;
{
this is a procedure that just scrols the cool credits in the
end of the game
}
var x,y,a,b:integer;
    ch:char;
    credit:array[1..20] of string;
begin
   reset(input);
   setcolor(0);
   for x:=getmaxx downto 1 do circle(getmaxx div 2,getmaxy div 2,x);
   b:=15;
   if reg then
      credit[1]:='LEVEL EDITOR Ver '+ver+'.1 beta(c)'
   else
      credit[1]:='LEVEL EDITOR Ver '+ver+'.0 beta(c)';
   credit[2]:='for PACMAN';
   credit[3]:='Created by: John Talton';
   credit[4]:='YNOP@AOL.COM';
   credit[5]:='Thanks to:';
   credit[6]:='Josh Parrish for all his help debuging.';
   credit[7]:='Melissa Thrash for giving me the idea.';
   credit[8]:=' ';
   credit[9]:='Graphics by ''The Abstract Company''(c)1996';
   credit[10]:='Writen in Turbo Pascal 7.0';
   credit[11]:=' ';
   credit[12]:='Register me for free and get cheat codes,';
   credit[13]:='and the latest version';
   credit[14]:=' ';
   credit[15]:='Press Space Bar to End';
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
function dir_ok:boolean;
begin
   if fsearch('pacman.exe',' ')='' then
      dir_ok:=false
   else dir_ok:=true;
end;
{**********************************************************}
procedure draw_title;
var curx_str,cury_str,reg_str,title_str:string;
    x:integer;
    ch:char;
begin
   if not reg then
      reg_str:='UNREGISTERED VER '+ver+'.0'
   else
      reg_str:='REGISTERED VER '+ver+'.1';
   setcolor(0);
   for x:=1 to 10 do
      line(1,1+x,getmaxx,1+x);
   title_str:='LEVEL EDITOR '+reg_str+' ³ 0=Box 1=Dot 2=Power 3=Warp 4=Secret 5=Cherry G=Ghost P=Pacman ³';
   setcolor(15);
   outtextxy(5,1,title_str);
   end;
{**********************************************************}
procedure get_pacman(pacmanfile:string);
{
gets the right size pacman for the level
}
var x,y:integer;
begin
   assign(infile,pacmanfile);
   reset(infile);
   for x:=1 to size do
      for y:=1 to size do
         read(infile,pac_man[x,y]);
   close(infile);
end;
{**********************************************************}
procedure draw_pacman(curx,cury:integer);
{
Draws pacman in the right place
}
var a,b,c,d,x,y:integer;
    dir:char;
begin
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   dir:='r';
   case dir of
   'u':begin
      c:=0;
      for a:=1 to size do
         begin
            c:=0;
            for b:=size downto 1 do
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
   'r':for a:=1 to size do
      begin
        for b:=1 to size do
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
   'd':for a:=1 to size do
      begin
        for b:=1 to size do
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
      for a:=size downto 1 do
         begin
            inc(c);
            for b:=1 to size do
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
procedure get_ghost(ghostfile:string);
{
Gets the ghost in the right size for the level
}
var x,y:integer;
begin
   assign(infile,ghostfile);
   reset(infile);
   for x:=1 to size do
      for y:=1 to size do
         read(infile,ghost[x,y]);
   close(infile);
end;
{**********************************************************}
procedure draw_ghost(curx,cury:integer);
{
Draws the ghost in the right place
}
var a,b,x,y:integer;
begin
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   for a:=1 to size do
      begin
        for b:=1 to size do
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
procedure get_cherry(cherryfile:string);
var a,b:integer;
begin
   assign(infile,cherryfile);
   reset(infile);
   for a:=1 to size do
      for b:=1 to size do
         read(infile,cherry[a,b]);
   close(infile);
end;
{**********************************************************}
procedure draw_cherry(curx,cury:integer);
{
Draws cherry
}
   var a,b,x,y:integer;
begin
   x:=(curx-1)*size;
   y:=(cury-1)*size;
   for a:=1 to size do
      begin
        for b:=1 to size do
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
procedure get_level(var levelfile:string; var level:leveltype);
{
Gets the level information and lay out
}
var x,y,levelsize:integer;
begin
   for x:=1 to maxlevelsize do
      for y:=1 to maxlevelsize do
         level.map[x,y]:=0;
   assign(infile,levelfile);
   reset(infile);
   read(infile,levelsize);
   read(infile,size);
   for x:=1 to (levelsize) do
      for y:=1 to (levelsize) do
         read(infile,level.map[x,y]);
   close(infile);
end;
{**********************************************************}
procedure draw_level(level:leveltype);
{
Draws the level using draw_box, draw_power, draw_dot, draw_warp
}
var x,y,space:integer;
begin
   space:=size;
   cleardevice;
      for x:=1 to 23{maxlevelsize} do
         begin
            for y:=1 to 23{maxlevelsize} do
               begin
                  case level.map[x,y] of
                     0:draw_box(y,x);{box or wall}
                     1:draw_dot(y,x);{green dot}
                     2:draw_power(y,x);{red power}
                     3:draw_warp(y,x);{green warp}
                     4:draw_secret(y,x);{secret wall}
                     5:draw_cherry(y,x);{500pt cherry + extra life}
                  end;{case}
               end;
         end;
   draw_title;
end;
{**********************************************************}
procedure do_level(var levelfile:string);
var x,y,levelsize:integer;
begin
   for x:=1 to maxlevelsize do
      for y:=1 to maxlevelsize do
         level.map[x,y]:=0;
   assign(infile,levelfile);
   reset(infile);
   read(infile,levelsize);
   read(infile,size);
   for x:=1 to (levelsize) do
      for y:=1 to (levelsize) do
         read(infile,level.map[x,y]);
   close(infile);
   cleardevice;
      for x:=1 to 23{maxlevelsize} do
         begin
            for y:=1 to 23{maxlevelsize} do
               begin
                  case level.map[x,y] of
                     0:draw_box(y,x);{box or wall}
                     1:draw_dot(y,x);{green dot}
                     2:draw_power(y,x);{red power}
                     3:draw_warp(y,x);{green warp}
                     4:draw_secret(y,x);{secret wall}
                     5:draw_cherry(y,x);{500pt cherry + extra life}
                  end;{case}
               end;
         end;
   draw_title;
end;
{**********************************************************}
{**********************************************************}
{**********************************************************}
{**********************************************************}
begin
   clrscr;
   if dir_ok then
   begin
   get_reg;
   if reg then writeln('Thank you for registering this product.')
   else begin writeln('Please register this program!'); delay(300); end;
   writeln('Would you like to Edit an old level or Create a new one:  E ³³ C ??');
   repeat
      gotoxy(1,3);
      write('       ');
      gotoxy(1,3);
      read(ch);
   until ch in ['e','E','c','C'];
   reset(input);
   clrscr;
   if (ch='e') or (ch='E') then
      begin
         write('Enter the level file name:   ');
         readln(levelname);
         get_level(levelname,level);
         load_level:=true;
      end
   else
      begin
         writeln('What size squares are you going to use:  15 ³³ 30 ??');
         repeat
            gotoxy(1,2);
            write('       ');
            gotoxy(1,2);
            read(size);
         until size in [15,30];
         reset(input);
         load_level:=false;
      end;
   ch2:=(chr(ord('0')+(size div 10)))+(chr(ord('0')+(size mod 10)));
   get_pacman('pacman'+ch2+'.dat');
   get_ghost('ghost'+ch2+'.dat');
   get_cherry('cherry'+ch2+'.dat');
   numofghosts:=0;
   for a:=1 to maxlevelsize do
      for b:=1 to maxlevelsize do
         level.map[a,b]:=0;
   initgraph(gd,gm,' ');
   cleardevice;
   warp.stuff:=0;
   curx:=1;
   cury:=1;
{   draw_level(level);}
{   do_level(levelname);}
   draw_cur(curx,cury,15);
   draw_title;
   repeat
      if keypressed then
         begin
            ch:=readkey;
            draw_cur(curx,cury,0);
            case ch of
               #72:if cury>1 then dec(cury);
               #80:if cury<=(getmaxy div size) then inc(cury);
               #75:if curx>1 then dec(curx);
               #77:if curx<=(getmaxx div size)-1 then inc(curx);
               ' ':begin draw_blank(curx,cury);  level.map[cury,curx]:=0; end;
               '0':begin draw_box(curx,cury);    level.map[cury,curx]:=0; end;
               '1':begin draw_dot(curx,cury);    level.map[cury,curx]:=1; end;
               '2':begin draw_power(curx,cury);  level.map[cury,curx]:=2; end;
               '3':begin draw_warp(curx,cury);
                         level.map[cury,curx]:=3;
                         if warp.stuff=1 then
                            begin
                               warp.c:=curx;
                               warp.d:=cury;
                            end
                         else
                            begin
                               warp.a:=curx;
                               warp.b:=cury;
                            end;
                         warp.stuff:=1;
                   end;
               '4':begin draw_secret(curx,cury); level.map[cury,curx]:=4; end;
               '5':begin draw_cherry(curx,cury); level.map[cury,curx]:=5; end;
               'g':begin draw_ghost(curx,cury);
                         inc(numofghosts);
                         ghostxy[numofghosts].ghostx:=curx;
                         ghostxy[numofghosts].ghosty:=cury;
                   end;
               'p':begin draw_pacman(curx,cury); pacx:=curx; pacy:=cury; end;
            end;{case}
            if (cury=1) and (ch in['0'..'5','g','p']) then draw_title;
            draw_cur(curx,cury,15);
         end;
   until ch=#27;
   credits;
   {if load_level then assign(outfile,level_name)
   else} assign(outfile,'levelxxx.dat');
   rewrite(outfile);
   write(outfile,maxlevelsize,' ');
   writeln(outfile,size);
   for a:=1 to maxlevelsize do
      begin
         for b:=1 to maxlevelsize do
            write(outfile,level.map[a,b],' ');
         writeln(outfile);
      end;
   closegraph;
   close(outfile);
   assign(outfile,'setupxxx.dat');
   rewrite(outfile);
   writeln(outfile,pacx-1,' ',pacy-1,' ',numofghosts);
   for a:=1 to numofghosts do
      writeln(outfile,ghostxy[a].ghostx-1,' ',ghostxy[a].ghosty-1);
   write(outfile,warp.stuff,' ');
   writeln(outfile,'30');{set ghost speed!!}
   close(outfile);
   if warp.stuff=1 then
      begin
         assign(outfile,'warpxxx.dat');
         rewrite(outfile);
         write(outfile,warp.a,' ',warp.b,' ',warp.c,' ',warp.d);
         close(outfile);
      end;
   end{dir_ok}
   else
      begin
         textcolor(15);
         writeln('This editor must be in the same dir as the Pacman program!');
         write('Press any key');
         readkey;
      end;
   clrscr;
end.