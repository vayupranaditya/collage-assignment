program project1;
uses crt;
type
	userData = record
		fullName,password:string;
	end;
var
	user:userData;
	retypePwd:string;
	checked:boolean;
begin
	checked:=true;
	repeat
		clrscr;
		writeln;
		writeln('+------------------------------------+');
		writeln('|                                    |');
		writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
		writeln('|             User Sign Up           |');
		writeln('|                                    |');
		writeln('+------------------------------------+');
		writeln;
		if (checked) then begin
			writeln;
		end else begin
			writeln('Password Missmatch');
		end;
		write('Full Name       : ');readln(user.fullName);
		write('Password        : ');readln(user.password);
		write('Retype password : ');readln(retypePwd);
		checked:=user.password=retypePwd;
	until (checked=true);
	//INSERT TO DATABASE
	{
	writeln('User Name: ',user.fullName);
	writeln('User Password: ',user.password);
	}
	readln;
end.
