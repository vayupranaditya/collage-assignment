program lihat_angsuran;
uses crt;
var
  awal,dp:longint;
  durasi,tahun:integer;
  pokok,bunga,bunga_bayar,bayar,sisa:real;
begin
  clrscr;
  write('Harga Awal: ');readln(awal);
  write('Durasi Kredit(tahun): ');readln(durasi);
  write('Uang Muka: ');readln(dp);
  sisa:=awal-dp;
  pokok:=sisa/durasi;
  for tahun:=1 to durasi do begin
    if (tahun <= 5) then begin
      bunga:=0.05;
    end else if (bunga>0.01) then begin
      bunga:=bunga-0.01;
    end;
    bunga_bayar:=bunga*pokok;
    bayar:=pokok+bunga_bayar;
    sisa:=sisa-pokok;
    writeln('tahun ke-',tahun,' bayar ',bayar:0:2);
    writeln('sisa: ',sisa:0:2);
  end;
  readln;
end.


payment.balance:=arrhouseDataView[index].price-payment.dp;
payment.pay:=payment.balance/payment.duration;
for year:=1 to payment.duration do begin
	if (year <= 5) then begin
		payment.interest:=0.05;
	end else begin
		if (payment.interest >= 0.01) then begin
			payment.interest:=payment.interest-0.01;
		end else begin
			payment.interest:=0;
		end;
	end;
	arrPayment[year].curPay:=
	