program modulo_2;
uses crt;
var
  bil1,bil2,sisa:integer;
begin
  readln(bil1);
  readln(bil2);
  sisa:=bil1;
  while (sisa>bil2) do
        begin
          sisa:=sisa-bil2;
        end;
  writeln(sisa);
  readln;
end.
