program usia_produktif;
uses crt;
var
  usia,orang,anak,remaja,dewasa:integer;
begin
  clrscr;
  anak:=0;
  remaja:=0;
  dewasa:=0;
  orang:=1;
  write('usia orang ',orang,' : ');readln(usia);
  while (usia <> 9999) do
  begin
    if ((usia >= 0) AND (usia <=12)) then
    begin
      anak:=anak+1;
      orang:=orang+1;
    end
    else if ((usia>12) AND (usia<=22)) then
    begin
      remaja:=remaja+1;
      orang:=orang+1;
    end
    else if (usia > 22)then
    begin
      dewasa:=dewasa+1;
      orang:=orang+1;
    end;
    write('usia orang ',orang,' : ');readln(usia);
  end;
  writeln;
  writeln('anak-anak: ',anak);
  writeln('remaja   : ',remaja);
  writeln('dewasa   : ',dewasa);
  readln;
end.
