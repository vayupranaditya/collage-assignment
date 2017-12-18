program deret_bilangan;
uses crt;
var
  a,b,min,max,bil:integer;
begin
  clrscr;
  write('masukkan a: ');readln(a);
  write('masukkan b: ');readln(b);

  if (a>b) then
  begin
    min:=b;
    max:=a;
  end
  else
  begin
    min:=a;
    max:=b;
  end;
  for bil:=min to max do
  begin
    write(bil,' ');
  end;
  writeln;
  readln;
end.
