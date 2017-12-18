program latihan_file;
uses crt;
const
	filename='c_file.txt';
type
	data = record
		nama:string;
		umur:integer;
	end;
	arrdata = array[1..2] of data;
var
	vfile:file of data;

	procedure tulis;
	var
		s:arrdata;
	begin
		assign(vfile,filename);
		rewrite(vfile);
		write('1.nama: ');readln(s[1].nama);
		write('1.umur: ');readln(s[1].umur);
		write(vfile,s[2]);
		write('2.nama: ');readln(s[2].nama);
		write('2.umur: ');readln(s[2].umur);
		write(vfile,s[1]);
		{while s<>' ' do begin
			write(vfile,s);
			write('input text: ');readln(s);
		end;
		}
		close(vfile);
	end;

	procedure baca;
	var
		s:arrdata;
	begin
		assign(vfile,filename);
		reset(vfile);
		while not EOF(vfile) do begin
			read(vfile,s[1]);
			writeln('terbaca: ',s[1].nama);
			readln;
		end;
		close(vfile);
	end;

begin
	tulis();
	clrscr;
	baca();
	readln;
end.

