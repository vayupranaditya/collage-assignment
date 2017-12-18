program userAccount;
uses crt;
var
  action:integer;
  key:char;
begin
  repeat
    clrscr;
    writeln;
    writeln('+------------------------------------+');
	writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
    writeln('|   Please sign in to your account   |');
    writeln('|   or sign up if you dont have one  |');
    writeln('| Press 1 to sign in, or 2 to sign up|');
    writeln('+------------------------------------+');
    writeln;
    write('Action:');readln(action);
  until ((action = 1) OR (action = 2));
  //return action
end.
