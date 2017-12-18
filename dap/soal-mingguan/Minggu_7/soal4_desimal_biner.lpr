program decimal2biner;
uses crt;
var
  bilangan:longint;
  nilaiBiner:string;

function decimal2biner(dec:integer):string;
  {IS. terdefinisi integer dec
  FS. mengembalikan nilai biner (yang direpresentasikan dalam string),
  dari integer dec}
  var
    jumlah_bit,pembagi,pangkat,bit_dipakai,i:longint;
  begin
    decimal2biner:='';
    //nyari jumlah bit yang dipakai
    jumlah_bit:=1;
    pembagi:=1;
    pangkat:=0;
    while (pembagi<=dec) do begin
      pembagi:=pembagi*2;
      jumlah_bit:=jumlah_bit+1;
      pangkat:=pangkat+1;
      end;

    //penulisan biner
    if ((dec div pembagi) = 1) then begin
      decimal2biner:=decimal2biner+'1';
      end; //nyari pembagi
    for bit_dipakai:=2 to jumlah_bit do begin
      pangkat:=pangkat-1;
      pembagi:=1;
      for i:=1 to pangkat do begin
        pembagi:=pembagi*2;
        end; //nyari pembagi
      if ((dec div pembagi) = 1) then begin
        decimal2biner:=decimal2biner+'1';
        end else begin
        decimal2biner:=decimal2biner+'0';
      end;
      dec:=dec mod pembagi; //nyari sisa
    end;
  end;

begin
  clrscr;
  write('masukkan bilangan: ');readln(bilangan);
  nilaiBiner:=decimal2biner(bilangan);
  writeln('Nilai biner dari ',bilangan,' adalah: ',nilaiBiner);
  readln;
end.
