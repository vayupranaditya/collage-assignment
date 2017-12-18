program Minggu10;
uses crt;
var
	kalimat1 , kalimat2, hasil1 , hasil2 : String;
	hasil3: boolean;
	i,j,teksLength,teksLength2:integer;

function isVowel(X: char): boolean;
{IS. terdefinisi suatu karakter X
 FS. mengembalikkan TRUE jika X adalah vokal dan FALSE jika sebaliknya}
begin
	isVowel:=((X = 'a') OR (X = 'e') OR (X = 'i') OR (X = 'o') OR (X = 'u'));
end;

function reverseText(teks: String): String;
{IS. terdefinisi suatu string teks
FS. mengembalikkan teks dari karakter terakhir ke awal
Misalnya: teks = 'Makan Nasi' dirubah menjadi 'isaN nakaM'}
var
	strTemp:string;
begin
	teksLength:=length(teks);
	strTemp:='';
	for i:=1 to teksLength do begin
		strTemp:=strTemp+teks[teksLength-i+1];
	end;
	reverseText:=strTemp;
end;

function countVowel(teks: String): integer;
{IS. terdefinisi suatu string teks
 FS. mengembalikkan banyaknya huruf vokal dalam teks tersebut }
var
	num:integer;
begin
	teksLength:=length(teks);
	num:=0;
	for i:=1 to teksLength do begin
		if (isVowel(teks[i])) then begin
			num:=num+1;
		end;
	end;
	countVowel:=num;
end;

procedure divideTeks(teks: String; var vokalTeks:string; var konsonanTeks: String);
{IS. terdefinisi suatu string teks
 FS. membagi teks menjadi teks yang berisi vokal dan konsonan
 Misalnya: teks = 'ABCDEFG' maka vokalTeks = 'AE' dan konsonanTeks = 'BCDFG'}
begin
	teksLength:=length(teks);
	vokalTeks:='';
	konsonanTeks:='';
	for i:=1 to teksLength do begin
		if (isVowel(teks[i])) then begin
			vokalTeks:=vokalTeks+teks[i];
		end else begin
			konsonanTeks:=konsonanTeks+teks[i];
		end;
	end;
end;
 
 procedure checkKata(teks1:string; teks2: String; var status: boolean);
{IS. terdefinisi suatu string teks1 dan teks2
 FS. mancari apakah SEMUA karakter yang ada di teks2 ADA DIDALAM teks1, jika iya maka status bernilai TRUE dan FALSE jika sebaliknya}
begin
	teksLength:=length(teks1);
	teksLength2:=length(teks2);
	status:=true;
	i:=0;
	while (status AND (i < teksLength2)) do begin
		i:=i+1;
		status:=false;
		j:=0;
		while (not(status) AND (j<teksLength)) do begin
			j:=j+1;
			if (teks2[i] = teks1[j]) then begin
				status:=true;
			end;
		end;
	end;
end;

Begin
	clrscr;
	kalimat1 := 'put in the black box';
	kalimat2 := 'kotak';
	writeln('hasil reverse kalimat2: ', reverseText(kalimat2));
	writeln('jumlah vokal kalimat1: ', countVowel(kalimat1 ));
	divideTeks(kalimat1 , hasil1 , hasil2);
	checkKata(kalimat1 , kalimat2, hasil3);
	writeln('teks vokal: ', hasil1 );
	writeln('teks konsonan: ', hasil2);
	writeln('hasil checkKata adalah: ', hasil3);
	readln;
End.