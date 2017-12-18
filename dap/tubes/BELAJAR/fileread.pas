program fileread;
uses crt;
var
	f_arr:textfile;
	temp:string;
begin
	assign(f_arr,'data.dat');
		reset(f_arr);
		while (not(eof(f_arr))) do begin
			readln(f_arr,temp);
			writeln(temp);
		end;
	close(f_arr);
	readln;
end.