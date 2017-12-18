PROGRAM DemoAplikasiKuisOnline;
USES crt,sysutils;

CONST
	C_FNAME = 'Question.dat';
	C_FUSER = 'User.dat';
TYPE
	option = record
		a : string;
		b : string;
		c : string;
		d : string;
	end;
	question = record
		id		: integer;
		soal 	: string;
		kategori: char;
		level	: char;
		opsi 	: option;
		jawaban : char;
		nCorrect: integer;
		nWrong 	: integer;
		rating 	: integer;
	end;
	users = record
		id 			: integer;
		nama 		: string;
		gender		: char;
		alamat		: string;
		pekerjaan	: string;
		score		: real;
	end;
	
	Procedure boot;
	begin
		clrscr;
		writeln('==============================');
		writeln('=       SELAMAT DATANG       =');
		writeln('=     DEMO APLIKASI KUIS     =');
		writeln('=           ONLINE           =');
		writeln('==============================');
		  write('        press enter...');
		readln;
	end;

	procedure buatSoal();
	var
		pil:char;
	begin
		clrscr;
		writeln('* Menu >> Soal >> Buat Soal');		
		writeln('============================');
		writeln('= 1.....             =');
		writeln('============================');
		write('= Pilihan: ');readln(pil);
	end;
	
	procedure lihatSoal();
	var
		pil:char;
	begin
		clrscr;
		writeln('* Menu >> Soal >> Lihat Soal');		
		writeln('============================');
		writeln('= 1. List soal             =');
		writeln('= 2. Soal termudah         =');
		writeln('= 3. Soal tersulit         =');
		writeln('= 4. Grafik Soal           =');
		writeln('= 5. Kembali               =');
		writeln('============================');
		write('= Pilihan: ');readln(pil);
	end;

	procedure lihatUser();
	var
		pil:char;
	begin
		clrscr;
		writeln('* Menu >> Soal >> Lihat User');
		writeln('============================');
		writeln('= 1. User                  =');
		writeln('= 2. Ranking user          =');
		writeln('= 3. Top 3                 =');
		writeln('= 4. Grafik user           =');
		writeln('= 5. Reset user            =');
		writeln('= 6. Kembali               =');
		writeln('============================');
		write('= Pilihan: ');readln(pil);
	end;

	Procedure pilMenuSoal(pil:char);
	begin
		case pil of
			'1' : buatSoal();
			'2' : lihatSoal();
			'3' : lihatUser();
		end;
	end;	

	Procedure menuSoal();
	var
		pil:char;
	begin
		repeat
			clrscr;
			writeln('* Menu >> Soal');
			writeln('============================');
			writeln('= 1. Buat Soal             =');
			writeln('= 2. Lihat Soal            =');
			writeln('= 3. Lihat User            =');
			writeln('= 4. Kembali               =');
			writeln('============================');
			write('= Pilihan: ');readln(pil);
		until (pil='1') or (pil='2') or (pil='3') or (pil='4');
		if pil<> '4' then begin
			pilMenuSoal(pil);
			menuSoal();
		end;
	end;

	Procedure createUser();
	begin
		clrscr;
		writeln(' Menu Registrasi ');
		readln;
	end;
	
	Procedure menuKuis();
	begin
		clrscr;
		writeln(' Menu Kuis ');
		readln;
	end;

	Procedure pilMenuUtama(pil:char);
	begin
		case pil of
			'1' : menuSoal();
			'2' : createUser();
		end;
	end;

	Procedure menuUtama();
	var
		pil:char;
	begin
		repeat
			clrscr;
			writeln('* Menu                     =');
			writeln('============================');
			writeln('= 1. Soal                  =');
			writeln('= 2. Kuis                  =');
			writeln('= 3. Exit                  =');
			writeln('============================');
			write('= Pilihan: ');readln(pil);
		until (pil='1') or (pil='2') or (pil ='3');
		if pil<> '3' then begin
			pilMenuUtama(pil);
			menuUtama();
		end;
	end;

BEGIN
	boot();
	menuUtama();
END.
