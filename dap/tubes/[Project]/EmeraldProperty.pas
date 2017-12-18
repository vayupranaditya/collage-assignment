program EmeraldProperty;
uses crt,sysutils;

const
	fName_UserData = 'users.dat';

type
	t_userData = record
		fullName,password,accType:string;
	end;
	t_houseData = record
		alamat:string;
		lokasi,bencana,kejahatan:integer;
		harga:longint;
	end;

var
	f_UserData:textfile;
	userData:t_userData;
	houseData:t_houseData;

function encrypt(text:string):string;
{IS. terdefinisi string text yang akan dienkripsi
 FS. mengembalikan hasil enkripsi dari text}
var
	elmnt,encted:string;
	i,tlength:integer;
begin
	encted:='';
	tlength:=length(text);
	for i:=1 to tlength do begin
		case text[i] of
			'a':elmnt:='nGN';
			'b':elmnt:='GRE';
			'c':elmnt:='VtT';
			'd':elmnt:='PUk';
			'e':elmnt:='JvY';
			'f':elmnt:='WIs';
			'g':elmnt:='FXw';
			'h':elmnt:='WYz';
			'i':elmnt:='tBO';
			'j':elmnt:='Etd';
			'k':elmnt:='qnn';
			'l':elmnt:='GPe';
			'm':elmnt:='ExE';
			'n':elmnt:='Icc';
			'o':elmnt:='QZD';
			'p':elmnt:='CSG';
			'q':elmnt:='oaF';
			'r':elmnt:='xbj';
			's':elmnt:='HTO';
			't':elmnt:='PcH';
			'u':elmnt:='Wdy';
			'v':elmnt:='PFg';
			'w':elmnt:='PIl';
			'x':elmnt:='JrP';
			'y':elmnt:='APr';
			'z':elmnt:='UyR';
			' ':elmnt:='OSB';
			'A':elmnt:='NBY';
			'B':elmnt:='LRR';
			'C':elmnt:='GKP';
			'D':elmnt:='hZH';
			'E':elmnt:='PYJ';
			'F':elmnt:='IJf';
			'G':elmnt:='LDG';
			'H':elmnt:='SbE';
			'I':elmnt:='CZL';
			'J':elmnt:='bah';
			'K':elmnt:='XGN';
			'L':elmnt:='lCJ';
			'M':elmnt:='OuM';
			'N':elmnt:='PTl';
			'O':elmnt:='TdW';
			'P':elmnt:='Ous';
			'Q':elmnt:='qTe';
			'R':elmnt:='Sen';
			'S':elmnt:='YvN';
			'T':elmnt:='cQI';
			'U':elmnt:='Lbt';
			'V':elmnt:='Evg';
			'W':elmnt:='Vtk';
			'X':elmnt:='VBG';
			'Y':elmnt:='JHJ';
			'Z':elmnt:='ZNK';
			'1':elmnt:='bCR';
			'2':elmnt:='IlR';
			'3':elmnt:='JVR';
			'4':elmnt:='TYA';
			'5':elmnt:='FqA';
			'6':elmnt:='CUa';
			'7':elmnt:='PBx';
			'8':elmnt:='xcN';
			'9':elmnt:='fVP';
			'0':elmnt:='Ism';
			'!':elmnt:='PWd';
			'@':elmnt:='DfI';
			'#':elmnt:='HmZ';
			'$':elmnt:='XBU';
			'%':elmnt:='WKR';
			'^':elmnt:='xMb';
			'&':elmnt:='BjA';
			'*':elmnt:='TbD';
			'(':elmnt:='Zvs';
			')':elmnt:='YCJ';
			'~':elmnt:='eGV';
			'`':elmnt:='HMG';
			'-':elmnt:='ZaO';
			'_':elmnt:='Crt';
			'=':elmnt:='Cbh';
			'+':elmnt:='yuy';
			'[':elmnt:='MdN';
			'\':elmnt:='XqX';
			'|':elmnt:='SYr';
			';':elmnt:='HEV';
			':':elmnt:='VZp';
			'"':elmnt:='CWB';
			',':elmnt:='fxD';
			'<':elmnt:='CDI';
			'.':elmnt:='eJL';
			'>':elmnt:='TXT';
			'/':elmnt:='MHS';
			'?':elmnt:='ARE';
		end;
		encted:=encted+elmnt;
	end;
	encrypt:=encted;
