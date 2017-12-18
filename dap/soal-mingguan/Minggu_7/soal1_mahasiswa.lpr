program soal1_mahasiswa;
uses crt;
type
  mahasiswa = record
    nama:string;
    nim,nilai:integer;
  end;
var
  orang,terkecil:mahasiswa;
begin
  clrscr;
  write('Nama mahasiswa : ');readln(orang.nama);
  write('NIM mahasiswa  : ');readln(orang.nim);
  write('Nilai mahasiswa: ');readln(orang.nilai);
  terkecil.nilai:=orang.nilai;
  while (orang.nim <> 0) do begin
    if (orang.nilai<=terkecil.nilai) then begin
      terkecil.nama:=orang.nama;
      terkecil.nim:=orang.nim;
      terkecil.nilai:=orang.nilai;
      end;
    write('Nama mahasiswa : ');readln(orang.nama);
    write('NIM mahasiswa  : ');readln(orang.nim);
    write('Nilai mahasiswa: ');readln(orang.nilai);
    end;
  writeln('Nilai terkecil: ',terkecil.nilai,' didapatkan oleh:');
  writeln('Nama: ',terkecil.nama);
  writeln('NIM : ',terkecil.nim);
  readln;
end.
