program harga_rumah;
uses crt;
const
  num = 10;
type
  house = record
    lokasi, bencana, kriminalitas:integer;
    properti:longint;
  end;
  decrement = record
    bencana, kriminalitas:real;
  end;
var
  houses:array[1..num] of house;
  pengurangan:decrement;
  harga_lok,pengurangan_tot:longint;
  total:real;
begin
  clrscr;
  write('indeks lokasi (1:tengah kota-10:pelosok):');readln(houses[1].lokasi);
  write('indeks kriminalitas (1:aman-10:bahaya):');readln(houses[1].kriminalitas);
  write('indeks kerawanan bencana (1:aman)-10:bahaya):');readln(houses[1].bencana);
  case houses[1].lokasi of
    1:harga_lok:=10000000;
    2:harga_lok:=9000000;
    3:harga_lok:=8000000;
    4:harga_lok:=6000000;
    5:harga_lok:=4000000;
    6:harga_lok:=2000000;
    7:harga_lok:=1000000;
    8:harga_lok:=750000;
    9:harga_lok:=500000;
    10:harga_lok:=250000;
  end;
  pengurangan.bencana:=(houses[1].bencana/100)*harga_lok;
  pengurangan.kriminalitas:=(houses[1].kriminalitas/100)*harga_lok;
  pengurangan_tot:=pengurangan.kriminalitas+pengurangan.bencana;
  total:=harga_lok-pengurangan_total;
  writeln('Harga bangunan: ',total:0:2);
  readln;
end.
