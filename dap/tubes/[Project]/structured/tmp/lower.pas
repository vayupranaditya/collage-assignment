program lowercs;
uses crt;

var
	text:string;

function lower(text:string):string;
{IS. terdefinisi string text yang akan diubah menjadi huruf kecil
 FS. mengubah string text menjadi huruf kecil}
var
	i,tlength:integer;
	elmnt,res:string;
begin
	res:='';
	tlength:=length(text);
	for i:=1 to tlength do begin
		case text[i] of
			'A':elmnt:='a';
			'B':elmnt:='b';
			'C':elmnt:='c';
			'D':elmnt:='d';
			'E':elmnt:='e';
			'F':elmnt:='f';
			'G':elmnt:='g';
			'H':elmnt:='h';
			'I':elmnt:='i';
			'J':elmnt:='j';
			'K':elmnt:='k';
			'L':elmnt:='l';
			'M':elmnt:='m';
			'N':elmnt:='n';
			'O':elmnt:='o';
			'P':elmnt:='p';
			'Q':elmnt:='q';
			'R':elmnt:='r';
			'S':elmnt:='s';
			'T':elmnt:='t';
			'U':elmnt:='u';
			'V':elmnt:='v';
			'W':elmnt:='w';
			'X':elmnt:='x';
			'Y':elmnt:='y';
			'Z':elmnt:='z';
			else elmnt:=text[i];
		end;
		res:=res+elmnt;
	end;
	lower:=res;
end;

begin
	clrscr;
	write('text: ');readln(text);
	clrscr;
	if (lowerCase(text) = lower(text)) then begin
		writeln('Works!');
	end else begin
		writeln('Failed :(');
	end;
	readln;
end.