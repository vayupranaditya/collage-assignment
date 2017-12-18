program perkalian_1;
uses crt;
var
  bil1,bil2,perulangan,hasil:integer;
begin
  readln(bil1);
  readln(bil2);
  perulangan:=0;
  if (bil1<0) then
     begin
          while (perulangan < (-1*bil1)) do
             begin
               hasil:=hasil+bil2;
               perulangan:=perulangan+1;
             end;
          hasil:=-1*hasil;
     end
  else if (bil1>0) then
       while (perulangan < bil1) do
          begin
            hasil:=hasil+bil2;
            perulangan:=perulangan+1;
          end;
  writeln(hasil);
  readln;
end.
