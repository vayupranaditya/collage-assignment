program FileHandling;
uses crt,sysutils;

type
	strarr = array[1..4] of string;
var
	arrfile: textfile; //of  strarr;
	arrstr1,arrstr2:array[1..4] of string;
	i:integer;
procedure isiFile;
begin
	for i:=1 to 4 do begin
		readln(arrstr1[i]);
	end;
	writeln('OK!');
	assign(arrfile,'data.dat');
		if (FileExists('data.dat')) then begin
			append(arrfile);
		end else begin
			rewrite(arrfile);
		end;
		//seekEOF(arrfile);
		for i:=1 to 4 do begin
			WriteLn(arrfile,arrstr1[i]);
		end;
	close(arrfile);
	writeln('Done!');
	readln;
end;

procedure liatFile;
begin
	assign(arrfile,'data.dat');
		reset(arrfile);
		i:=0;
		while (not(eof(arrfile))) do begin
			i:=i+1;
			readln(arrfile,arrstr2[i]);
			writeln('Kata ke-',i,': ',arrstr2[i]);
		end;
	close(arrfile);
	writeln;
	writeln('Done!');
	readln;
end;

begin
	isiFile;
	liatFile;
end.