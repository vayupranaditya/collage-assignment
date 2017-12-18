program fileread;
uses crt,sysutils;
var
	f_arr:textfile;
	fname,temp:string;
	j,i:integer;

function decrypt(encted:string):string;
var
	res,text,pln:string;
	tlength:integer;
begin
	res:='';
	tlength:=length(encted);
	for i:=0 to (tlength div 3)-1 do begin
		text:=encted[i*3+1]+encted[i*3+2]+encted[i*3+3];
		case text of
			'nGN':pln:='a';
			'GRE':pln:='b';
			'VtT':pln:='c';
			'PUk':pln:='d';
			'JvY':pln:='e';
			'WIs':pln:='f';
			'FXw':pln:='g';
			'WYz':pln:='h';
			'tBO':pln:='i';
			'Etd':pln:='j';
			'qnn':pln:='k';
			'GPe':pln:='l';
			'ExE':pln:='m';
			'Icc':pln:='n';
			'QZD':pln:='o';
			'CSG':pln:='p';
			'oaF':pln:='q';
			'xbj':pln:='r';
			'HTO':pln:='s';
			'PcH':pln:='t';
			'Wdy':pln:='u';
			'PFg':pln:='v';
			'PIl':pln:='w';
			'JrP':pln:='x';
			'APr':pln:='y';
			'UyR':pln:='z';
			'OSB':pln:=' ';
			'NBY':pln:='A';
			'LRR':pln:='B';
			'GKP':pln:='C';
			'hZH':pln:='D';
			'PYJ':pln:='E';
			'IJf':pln:='F';
			'LDG':pln:='G';
			'SbE':pln:='H';
			'CZL':pln:='I';
			'bah':pln:='J';
			'XGN':pln:='K';
			'lCJ':pln:='L';
			'OuM':pln:='M';
			'PTl':pln:='N';
			'TdW':pln:='O';
			'Ous':pln:='P';
			'qTe':pln:='Q';
			'Sen':pln:='R';
			'YvN':pln:='S';
			'cQI':pln:='T';
			'Lbt':pln:='U';
			'Evg':pln:='V';
			'Vtk':pln:='W';
			'VBG':pln:='X';
			'JHJ':pln:='Y';
			'ZNK':pln:='Z';
			'bCR':pln:='1';
			'IlR':pln:='2';
			'JVR':pln:='3';
			'TYA':pln:='4';
			'FqA':pln:='5';
			'CUa':pln:='6';
			'PBx':pln:='7';
			'xcN':pln:='8';
			'fVP':pln:='9';
			'Ism':pln:='0';
			'PWd':pln:='!';
			'DfI':pln:='@';
			'HmZ':pln:='#';
			'XBU':pln:='$';
			'WKR':pln:='%';
			'xMb':pln:='^';
			'BjA':pln:='&';
			'TbD':pln:='*';
			'Zvs':pln:='(';
			'YCJ':pln:=')';
			'eGV':pln:='~';
			'HMG':pln:='`';
			'ZaO':pln:='-';
			'Crt':pln:='_';
			'Cbh':pln:='=';
			'yuy':pln:='+';
			'MdN':pln:='[';
			'jsk':pln:='{';
			'GRJ':pln:=']';
			'DDV':pln:='}';
			'XqX':pln:='\';
			'SYr':pln:='|';
			'HEV':pln:=';';
			'VZp':pln:=':';
			'lCD':pln:='';
			'CWB':pln:='"';
			'fxD':pln:=',';
			'CDI':pln:='<';
			'eJL':pln:='.';
			'TXT':pln:='>';
			'MHS':pln:='/';
			'ARE':pln:='?';
			else pln:=text;
		end;
		res:=res+pln
	end;
	decrypt:=res;
end;	

procedure readfile(fname:string);
begin
	j:=0;
	assign(f_arr,fname);
		reset(f_arr);
		while (not(eof(f_arr))) do begin
			j:=j+1;
			readln(f_arr,temp);
			temp:=decrypt(temp);
			writeln(j,'.',temp);
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