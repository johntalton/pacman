program resetdat(outfile);
uses crt;
var outfile:text;
    x:integer;

begin
{**************************************}
{rewrite topten file}
   assign(outfile,'topten.dat');
   rewrite(outfile);
   writeln(outfile);
   writeln(outfile,'-=JOHN TALTON=-');
   for x:=1 to 9 do
      writeln(outfile,'XXXXXXXXXXXXXXX');
   writeln(outfile,'999999');
   for x:=1 to 9 do
      writeln(outfile,'0');
   close(outfile);
{**************************************}
{write save000.dat}
   assign(outfile,'save000.dat');
   rewrite(outfile);
   write(outfile,'0 1 0 0');
   close(outfile);
{**************************************}
{write pacman15}
   assign(outfile,'pacman15.dat');
   rewrite(outfile);
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 1 1 1 1 1 0 0 0 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 0 0 1 1 1 0 0');
   writeln(outfile,'1 1 1 1 1 1 1 1 0 0 1 1 1 1 0');
   writeln(outfile,'1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'1 1 1 1 1 1 1 1 1 0 0 0 0 0 0');
   writeln(outfile,'1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 1 1 1 1 1 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   close(outfile);
{**************************************}
{write pacman30}
   assign(outfile,'pacman30.dat');
   rewrite(outfile);
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 0');
   writeln(outfile,'0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0');
   writeln(outfile,'0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   close(outfile);
{**************************************}
{write ghost15}
   assign(outfile,'ghost15.dat');
   rewrite(outfile);
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 0 0 1 1 1 0 0 1 1 0 0');
   writeln(outfile,'0 0 1 1 0 0 1 1 1 0 0 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 0 0');
   writeln(outfile,'0 1 0 0 1 1 0 0 0 1 1 0 1 1 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   close(outfile);
{**************************************}
{write ghost30}
   assign(outfile,'ghost30.dat');
   rewrite(outfile);
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 0 0 0 0 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 0 0 0 0 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0');
   writeln(outfile,'0 1 1 1 1 1 0 0 1 1 1 1 1 1 0 1 1 1 1 1 1 0 0 1 1 1 1 1 0 0');
   writeln(outfile,'0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   close(outfile);
{**************************************}
{write cherry15}
   assign(outfile,'cherry15.dat');
   rewrite(outfile);
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 1 1 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 1 1 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 1 1 1 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 1 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 1 1 0 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 1 1 0 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 0 2 2 2 2 0 2 2 2 0 0 0');
   writeln(outfile,'0 0 0 2 2 2 2 2 2 0 2 2 2 0 0');
   writeln(outfile,'0 0 2 2 2 2 2 2 2 2 0 2 2 2 0');
   writeln(outfile,'0 0 2 2 2 2 2 2 2 2 0 2 2 2 0');
   writeln(outfile,'0 0 2 2 2 2 2 2 2 2 0 2 2 2 0');
   writeln(outfile,'0 0 0 2 2 2 2 2 2 0 2 2 2 0 0');
   writeln(outfile,'0 0 0 0 2 2 2 2 0 2 2 2 0 0 0');
   close(outfile);
{**************************************}
{write cherry30}
   assign(outfile,'cherry30.dat');
   rewrite(outfile);
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 2 2 2 2 2 2 0 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0');
   writeln(outfile,'0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0');
   writeln(outfile,'0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0');
   writeln(outfile,'0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0');
   writeln(outfile,'0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0');
   writeln(outfile,'0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 2 2 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 2 2 2 2 2 2 2 0 0 2 2 2 2 2 2 2 0 0 0 0 0 0');
   writeln(outfile,'0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
   close(outfile);
{**************************************}
{}
{**************************************}
{}

{**************************************}
{}

{**************************************}
   writeln('Dat file''s rewriten');
end.