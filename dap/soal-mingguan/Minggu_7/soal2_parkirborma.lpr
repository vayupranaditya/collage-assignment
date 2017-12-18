program soal2_parkirborma;
uses crt;
const
  menitjam12=720;
type
  waktu = record
    jam, menit:integer;
  end;
var
  TM, TK:waktu;
  tarif:integer;

function hitungDurasi(TM:waktu;TK:waktu):waktu;
  {IS. terdefinisi waktu masuk parkir TM dan waktu keluar parkir TK
  FS. mengembalikan durasi parkir dalam waktu}
  var
    masuk, keluar:integer;
  begin
    masuk:=(TM.jam*60)+TM.menit;
    keluar:=(TK.jam*60)+TK.menit;
    if (keluar>masuk) then begin
      hitungDurasi.jam:=(keluar-masuk) div 60;
      hitungDurasi.menit:=(keluar-masuk) mod 60;
    end else begin
      hitungDurasi.jam:=((keluar+menitjam12)- masuk) div 60;
      hitungDurasi.menit:=((keluar+menitjam12)- masuk) mod 60;
    end;
  end;

procedure hitungTarif(durasi:waktu; var tarif:integer);
  {IS. terdefinisi waktu durasi parkir
  FS. menghitung tarif parkir dengan ketentuan: 2000 untuk 1 jam pertama,
  dan 1000 untuk tiap jam berikutnya}
  begin
    if (durasi.menit = 0) then begin
      tarif:=2000+((durasi.jam-1)*1000);
    end else begin
      tarif:=2000+(durasi.jam*1000);
    end;
  end;

begin
  clrscr;
  tarif:=0;
  write('Masukkan jam masuk: ');readln(TM.jam);
  write('Masukkan menit masuk: ');readln(TM.menit);
  write('Masukkan jam keluar: ');readln(TK.jam);
  write('Masukkan menit keluar: ');readln(TK.menit);
  hitungTarif(hitungDurasi(TM,TK),tarif);
  write('Tarif parkir: Rp.',tarif);
  readln;
end.
