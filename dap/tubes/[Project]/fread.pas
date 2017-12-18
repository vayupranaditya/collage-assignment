program fileread;
uses crt,sysutils;
var
	f_arr:textfile;
	fname,temp:string;
	i:integer;
procedure readfile(fname:string);
begin
	i:=0;
	assign(f_arr,fname);
		reset(f_arr);
		while (not(eof(f_arr))) do begin
			i:=i+1;
			readln(f_arr,temp);
			writeln(i,'.',temp);
		end;
	close(f_arr);
	readln;
end;

begin
	repeat
		write('File name: ');readln(fname);
		if (fileexists(fname)) then begin
			writeln('Content:');
			readfile(fname);
		end else begin
			writeln('File ',fname,' is not found.');
			write('Press enter to continue..');readln;
			clrscr;
		end;
	until (fileexists(fname));
end.