program stop_dua_kali;
uses crt;
var
  teks:string;
  stop:boolean;
begin
  clrscr;
  stop:=False;
  write('teks : ');readln(teks);
  while ((teks <> 'stop') OR (stop = False)) do
  begin
    if (teks = 'stop') then
    begin
      stop:=True;
    end
    else
    begin
      stop:=False;
    end;
    write('teks : ');readln(teks);
  end;
  readln;
end.