end;

function decrypt(encted:string):string;
{IS. terdefinisi string encted yang akan didekripsi
 FS. mengembalikan hasil dekripsi dari encted}
var
	res,text,pln:string;
	tlength,i:integer;
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
		end;
		res:=res+pln
	end;
	decrypt:=res;
end;

function addHouseView():t_houseData;
{IS. -
 FS. Menampilkan halaman Tambahkan rumah, mengembalikan user action}
var
	houseData:t_houseData;
begin
	//VIEW
	repeat
		clrscr;
		writeln('You are at: Tambah Rumah');
		writeln;
		writeln('Data Rumah:');
		write('Alamat Rumah: ');readln(houseData.alamat);
		write('Indeks Lokasi (1=Terpencil - 5=Pusat Kota): ');readln(houseData.lokasi);
		write('Indeks Kerawanan Bencana (1=Aman - 5=Rawan Bencana: ');readln(houseData.bencana);
		write('Indeks Kerawanan Kejahatan (1=Aman - 5=Rawan Kejahatan): ');readln(houseData.kejahatan);
	until ((houseData.alamat <> '') AND 
		((houseData.lokasi >= 1) AND (houseData.lokasi<=5)) AND 
		((houseData.bencana >= 1) AND (houseData.bencana<=5)) AND 
		((houseData.kejahatan >= 1) AND (houseData.kejahatan<=5)));
	addHouseView:=houseData;
end;

procedure addHouse(house:t_houseData);
{IS. terdefinisi variabel house yang berisi data mengenai rumah yang akan ditambahkan
 FS. menambahkan rumah ke dalam data}
begin
	
end;

function adminDashboardView():integer;
{IS. -
 FS. Mengembalikan nilai aksi yang dilakukan admin}
var
	action:integer;
begin
	repeat
		clrscr;
		writeln('You are at: Admin Dashboard');
		writeln;
		writeln('Opsi:');
		writeln('1. Tambahkan Rumah');
		writeln('2. Lihat Rumah');
		writeln('3. Perbarui Informasi Rumah');
		writeln('4. Hapus Rumah');
		writeln;
		write('Pilih(1/2/3/4): ');readln(action);
	until ((action >= 1) AND (action <= 4));
	adminDashboardView:=action;
end;
 
procedure adminDashboard;
{IS. -
 FS. Menampilkan menu yang dapat dipilih oleh admin}
var
	action:integer;
begin
	action:=adminDashboardView();
	//CASE IS NOT READY
	(*
	case action of
		1:addHouse;
		{
		2:seeHouses;
		3:UpdateHouse;
		4:deleteHouse;
		}
	end;
	*)
end;

function signUpView():t_userData;
{IS. -
 FS. Mengembalikan data dari user yang mendaftar}
var
	retypePwd:string;
	check1,check2:boolean;
begin
	check1:=true;
	check2:=true;
	userData.fullName:='';
	userData.accType:='';
	//VIEW
	repeat
		clrscr;
		writeln('You are at: User Sign Up');
		writeln('+------------------------------------+');
		writeln('|                                    |');
		writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
		writeln('|             User Sign Up           |');
		writeln('|                                    |');
		writeln('+------------------------------------+');
		writeln;
		if (check1) then begin
			writeln;
		end else begin
			writeln('Password Missmatch');
		end;
		if (check2) then begin
			writeln;
		end else begin
			writeln('Type Missmatch');
		end;
		if (userData.fullName = '') then begin
			write  ('Full Name                    : ');readln(userData.fullName);
		end else begin
			writeln('Full Name                    : ',userData.fullName);
		end;
		if ((check2) AND (userData.accType <> '')) then begin
			writeln('Account Type [Admin/Customer]: ',userData.accType);
		end else begin
			write  ('Account Type [Admin/Customer]: ');readln(userData.accType);
		end;
		write      ('Password                     : ');readln(userData.password);
		write      ('Retype password              : ');readln(retypePwd);
		check1:=userData.password=retypePwd;
		if ((userData.accType = 'admin') OR (userData.accType = 'Admin') OR (userData.accType = 'ADMIN')) then begin
			userData.accType:= 'admin';
		end else if ((userData.accType = 'customer') OR (userData.accType = 'Customer') OR (userData.accType = 'CUSTOMER')) then begin
			userData.accType:= 'customer';
		end else begin
			check2:=false;
		end;
	until (check1 AND check2);
	signUpView:=userData;
