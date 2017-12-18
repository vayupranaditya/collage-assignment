program testProcs;
uses crt, sysutils;

const
	fName_userData = 'users.dat';
	fName_houseData = 'houses.dat';
	basicPrice = 10000000;

type
	t_userData = record
		fullName,password,accType:string;
		//ORDER:
		//1. full name
		//2. password
		//3. accType
	end;
	t_houseData = record
		houseId,location,disaster,crime,availibility:integer;
		address:string;
		price:longint;
		//ORDER:
		//1. houseId
		//2. address
		//3. availibility
		//4. price
		//5. location
		//6. disaster
		//7. crime
	end;

var
	f_userData:textfile;
	f_houseData:textfile;
	userData,signedInUser:t_userData;
	houseData:t_houseData;
	i,status:integer;

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
	
function encrypt(text:string):string;
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
		end;
		res:=res+pln
	end;
	decrypt:=res;
end;	

	function findUserModel(userData:t_userData):integer;
	{IS. terdefinisi userData yang berisi data user yang akan dicari
	 FS. mengembalikan nilai indeks user yang dicari. 0 jika tidak ditemukan}
	var
		rowNum,index:integer;
		readUser:t_userData;
	begin
		assign(f_userData, fName_userData);
		index:=0;
		if (fileexists(fName_userData)) then begin
			reset(f_userData);
			rowNum:=1;
			readln(f_userData,readUser.fullName);
			while ((not(EOF(f_userData))) AND (lower(userData.fullName) <> lower(readUser.fullName))) do begin
				readln(f_userData);
				readln(f_userData);
				rowNum:=rowNum+3;
				readln(f_userData,readUser.fullName);
			end;
			if (lower(userData.fullName) = lower(readUser.fullName)) then begin
				index:=rowNum;
			end;
			//close(f_userData);
		end;
		findUserModel:=index;
	end;
	
	function signUpModel(userData:t_userData):boolean;
	{IS. terdefinisi userData yang berisi data yang akan ditambahkan
	 Mengembalikan True jika sign up berhasil, False jika gagal (karena data sudah ada)}
	begin
		assign(f_userData,fName_userData);
		if (fileexists(fName_userData)) then begin
			userData.fullName:=encrypt(userData.fullName);
			userData.password:=encrypt(userData.password);
			userData.accType:=encrypt(userData.accType);
			if (findUserModel(userData) = 0) then begin
				append(f_userData);
				writeln(f_userData,userData.fullName);
				writeln(f_userData,userData.password);
				writeln(f_userData,userData.accType);
				signUpModel:=True;
			end else begin
				signUpModel:=False;
			end;
		end else begin
			rewrite(f_userData);
			writeln(f_userData,userData.fullName);
			writeln(f_userData,userData.password);
			writeln(f_userData,userData.accType);
			signUpModel:=True;
		end;
		close(f_userData);
	end;
	
	procedure signInModel(userData:t_userData; var signInStatus:integer; var signedInUser:t_userData);
	{IS. terdefinisi userData yang akan masuk
	 FS. Melakukan sign in dan signInStatus bernila 0 jika sign in berhasil, 1 jika gagal karena data tidak ada, 2 jika gagal karena password salah, dan data dari user yang masuk jika berhasil masuk}
	var
		userIdx,i:integer;
		tmpUserData:t_userData;
	begin
		assign(f_userData,fName_userData);
		if (fileexists(fName_userData)) then begin
			userData.fullName:=encrypt(userData.fullName);
			userData.password:=encrypt(userData.password);
			userData.accType:=encrypt(userData.accType);
			userIdx:=findUserModel(userData);
			if (userIdx <> 0) then begin
				reset(f_userData);
				for i:=1 to userIdx do begin
					readln(f_userData);
				end;
				readln(f_userData,tmpUserData.password);
				if (userData.password = tmpUserData.password) then begin
					signInStatus:=0;
					readln(f_userData,tmpUserData.accType);
					signedInUser.fullName:=decrypt(userData.fullName);
					signedInUser.accType:=decrypt(tmpUserData.accType);
				end else begin
					signInStatus:=2;
				end;
			end else begin
				signInStatus:=1;
			end;
		end else begin
			signInStatus:=1;
		end;
		close(f_userData);
	end;
	
	function findHousebyAddressModel(houseData:t_houseData):integer;
	{IS. terdefinisi houseData yang berisi data rumah yang akan dicari
	 FS. mengembalikan nilai indeks rumah yang dicari. 0 jika tidak ditemukan. Metode yang digunakan adalah sequence search}
	var
		rowNum,index:integer;
		readHouse:t_houseData;
	begin
		assign(f_houseData, fName_houseData);
		index:=0;
		if (fileexists(fName_houseData)) then begin
			reset(f_houseData);
			rowNum:=1;
			readln(f_houseData);
			readln(f_houseData,readHouse.address);
			readHouse.address:=decrypt(readHouse.address);
			while ((not(EOF(f_houseData))) AND (lower(houseData.address) <> lower(readHouse.address))) do begin
				readln(f_houseData);
				readln(f_houseData);
				readln(f_houseData);
				readln(f_houseData);
				readln(f_houseData);
				readln(f_houseData);
				rowNum:=rowNum+1;
				readln(f_houseData,readHouse.address);
			end;
			if (houseData.address = readHouse.address) then begin
				index:=rowNum;
			end;
			close(f_houseData);
		end;
		findHousebyAddressModel:=index;
	end;
	
	function getHouseNumber():integer;
	{IS. -
	 FS. mengembalikan jumlah dari rumah yang ada di data}
	var
		rows:integer;
	begin
		assign(f_houseData,fName_houseData);
		reset(f_houseData);
		rows:=0;
		while (not(eof(f_houseData))) do begin
			readln(f_houseData);
			rows:=rows+1;
		end;
		close(f_houseData);
		getHouseNumber:=rows;
	end;
	
	function getHousePrice(houseData:t_houseData):longint;
	{IS. terdefinisi data rumah yang akan dicari harganya
	 FS. mengembalikan harga rumah}
	var
		housePrice:longint;
	begin
		housePrice:=basicPrice;
		housePrice:=housePrice-(housePrice*(houseData.location-1) div 10);
		housePrice:=housePrice-(housePrice*(houseData.disaster-1) div 20);
		housePrice:=housePrice-(housePrice*(houseData.crime-1) div 40);
		getHousePrice:=housePrice;
	end;
	
	function addHouseModel(houseData:t_houseData):integer; 
	{IS. terdefinisi houseData yang berisi data yang akan ditambahkan
	 FS. Melakukan menambahkan rumah dan mengembalikan True jika penambahan berhasil, False jika gagal (karena data sudah ada)}
	var
		numHouses,lastID:integer;
	begin
		assign(f_houseData,fName_houseData);
		if (fileexists(fName_houseData)) then begin
			if (findHousebyAddressModel(houseData) = 0) then begin
				numHouses:=getHouseNumber();
				append(f_houseData);
				lastID:=numHouses div 7;
				houseData.price:=getHousePrice(houseData);
				houseData.houseId:=lastID+1;
				houseData.address:=encrypt(houseData.address);
				houseData.availibility:=1;
				//ADD TO DATA BELOW
				writeln(f_houseData,houseData.houseId);
				writeln(f_houseData,houseData.address);
				writeln(f_houseData,houseData.availibility);
				writeln(f_houseData,houseData.price);
				writeln(f_houseData,houseData.location);
				writeln(f_houseData,houseData.disaster);
				writeln(f_houseData,houseData.crime);
				addHouseModel:=1;
				close(f_houseData);
			end else begin
				addHouseModel:=0;
			end;
		end else begin
			rewrite(f_houseData);
			houseData.houseId:=1;
			houseData.address:=encrypt(houseData.address);
			houseData.price:=getHousePrice(houseData);
			writeln(f_houseData,houseData.houseId);
			writeln(f_houseData,houseData.address);
			writeln(f_houseData,houseData.availibility);
			writeln(f_houseData,houseData.price);
			writeln(f_houseData,houseData.location);
			writeln(f_houseData,houseData.disaster);
			writeln(f_houseData,houseData.crime);
			close(f_houseData);
			addHouseModel:=1;
		end;
	end;

begin
	clrscr;
	write('Nama: ');readln(userData.fullName);
	write('Password: ');readln(userData.password);
	signInModel(userData,status,signedInUser);
	writeln(status);
	writeln(signedInUser.fullName);
	writeln(signedInUser.accType);
	write('Alamat rumah: ');readln(houseData.address);
	writeln('House ID: ',findHousebyAddressModel(houseData));
	addHouseModel(houseData);
	readln;
end.