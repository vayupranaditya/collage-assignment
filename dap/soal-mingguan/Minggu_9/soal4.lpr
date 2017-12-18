program soal4;
uses crt;
var
  bil: array[1..10] of integer;
  get,find,i: integer;
begin
  clrscr;
  for i:=1 to 10 do begin
    write('bil ',i,' : ');readln(bil[i]);
    end;
  write('angka yang ingin dicari: ');readln(find);
  get:=0;
  for i:=1 to 10 do begin
    if (bil[i] = find) then begin
      get:=get+1;
      end;
    end;
  writeln('kemunculan angka ',find,' adalah ',get);
  readln;
end.