program faktorial;
uses crt;
var
  bil,hasil:integer;
begin
  clrscr;
  hasil:=1;                         //INISIALISASI
  write('masukkan bilangan: ');readln(bil);
  if (bil >=0) then
  begin
    bil:=bil+1;
    while (bil > 1) do
    begin
         bil:=bil-1;                //NEXT ELEMENT
         hasil:=hasil*bil;          //PROCESS CURRENT ELEMENT - BEGIN
         write(bil);
         if (bil > 1) then
         begin
              write(' x ');
         end
         else
         begin
              write(' = ');
         end;                       //PROCESS CURRENT ELEMENT - END
    end;
    writeln(hasil);                 //TERMINATION
  end
  else
    begin
         writeln('Undefined');
    end;
  readln;
end.