end;

procedure signUp;
begin
	assign(f_UserData,fName_UserData);
		if (fileexists(fName_UserData)) then begin
			append(f_UserData);
		end else begin
			rewrite(f_UserData);
		end;
		userData.fullName:=encrypt(userData.fullName);
		userData.password:=encrypt(userData.password);
		userData.accType:=encrypt(userData.accType);
		writeln(f_UserData,userData.fullName);
		writeln(f_UserData,userData.password);
		writeln(f_UserData,userData.accType);
	close(f_UserData);
	
	//CONTROLLER
	if (userData.accType = encrypt('admin')) then begin
		adminDashboard;
	end else begin
		//USER DASHBOARD
	end;
end;	

(*
procedure signInModel(userData:t_userData);

		//CONTROLLER,MODEL
		rowNum:=0;
		found:=false;
		loggedIn:=false;
		userData.fullName:=encrypt(userData.fullName);
		userData.password:=encrypt(userData.password);
		assign(f_UserData,fName_UserData);
			reset(f_UserData);
			while ((not(eof(f_UserData))) AND (not(found))) do begin
				rowNum:=rowNum+1;
				if ((rowNum mod 3) = 1) then begin
					readln(f_UserData,strTemp);
					if (userData.fullName = strTemp) then begin
						found:=true;
						readln(f_UserData,strTemp);
						if (strTemp = userData.password) then begin
							loggedIn:=true;
							readln(f_UserData,strTemp);
							strTemp:=decrypt(strTemp);
							if (strTemp = 'admin') then begin
								//ADMIN DASHBOARD
								adminDashboard;
							end else begin
								//CUSTOMER DASHBOARD
								write('customer');
							end;
						end else begin
							status:='Invalid password';
						end;
					end;
				end else begin
					status:='User Not Found';
				end;
			end;
		close(f_UserData);
	until (loggedIn);
	readln;
end;
*)

function signInView(status:string):t_userData;
{IS. terdefinisi string status yang berisi informasi login user
 FS. Mengembalikan nilai data user yang akan masuk}
var
	userData:t_userData;
begin
	clrscr;
	writeln('You are at: User Sign In');
	writeln('+------------------------------------+');
	writeln('|                                    |');
	writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
	writeln('|             User Sign In           |');
	writeln('|                                    |');
	writeln('+------------------------------------+');
	writeln;
	writeln(status);
	write('Full Name       : ');readln(userData.fullName);
	write('Password        : ');readln(userData.password);
	signInView:=userData;
end;
	
function userAccountView():integer;
{IS. -
 FS. mengarahkan user ke bagian sign in ataupun sign out}
var
	action:integer;
begin
	clrscr;
	writeln;
	writeln('+------------------------------------+');
	writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
	writeln('|   Please sign in to your account   |');
	writeln('|   or sign up if you dont have one  |');
	writeln('| Press 1 to sign in, or 2 to sign up|');
	writeln('+------------------------------------+');
	writeln;
	write('Action: ');readln(action);
	userAccountView:=action;
end;

procedure welcomePage;
{IS. -
 FS. Menampilkan halaman pembuka}
begin
	//VIEW
	clrscr;
	writeln;//blank row for application location
	writeln('+------------------------------------+');
	writeln('|                                    |');
	writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
	writeln('|                                    |');
	writeln('|                                    |');
	writeln('+------------------------------------+');
	writeln;
	writeln;
	write('Press enter to continue...');readln;
end;

procedure userAccount(action:integer);
{IS. terdefinisi integer action
 FS. membawa user ke procedure sesuai pilihan user}
	//CONTROLLER
	if (action = 1) then begin
		//SIGN IN
		SignIn;
	end else begin
		//SIGN UP
		SignUp;
	end;
end;

procedure main();
{IS. -
 FS. struktur program utama}
begin
	WelcomePage;
	UserAccount;
	//UserDashboard;
end;


begin
	main();
end.