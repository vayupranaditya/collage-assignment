program soal3_permutasi_kombinasi;
uses crt;
var
  n,r:integer;

function faktorial(x:integer):integer;
{IS. terdefinisi integer x
FS. mengembalikan nilai faktorial dari x}
var
  i:integer;
begin
  faktorial:=1;
  for i:=1 to x do begin
    faktorial:=faktorial*i;
  end;
end;

function permutasi(n,r:integer):real;
{IS. terdefinisi integer n dan r
FS. mengembalikan nilai permutasi dari n dan r}
begin
  permutasi:=faktorial(n)/faktorial(n-r);
end;

function kombinasi(n,r:integer):real;
{IS. terdefinisi integer n dan r
FS. mengembalikan nilai kombinasi dari n dan r}
begin
  kombinasi:=faktorial(n)/(faktorial(n-r)*faktorial(r));
end;

begin
     clrscr;
     write('Masukkan n: ');readln(n);
     write('Masukkan r: ');readln(r);
     writeln('permutasi(',n,',',r,') = ',permutasi(n,r):0:0);
     writeln('kombinasi(',n,',',r,') = ',kombinasi(n,r):0:0);
     readln;
end.
