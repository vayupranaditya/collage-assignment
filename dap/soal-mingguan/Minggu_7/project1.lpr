program permutaskombinasifaktorial;
var
  n,r:integer;

function faktorial(n:integer):integer;
{IS. terdefinisi integer n
FS. mengembalikan nilai faktorial dari n}
var
  i,hasil:integer;
begin
  hasil:=1;
  for i:=1 to n do
  begin
    hasil:=hasil*i;
  end;
  faktorial:=hasil;
end;

function permutasi(n,r:integer):real;
{IS. terdefinisi integer n dan r
FS. mengembalikan nilai permutasi dari n dan r}
begin
  permutasi:=faktorial(n)/(faktorial(n-r));
end;

function kombinasi(n,r:integer):real;
{IS. terdefinisi integer n dan r
FS. mengembalikan nilai kombinasi dari n dan r}
begin
  kombinasi:=faktorial(n)/(faktorial(n-r)*faktorial(r));
end;

begin
     write('Masukkan n: ');readln(n);
     write('Masukkan r: ');readln(r);
     writeln('permutasi(',n,',',r,') = ',permutasi(n,r):0:0);
     writeln('kombinasi(',n,',',r,') = ',kombinasi(n,r):0:0);
     readln;
end.
