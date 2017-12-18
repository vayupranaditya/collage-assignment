	program Aplikasi_Properti;
	uses crt,sysutils;

	const
		fName_userData = 'users.dat';
		fName_houseData = 'houses.dat';
		fName_userAct = 'actions.dat';
		maxData = 1000;
		basicPrice = 10000000;
		maxDuration = 50;

	type
		t_userData = record
			fullName,password,accType:string;
			//ORDER:
			//1. full name
			//2. password
			//3. accType
		end;
		t_houseData = record
			houseId,location,disaster,crime:integer;
			address:string;
			price:longint;
			//ORDER:
			//1. houseId
			//2. address
			//3. price
			//4. location
			//5. disaster
			//6. crime
		end;
		t_houseDataView = record
			houseId,locationIdx,disasterIdx,crimeIdx:integer;
			address,location,disaster,crime:string;
			price:longint;
		end;
		t_searchFilter = record
			tt_houseData:t_houseData;
			lowPrice,highPrice:longint;
			sort:integer;
		end;
		t_payment = record
			dp:longint;
			curPay:array[1..maxDuration] of real;
			duration:integer;
			balance,pay,interest:real;
		end;
		t_arrHouseData = array [1..maxData] of t_houseData;
		t_arrHouseDataView = array [1..maxData] of t_houseDataView;
		t_arrPayment = array [1..maxDuration] of t_payment;

	var
		f_userData:textfile;
		f_houseData:textfile;
		houseData:t_houseData;

	//VIEW
		procedure welcomePageView;
		{IS. -
		 FS. Menampilkan halaman pembuka}
		begin
			clrscr;
			writeln;//blank row for application location
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|                                    |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln;
			write('Press enter to continue... ');readln;
		end;
		
			function userAccountView():integer;
			{IS. -
			 FS. mengarahkan user ke bagian sign in ataupun sign out}
			var
				action:integer;
			begin
				clrscr;
				writeln;
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

			function signUpView(status:string):t_userData;
			{IS. terdefinisi string status yang bernilai informasi signup user
			 FS. mengembalikan nilai data user yang akan mendaftar}
			var
				userData:t_userData;
			begin
				clrscr;
				writeln('You are at: User Sign Up');
				writeln;
				writeln('+------------------------------------+');
				writeln('|                                    |');
				writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
				writeln('|             User Sign Up           |');
				writeln('|                                    |');
				writeln('+------------------------------------+');
				writeln;
				writeln(status);
				writeln;
				write('Full Name                    : ');readln(userData.fullName);
				write('Account Type (Admin/Customer): ');readln(userData.accType);
				write('Password                     : ');readln(userData.password);
				signUpView:=userData;
			end;

			function signInView(status:string):t_userData;
			{IS. terdefinisi string status yang bernilai informasi login user
			 FS. Mengembalikan nilai data user yang akan masuk}
			var
				userData:t_userData;
			begin
				clrscr;
				writeln('You are at: User Sign In');
				writeln;
				writeln('+------------------------------------+');
				writeln('|                                    |');
				writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
				writeln('|             User Sign In           |');
				writeln('|                                    |');
				writeln('+------------------------------------+');
				writeln;
				writeln(status);
				writeln;
				write('Full Name : ');readln(userData.fullName);
				write('Password  : ');readln(userData.password);
				signInView:=userData;
			end;

				//ADMIN
				function adminDashboardView(status:string):integer;
				{IS. terdefinisi string status yang bernilai informasi aksi admin
				 FS. mengembalikan nilai aksi dari admin}
				var
					action:integer;
				begin
					clrscr;
					writeln('You are at: Dashboard');
					writeln;
					writeln('+------------------------------------+');
					writeln('|                                    |');
					writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
					writeln('|          Admin Dashboard           |');
					writeln('|                                    |');
					writeln('+------------------------------------+');
					writeln;
					writeln(status);
					writeln;
					writeln('Opsi:');
					writeln('1. Tambahkan Rumah');
					writeln('2. Lihat Rumah');
					writeln('3. Keluar');
					writeln;
					write('Pilih(1/2/3): ');readln(action);
					adminDashboardView:=action;
				end;

					function addHouseView(status:string):t_houseData;
					{IS. terdefinisi string status yang bernilai informasi tambah rumah
					 FS. mengembalikan nilai dari data rumah yang akan ditambahkan}
					var
						houseData:t_houseData;
					begin
						clrscr;
						writeln('You are at: Dashboard > Tambah Rumah');
						writeln;
						writeln('+------------------------------------+');
						writeln('|                                    |');
						writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
						writeln('|              Add House             |');
						writeln('|                                    |');
						writeln('+------------------------------------+');
						writeln;
						writeln(status);
						writeln;
						write('Alamat Rumah: ');readln(houseData.address);
						write('Indeks Lokasi (1=Pusat Kota - 5=Pinggir Kota): ');readln(houseData.location);
						write('Indeks Kerawanan Bencana (1=Aman - 5=Rawan Bencana): ');readln(houseData.disaster);
						write('Indeks Kerawanan Kejahatan (1=Aman - 5=Rawan Kejahatan): ');readln(houseData.crime);
						addHouseView:=houseData;
					end;

					function findHouseView(status:string):t_searchFilter;
					{IS. terdefinisi status yang bernilai informasi pencarian rumah
					 FS. mengembalikan data rumah yang akan dicari}
					var
						searchFilter:t_searchFilter;
					begin
						clrscr;
						writeln('You are at: Dashboard > Lihat Rumah');
						writeln;
						writeln('+------------------------------------+');
						writeln('|                                    |');
						writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
						writeln('|             Find Houses            |');
						writeln('|                                    |');
						writeln('+------------------------------------+');
						writeln;
						writeln('Isikan 0 jika tidak ingin menggunakan suatu filter');
						write('Indeks Lokasi            (1=Pusat Kota - 5=Pinggir Kota)   : ');readln(searchFilter.tt_houseData.location);
						write('Harga terendah                                          : ');readln(searchFilter.lowPrice);
						write('Harga tertinggi                                         : ');readln(searchFilter.highPrice);
						write('Pengurutan (1=Naik, 2=Turun)                            : ');readln(searchFilter.sort);
						findHouseView:=searchFilter;
					end;
				//MADE BY I GUSTI BAGUS VAYUPRANADITYA PUTRAADINATHA
				//GITHUB.COM/VAYUPRANADITYA
						
				//CUSTOMER
				function customerDashboardView(status:string):integer;
				{IS. terdefinisi string status yang bernilai informasi aksi customer
				 FS. mengembalikan nilai aksi dari customer}
				var
					action:integer;
				begin
					clrscr;
					writeln('You are at: Dashboard');
					writeln;
					writeln('+------------------------------------+');
					writeln('|                                    |');
					writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
					writeln('|         Customer Dashboard         |');
					writeln('|                                    |');
					writeln('+------------------------------------+');
					writeln;
					writeln(status);
					writeln;
					writeln('Opsi:');
					writeln('1. Lihat Semua Rumah');
					writeln('2. Cari Rumah');
					writeln('3. Keluar');
					writeln;
					write('Pilih(1/2/3): ');readln(action);
					customerDashboardView:=action;
				end;
				
					function findHousesView(status:string):t_searchFilter;
					{IS. terdefinisi status yang bernilai informasi pencarian rumah
					 FS. mengembalikan data rumah yang akan dicari}
					var
						searchFilter:t_searchFilter;
					begin
						clrscr;
						writeln('You are at: Dashboard > Lihat Rumah');
						writeln;
						writeln('+------------------------------------+');
						writeln('|                                    |');
						writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
						writeln('|             Find House             |');
						writeln('|                                    |');
						writeln('+------------------------------------+');
						writeln;
						write('Indeks Lokasi    : ');readln(searchFilter.tt_houseData.location);
						write('Harga terendah   : ');readln(searchFilter.lowPrice);
						write('Harga tertinggi  : ');readln(searchFilter.highPrice);
						findHousesView:=searchFilter;
					end;
		
		function showHouseView(houseDataView:t_HouseDataView):integer;
		{IS. terdefinisi tabel data rumah yang ditampilkan
		 FS. menampilkan data-data rumah dan mengembalikan integer action yang akan dilakukan user}
		var
			action:integer;
		begin
			clrscr;
			writeln('You are at: Dashboard > Lihat Rumah');
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|              See House             |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln('ID Rumah                 : ',houseDataView.houseId);
			writeln('Alamat                   : ',houseDataView.address);
			writeln('Status Lokasi            : ',houseDataView.location,'(',houseDataView.locationIdx,')');
			writeln('Status Kerawanan Bencana : ',houseDataView.disaster,'(',houseDataView.disasterIdx,')');
			writeln('Status Keamanan          : ',houseDataView.crime,'(',houseDataView.crimeIdx,')');
			writeln('Harga                    : Rp. ',houseDataView.price);
			writeln;
			writeln;
			writeln('Action List:');
			writeln('1. Update House Information');
			writeln('2. Delete House');
			writeln('3. Next House');
			writeln('4. Previous House');
			writeln('5. Back');
			writeln;
			write  ('Action [1/2/3/4/5]: ');readln(action);
			showHouseView:=action;
		end;
		
		function seeHouseView(houseDataView:t_HouseDataView):integer;
		{IS. terdefinisi tabel data rumah yang ditampilkan
		 FS. menampilkan data-data rumah dan mengembalikan integer action yang akan dilakukan user}
		var
			action:integer;
		begin
			clrscr;
			writeln('You are at: Dashboard > Lihat Rumah');
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|              See House             |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln('ID Rumah                 : ',houseDataView.houseId);
			writeln('Alamat                   : ',houseDataView.address);
			writeln('Status Lokasi            : ',houseDataView.location,'(',houseDataView.locationIdx,')');
			writeln('Status Kerawanan Bencana : ',houseDataView.disaster,'(',houseDataView.disasterIdx,')');
			writeln('Status Keamanan          : ',houseDataView.crime,'(',houseDataView.crimeIdx,')');
			writeln('Harga                    : Rp. ',houseDataView.price);
			writeln;
			writeln;
			writeln('Action List:');
			writeln('1. See Payment Plan');
			writeln('2. Next House');
			writeln('3. Previous House');
			writeln('4. Back');
			writeln;
			write  ('Action [1/2/3/4]: ');readln(action);
			seeHouseView:=action;
		end;
		
		function noHouseView():integer;
		{IS. -
		 FS. menampilkan informasi bahwa data rumah tidak ada isinya}
		begin
			clrscr;
			writeln('You are at: Dashboard > Lihat Rumah');
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|              See House             |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln('Data kosong');
			noHouseView:=1;
		end;
		
		function seePaymentPlanView(houseDataView:t_HouseDataView):t_payment;
		{IS. terdefinisi tabel data rumah yang ditampilkan
		 FS. menampilkan data-data rumah dan mengembalikan integer action yang akan dilakukan user}
		var
			payment:t_payment;
		begin
			clrscr;
			writeln('You are at: Dashboard > Lihat Rumah > See Payment Plan');
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|          See Payment Plan          |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln('ID Rumah                 : ',houseDataView.houseId);
			writeln('Alamat                   : ',houseDataView.address);
			writeln('Status Lokasi            : ',houseDataView.location,'(',houseDataView.locationIdx,')');
			writeln('Status Kerawanan Bencana : ',houseDataView.disaster,'(',houseDataView.disasterIdx,')');
			writeln('Status Keamanan          : ',houseDataView.crime,'(',houseDataView.crimeIdx,')');
			writeln('Harga                    : Rp. ',houseDataView.price);
			writeln;
			writeln;
			writeln('Before we can generate your payment plan, please input some datas below');
			write(  'Down Payment   : Rp. ');readln(payment.dp);
			write(  'Duration (year): ');readln(payment.duration);
			writeln;
			seePaymentPlanView:=payment;
		end;
		
		procedure paymentPlanResult1(houseDataView:t_houseDataView;payment:t_payment);
		{IS. terdefinisi data rencana pembayaran
		 FS. menampilkan data-data rencana pembayaran}
		begin
			clrscr;
			writeln('You are at: Dashboard > Lihat Rumah > See Payment Plan');
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|          See Payment Plan          |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln('ID Rumah                 : ',houseDataView.houseId);
			writeln('Alamat                   : ',houseDataView.address);
			writeln('Status Lokasi            : ',houseDataView.location,'(',houseDataView.locationIdx,')');
			writeln('Status Kerawanan Bencana : ',houseDataView.disaster,'(',houseDataView.disasterIdx,')');
			writeln('Status Keamanan          : ',houseDataView.crime,'(',houseDataView.crimeIdx,')');
			writeln('Harga                    : Rp. ',houseDataView.price);
			writeln;
			writeln;
			writeln('Before we can generate your payment plan, please input some datas below');
			writeln(  'Down Payment   : Rp. ',payment.dp);
			writeln(  'Duration (year): ',payment.duration);
			writeln;
		end;
		
		procedure paymentPlanResultContinousView(pay:real; year:integer);
		{IS. terdefinisi real cicilan yang harus dibayar tiap tahunnya dan integer year yang merupakan tahun pembayaran cicilan
		 FS. menampilkan cicilan yang harus dibayarkan tiap tahunnya}
		begin
			writeln('Pembayaran tahun ke-',year,' sebesar: Rp. ',pay:0:2);
		end;
		
		function paymentPlanResultLast():integer;
		{IS. -
		 FS. menampilkan action yang bisa dilakukan user setelah melihat payment plan}
		var
			action:integer;
		begin
			writeln;
			writeln;
			writeln('Action List:');
			writeln('1. Buy House');
			writeln('2. Back');
			writeln;
			write  ('Action [1/2]: ');readln(action);
			paymentPlanResultLast:=action;
		end;
		
		function updateHouseView(houseDataView:t_HouseDataView; status:string):t_houseDataView;
		{IS. terdefinisi tabel data rumah dan integer dan status update yang dilakukan
		 FS. menampilkan data-data rumah dan mengembalikan rumah yang akan diupdate user}
		begin
			clrscr;
			writeln('You are at: Dashboard > Lihat Rumah > Update Info');
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|          Update House Info         |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln('ID Rumah                 : ',houseDataView.houseId);
			writeln('Alamat                   : ',houseDataView.address);
			writeln('Status Lokasi            : ',houseDataView.location,'(',houseDataView.locationIdx,')');
			writeln('Status Kerawanan Bencana : ',houseDataView.disaster,'(',houseDataView.disasterIdx,')');
			writeln('Status Keamanan          : ',houseDataView.crime,'(',houseDataView.crimeIdx,')');
			writeln('Harga                    : Rp. ',houseDataView.price);
			writeln;
			writeln(status);
			writeln;
			writeln('Kosongkan alamat jika tidak ingin mengupdate. Ketik 0 pada indeks jika tidak ingin mengupdate');
			write('Alamat Rumah: ');readln(houseDataView.address);
			write('Indeks Lokasi (1=Pusat Kota - 5=Pinggir Kota): ');readln(houseDataView.locationIdx);
			write('Indeks Kerawanan Bencana (1=Aman - 5=Rawan Bencana) ');readln(houseDataView.disasterIdx);
			write('Indeks Kerawanan Kejahatan (1=Aman - 5=Rawan Kejahatan): ');readln(houseDataView.crimeIdx);
			updateHouseView:=houseDataView;
		end;
		
		function deleteHouseView(houseDataView:t_HouseDataView; status:string):string;
		{IS. terdefinisi tabel data rumah dan status hapus yang dilakukan
		 FS. menampilkan data-data rumah dan mengembalikan nilai konfirmasi penghapusan}
		var
			action:string;
		begin
			clrscr;
			writeln('You are at: Dashboard > Lihat Rumah > Delete house');
			writeln;
			writeln('+------------------------------------+');
			writeln('|                                    |');
			writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
			writeln('|            Delete house            |');
			writeln('|                                    |');
			writeln('+------------------------------------+');
			writeln;
			writeln('ID Rumah                 : ',houseDataView.houseId);
			writeln('Alamat                   : ',houseDataView.address);
			writeln('Status Lokasi            : ',houseDataView.location,'(',houseDataView.locationIdx,')');
			writeln('Status Kerawanan Bencana : ',houseDataView.disaster,'(',houseDataView.disasterIdx,')');
			writeln('Status Keamanan          : ',houseDataView.crime,'(',houseDataView.crimeIdx,')');
			writeln('Harga                    : Rp. ',houseDataView.price);
			writeln;
			writeln(status);
			writeln;
			write('Apakah Anda yakin untuk menghapus rumah ini? [y/n]: ');readln(action);
			deleteHouseView:=action;
		end;
		
	//MODEL
		
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
		{IS. terdefinisi string text yang akan dienkripsi
		 FS. mengembalikan hasil enkripsi text}
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
					else elmnt:=text[i];
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
			i,tlength:integer;
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
				readUser.fullName:=decrypt(readUser.fullName);
				while ((not(EOF(f_userData))) AND (lower(userData.fullName) <> lower(readUser.fullName))) do begin
					readln(f_userData);
					readln(f_userData);
					rowNum:=rowNum+3;
					readln(f_userData,readUser.fullName);
				end;
				if (lower(userData.fullName) = lower(readUser.fullName)) then begin
					index:=rowNum;
				end;
			end;
			findUserModel:=index;
		end;
		
		function signUpModel(userData:t_userData):integer;
		{IS. terdefinisi userData yang berisi data yang akan ditambahkan
		 FS. Melakukan sign up dan mengembalikan 1 jika sign up berhasil, 0 jika gagal (karena data sudah ada)}
		begin
			assign(f_userData,fName_userData);
			if (fileexists(fName_userData)) then begin
				userData.accType:=lower(userData.accType);
				if (findUserModel(userData) = 0) then begin
					append(f_userData);
					//ENCRYPTION BELOW
					userData.fullName:=encrypt(userData.fullName);
					userData.password:=encrypt(userData.password);
					userData.accType:=encrypt(userData.accType);
					//INSERT TO DAT BELOW
					writeln(f_userData,userData.fullName);
					writeln(f_userData,userData.password);
					writeln(f_userData,userData.accType);
					signUpModel:=1;
				end else begin
					signUpModel:=0;
				end;
			end else begin
				rewrite(f_userData);
				userData.fullName:=encrypt(userData.fullName);
				userData.password:=encrypt(userData.password);
				userData.accType:=encrypt(userData.accType);
				writeln(f_userData,userData.fullName);
				writeln(f_userData,userData.password);
				writeln(f_userData,userData.accType);
				signUpModel:=1;
			end;
			close(f_userData);
		end;
		
		procedure signInModel(var userData:t_userData; var signInStatus:integer);
		{IS. terdefinisi userData yang akan masuk
		 FS. Melakukan sign in dan signInStatus bernila 0 jika sign in berhasil, 1 jika gagal karena data tidak ada, 2 jika gagal karena password salah}
		//MADE BY I GUSTI BAGUS VAYUPRANADITYA PUTRAADINATHA
		//GITHUB.COM/VAYUPRANADITYA
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
						userData.fullName:=decrypt(userData.fullName);
						userData.accType:=decrypt(tmpUserData.accType);
					end else begin
						signInStatus:=2;
					end;
					close(f_userData);
				end else begin
					signInStatus:=1;
				end;
			end else begin
				signInStatus:=1;
			end;
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
					rowNum:=rowNum+1;
					readln(f_houseData,readHouse.address);
					readHouse.address:=decrypt(readHouse.address);
				end;
				if (lower(houseData.address) = lower(readHouse.address)) then begin
					index:=rowNum;
				end;
				close(f_houseData);
			end;
			findHousebyAddressModel:=index;
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
			
		function getHouseNumberModel():integer;
		{IS. -
		 FS. mengembalikan jumlah dari rumah yang ada di data, 0 jika tidak ada}
		var
			rows:integer;
		begin
			assign(f_houseData,fName_houseData);
			rows:=0;
			if (fileexists(fName_houseData)) then begin
				reset(f_houseData);
				while (not(eof(f_houseData))) do begin
					readln(f_houseData);
					rows:=rows+1;
				end;
				close(f_houseData);
			end;
			getHouseNumberModel:=(rows div 6);
		end;
		
		function houseToArrayModel():t_arrHouseData;
		{IS. -
		 FS. memasukkan data-data rumah dari DAT ke array}
		var
			arrHouseData:t_arrHouseData;
			i,houseNum,tmpHouseId,tmpLocation,tmpDisaster,tmpCrime:integer;
			tmpPrice:longint;
			tmpAddress:string;
		begin
			assign(f_houseData,fName_houseData);
			if (fileexists(fName_houseData)) then begin
				houseNum:=getHouseNumberModel();
				reset(f_houseData);
				for i:=1 to houseNum do begin
					//READ DATA BELOW
					readln(f_houseData,tmpHouseId);
					readln(f_houseData,tmpAddress);
					readln(f_houseData,tmpPrice);
					readln(f_houseData,tmpLocation);
					readln(f_houseData,tmpDisaster);
					readln(f_houseData,tmpCrime);
					//DECRYPT DATA BELOW
					tmpAddress:=decrypt(tmpAddress);
					//ASSIGN TO ARRAY BELOW
					arrHouseData[i].houseId:=tmpHouseId;
					arrHouseData[i].address:=tmpAddress;
					arrHouseData[i].price:=tmpPrice;
					arrHouseData[i].location:=tmpLocation;
					arrHouseData[i].disaster:=tmpDisaster;
					arrHouseData[i].crime:=tmpCrime;
				end;
				close(f_houseData);
			end;
			houseToArrayModel:=arrHouseData;
		end;
		
		function findArrHouseDataById(houseId:integer; arrHouseData:t_arrHouseData):integer;
		{IS. terdefinisi integer houseId dan tabel yang berisi data-data tentang rumah yang dicari
		 FS. mengembalikan indeks dari rumah yang dicari, dan 0 jika tidak ditemukan. pencarian menggunakan binary search}
		var
			left,mid,right:integer;
			found:boolean;
		begin
			found:=false;
			left:=1;
			right:=getHouseNumberModel();
			while ((left <= right) AND (not(found))) do begin
				mid:=(left+right) div 2;
				if (houseId < arrHouseData[mid].houseId) then begin
					right:=mid-1;
				end else if (houseId > arrHouseData[mid].houseId) then begin
					left:=mid+1;
				end else begin
					found:=true;
				end;
			end;
			if (found) then begin
				findArrHouseDataById:=mid;
			end else begin
				findArrHouseDataById:=0;
			end;
		end;
		
		function houseViewToArrayModel(arrHouseData:t_arrHouseData):t_arrHouseDataView;
		{IS. terdefinisi tabel data rumah
		 FS. mengembalikan tabel data rumah menjadi data yang siap ditampilkan}
		var
			houseNum,i:integer;
			houseDataView:t_houseDataView;
			arrHouseDataView:t_arrHouseDataView;
		begin
			assign(f_houseData,fName_houseData);
			if (fileexists(fName_houseData)) then begin
				houseNum:=getHouseNumberModel();
				reset(f_houseData);
				for i:=1 to houseNum do begin
					case arrHouseData[i].location of
						1:houseDataView.location:='Pusat Kota';
						2:houseDataView.location:='Distrik Bisnis';
						3:houseDataView.location:='Distrik Ekonomi';
						4:houseDataView.location:='Distrik Industri';
						5:houseDataView.location:='Pinggiran Kota';
					end;
					case arrHouseData[i].disaster of
						1:houseDataView.disaster:='Sangat Aman';
						2:houseDataView.disaster:='Aman';
						3:houseDataView.disaster:='Cukup Aman';
						4:houseDataView.disaster:='Agak Rawan Bencana';
						5:houseDataView.disaster:='Rawan Bencana';
					end;
					case arrHouseData[i].crime of
						1:houseDataView.crime:='Sangat Aman';
						2:houseDataView.crime:='Aman';
						3:houseDataView.crime:='Cukup Aman';
						4:houseDataView.crime:='Agak Rawan Kejahatan';
						5:houseDataView.crime:='Rawan Kejahatan';
					end;
					arrHouseDataView[i].houseId:=arrHouseData[i].houseId;
					arrHouseDataView[i].address:=arrHouseData[i].address;
					arrHouseDataView[i].price:=arrHouseData[i].price;
					arrHouseDataView[i].location:=houseDataView.location;
					arrHouseDataView[i].locationIdx:=arrHouseData[i].location;
					arrHouseDataView[i].disaster:=houseDataView.disaster;
					arrHouseDataView[i].disasterIdx:=arrHouseData[i].disaster;
					arrHouseDataView[i].crime:=houseDataView.crime;
					arrHouseDataView[i].crimeIdx:=arrHouseData[i].crime;
				end;
				close(f_houseData);
			end;
			houseViewToArrayModel:=arrHouseDataView;
		end;
		
		function findArrHouseDataViewById(houseId:integer; arrHouseDataView:t_arrHouseDataView):integer;
		{IS. terdefinisi integer houseId dan tabel yang berisi data-data tentang rumah yang dicari
		 FS. mengembalikan indeks dari rumah yang dicari, dan 0 jika tidak ditemukan. pencarian menggunakan binary search}
		var
			left,mid,right:integer;
			found:boolean;
		begin
			found:=false;
			left:=1;
			right:=getHouseNumberModel();
			while ((left <= right) AND (not(found))) do begin
				mid:=(left+right) div 2;
				if (houseId > arrHouseDataView[mid].houseId) then begin
					right:=mid-1;
				end else if (houseId < arrHouseDataView[mid].houseId) then begin
					left:=mid+1;
				end else begin
					found:=true;
				end;
			end;
			if (found) then begin
				findArrHouseDataViewById:=mid;
			end else begin
				findArrHouseDataViewById:=0;
			end;
		end;
		
		function addHouseModel(houseData:t_houseData):integer; 
		{IS. terdefinisi houseData yang berisi data yang akan ditambahkan
		 FS. Melakukan menambahkan rumah dan mengembalikan True jika penambahan berhasil, False jika gagal (karena data sudah ada)}
		var
			numHouses,lastID:integer;
			arrHouseData:t_arrHouseData;
		begin
			assign(f_houseData,fName_houseData);
			arrHouseData:=houseToArrayModel;
			if (fileexists(fName_houseData)) then begin
				if (findHousebyAddressModel(houseData) = 0) then begin
					numHouses:=getHouseNumberModel();
					if (numHouses = 0) then begin
						lastID:=0;
					end else begin
						lastID:=arrHouseData[numHouses].houseId;
					end;
					append(f_houseData);
					houseData.price:=getHousePrice(houseData);
					houseData.houseId:=lastID+1;
					houseData.address:=encrypt(houseData.address);
					//ADD TO DATA BELOW
					writeln(f_houseData,houseData.houseId);
					writeln(f_houseData,houseData.address);
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
				writeln(f_houseData,houseData.price);
				writeln(f_houseData,houseData.location);
				writeln(f_houseData,houseData.disaster);
				writeln(f_houseData,houseData.crime);
				close(f_houseData);
				addHouseModel:=1;
			end;
		end;
		
		function updateHouseModel(houseDataView:t_HouseDataView;arrHouseData:t_arrHouseData):integer;
		{IS. terdefinisi tabel data rumah yang akan diupdate dan array semua data rumah
		 FS. mengupdate rumah dan mengembalikan status update rumah}
		var
			houseData:t_houseData;
			index,arrLength,i:integer;
		begin
			arrLength:=getHouseNumberModel();
			houseData.houseId:=houseDataView.houseId;
			index:=findArrHouseDataById(houseData.houseId,arrHouseData);
			if (index <> 0) then begin
				if (houseDataView.address <> '') then begin
					houseData.address:=houseDataView.address;
				end else begin
					houseData.address:=arrHouseData[index].address;
				end;
				if (houseDataView.locationIdx <> 0) then begin
					houseData.location:=houseDataView.locationIdx;
				end else begin
					houseData.location:=arrHouseData[index].location;
				end;
				if (houseDataView.disasterIdx <> 0) then begin
					houseData.disaster:=houseDataView.disasterIdx;
				end else begin
					houseData.disaster:=arrHouseData[index].disaster;
				end;
				if (houseDataView.crimeIdx <> 0) then begin
					houseData.crime:=houseDataView.crimeIdx;
				end else begin
					houseData.crime:=arrHouseData[index].crime;
				end;
				houseData.price:=getHousePrice(houseData);
				arrHouseData[index]:=houseData;
				assign(f_houseData,fName_houseData);
				rewrite(f_houseData);
				for i:=1 to arrLength do begin
					writeln(f_houseData,arrHouseData[i].houseId);
					writeln(f_houseData,encrypt(arrHouseData[i].address));
					writeln(f_houseData,arrHouseData[i].price);
					writeln(f_houseData,arrHouseData[i].location);
					writeln(f_houseData,arrHouseData[i].disaster);
					writeln(f_houseData,arrHouseData[i].crime);
				end;
				close(f_houseData);
				updateHouseModel:=1;
			end else begin
				updateHouseModel:=0;
			end;
		end;
		
		function deleteHouseModel(arrHouseData:t_arrHouseData;houseDataView:t_houseDataView):integer;
		{IS. terdefinisi array yang berisi data-data rumah, dan data rumah yang akan dihapus
		 FS. menghapus rumah dari DAT}
		var
			arrLength,index,i:integer;
		begin
			arrLength:=getHouseNumberModel();
			houseData.houseId:=houseDataView.houseId;
			index:=findArrHouseDataById(houseData.houseId,arrHouseData);
			if (index <> 0) then begin
				for i:=index to arrLength-1 do begin
					arrHouseData[index]:=arrHouseData[index+1];
				end;
				assign(f_houseData,fName_houseData);
				rewrite(f_houseData);
				for i:=1 to arrLength-1 do begin
					writeln(f_houseData,arrHouseData[i].houseId);
					writeln(f_houseData,encrypt(arrHouseData[i].address));
					writeln(f_houseData,arrHouseData[i].price);
					writeln(f_houseData,arrHouseData[i].location);
					writeln(f_houseData,arrHouseData[i].disaster);
					writeln(f_houseData,arrHouseData[i].crime);
				end;
				close(f_houseData);
				deleteHouseModel:=1;
			end else begin
				deleteHouseModel:=0;
			end;
		end;
		
		function getPaymentPlanModel(arrHouseDataView:t_arrHouseDataView;index:integer; payment:t_payment):t_payment;
		{IS. terdefinisi type arrHouseData yang berisi data-data rumah, integer index yang merupakan indeks dari rumah yang akan dilihat payment plan-nya, dan type payment yang berisi DP dan durasi angsuran
		 FS.}
		var
			year:integer;
		begin
			payment.balance:=arrHouseDataView[index+1].price-payment.dp;
			payment.pay:=payment.balance/payment.duration;
			for year:=1 to payment.duration do begin
				if (year <= 5) then begin
					payment.interest:=0.05;
				end else begin
					if (payment.interest>=0.01) then begin
						payment.interest:=payment.interest-0.01;
					end;
				end;
				payment.curPay[year]:=(1+payment.interest)*payment.pay;
			end;
			getPaymentPlanModel:=payment;
		end;
		
		function getCheapestHouseViewModel():t_arrHouseDataView;
		{IS. -
		 FS. mengembalikan rumah-rumah diurutkan dari yang paling murah. Algoritma yang digunakan: bubble sort}
		var
			arrHouseDataView:t_arrHouseDataView;
			arrHouseData:t_arrHouseData;
			i,j,arrLength:integer;
			tmpHouseDataView:t_houseDataView;
		begin
			arrLength:=getHouseNumberModel();
			arrHouseData:=houseToArrayModel();
			arrHouseDataView:=houseViewToArrayModel(arrHouseData);
			for i:=1 to arrLength do begin
				for j:=1 to arrLength-1 do begin
					if (arrHouseDataView[j].price > arrHouseDataView[j+1].price) then begin
						tmpHouseDataView:=arrHouseDataView[j];
						arrHouseDataView[j]:=arrHouseDataView[j+1];
						arrHouseDataView[j+1]:=tmpHouseDataView;
					end;
				end;
			end;
			getCheapestHouseViewModel:=arrHouseDataView;
		end;
		
		function getStrategicHouseViewModel():t_arrHouseDataView;
		{IS. -
		 FS. mengembalikan rumah-rumah diurutkan dari yang paling strategis. Algoritma yang digunakan: selection sort}
		var
			arrHouseDataView:t_arrHouseDataView;
			arrHouseData:t_arrHouseData;
			minIdx,i,j,arrLength:integer;
			tmpHouseDataView:t_houseDataView;
		begin
			arrLength:=getHouseNumberModel();
			arrHouseData:=houseToArrayModel();
			arrHouseDataView:=houseViewToArrayModel(arrHouseData);
			for i:=1 to arrLength-1 do begin
				minIdx:=i;
				for j:=i+1to arrLength do begin
					if (arrHouseDataView[minIdx].locationIdx > arrHouseDataView[j].locationIdx) then begin
						minIdx:=j;
					end;
				end;
				tmpHouseDataView:=arrHouseDataView[i];
				arrHouseDataView[i]:=arrHouseDataView[minIdx];
				arrHouseDataView[minIdx]:=tmpHouseDataView;
			end;
			getStrategicHouseViewModel:=arrHouseDataView;
		end;
		
		function getDisasterFreeHouseViewModel():t_arrHouseDataView;
		{IS. -
		 FS. mengembalikan rumah-rumah diurutkan dari yang paling strategis. Algoritma yang digunakan: insertion sort}
		var
			arrHouseDataView:t_arrHouseDataView;
			arrHouseData:t_arrHouseData;
			i,j,arrLength:integer;
			tmpHouseDataView:t_houseDataView;
		begin
			arrLength:=getHouseNumberModel();
			arrHouseData:=houseToArrayModel();
			arrHouseDataView:=houseViewToArrayModel(arrHouseData);
			for i:=2 to arrLength do begin
				j:=i;
				tmpHouseDataView:=arrHouseDataView[j];
				while ((j>1) AND (arrHouseDataView[j-1].disasterIdx > tmpHouseDataView.disasterIdx)) do begin
					arrHouseDataView[j]:=arrHouseDataView[j-1];
					j:=j-1;
				end;
				arrHouseDataView[j]:=tmpHouseDataView;
			end;
			getDisasterFreeHouseViewModel:=arrHouseDataView;
		end;
		
		function getCrimeFreeHouseViewModel():t_arrHouseDataView;
		{IS. -
		 FS. mengembalikan rumah-rumah diurutkan dari yang paling strategis. Algoritma yang digunakan: insertion sort}
		var
			arrHouseDataView:t_arrHouseDataView;
			arrHouseData:t_arrHouseData;
			i,j,arrLength:integer;
			tmpHouseDataView:t_houseDataView;
		begin
			arrLength:=getHouseNumberModel();
			arrHouseData:=houseToArrayModel();
			arrHouseDataView:=houseViewToArrayModel(arrHouseData);
			for i:=2 to arrLength do begin
				j:=i;
				tmpHouseDataView:=arrHouseDataView[j];
				while ((j>1) AND (arrHouseDataView[j-1].crimeIdx > tmpHouseDataView.crimeIdx)) do begin
					arrHouseDataView[j]:=arrHouseDataView[j-1];
					j:=j-1;
				end;
				arrHouseDataView[j]:=tmpHouseDataView;
			end;
			getCrimeFreeHouseViewModel:=arrHouseDataView;
		end;
				
	//CONTROLLER

		procedure userAccountCallerController(var action:integer);
		{IS. -
		 FS. Memanggil function userAccountView sampai input yang diterima valid}
		begin
			repeat
				action:=userAccountView()
			until ((action = 1) OR (action = 2));
		end;
		
		procedure signInController(var userData:t_userData);
		{IS. -
		 FS. Melakukan sign in}
		var
			status:string;
			signInStatus:integer;
		begin
			status:='';
			repeat
				userData:=signInView(status);
				signInModel(userData,signInStatus);
				if (signInStatus = 1) then begin
					status:='User not found';
				end else if (signInStatus = 2) then begin
					status:='Password missmatch';
				end;
			until (signInStatus = 0);
		end;
		
		procedure signUpController(var userData:t_userData);
		{IS. -
		 FS. Melakukan sign up}
		var
			status:string;
			signUpStatus:integer;
		begin
			status:='';
			repeat
				repeat
					userData:=signUpView(status);
					if ((lower(userData.accType) <> 'admin') OR (lower(userData.accType) <> 'customer')) then begin
						status:='Wrong Account Type';
					end;
				until ((lower(userData.accType) = 'admin') OR (lower(userData.accType) = 'customer'));
				signUpStatus:=signUpModel(userData);
				if (signUpStatus = 0) then begin
					status:='Nama sudah ada yang memakai. Silahkan pakai nama lain';
				end;
			until (signUpStatus = 1);
		end;
		
		procedure userAccoutController(var userData:t_userData);
		{IS. -
		 FS. Mengarahkan User untuk sign in ataupun sign up}
		var
			action:integer;
		begin
			if (fileexists(fName_userData)) then begin
				repeat
					userAccountCallerController(action);
				until ((action = 1) OR (action = 2));
				if (action = 1) then begin
					signInController(userData);
				end else begin
					signUpController(userData);
				end;
			end else begin
				signUpController(userData);
			end;
		end;
		
		procedure addHouseController();
		{IS. -
		 FS. menambahkan rumah}
		var
			houseData:t_houseData;
			addHouseStatus:integer;
			status:string;
		begin
			status:='';
			repeat
				repeat
					houseData:=addHouseView(status);
					if (((houseData.location<0) OR (houseData.location>5) OR (houseData.disaster<0) OR (houseData.disaster>5)) OR ((houseData.crime<0) OR (houseData.crime>5))) then begin
						status:='Indeks melewati batas';
					end;
				until (((houseData.location>=0) AND (houseData.location<=5) AND (houseData.disaster>=0) AND (houseData.disaster<=5)) AND ((houseData.crime>=0) AND (houseData.crime<=5)));
				addHouseStatus:=addHouseModel(houseData);
				if (addHouseStatus = 0) then begin
					status:='Rumah sudah ada. Silahkan update informasi melalui menu Lihat Rumah';
				end;
			until (addHouseStatus = 1);
		end;
		
		procedure updateHouseInfoController(arrHouseData:t_arrHouseData; arrHouseDataView:t_arrHouseDataView; index:integer);
		{IS. terdefinisi tabel-tabel data rumah dan integer index dari rumah yang akan diupdate infonya
		 FS. mengupdate info rumah tersebut}
		var
			status:string;
			houseDataView:t_houseDataView;
			errorCode:integer;
		begin
			status:='';
			errorCode:=0;
			repeat
				houseDataView:=updateHouseView(arrHouseDataView[index],status);
				if ((houseDataView.locationIdx<0) OR (houseDataView.locationIdx>5)) then begin
					errorCode:=1;
				end;
				if ((houseDataView.disasterIdx<0) OR (houseDataView.disasterIdx>5)) then begin
					errorCode:=1;
				end;
				if ((houseDataView.crimeIdx<0) OR (houseDataView.crimeIdx>5)) then begin
					errorCode:=1;
				end;
				case errorCode of
					0:status:='';
					1:status:='Indeks melewati batas';
				end;
			until (errorCode=0);
			updateHouseModel(houseDataView,arrHouseData);
			writeln;
			writeln('Update info berhasil');
			readln;
		end;
		
		procedure deleteHouseController(arrHouseData:t_arrHouseData; arrHouseDataView:t_arrHouseDataView; index:integer);
		{IS. terdefinisi array yang berisi data-data rumah, data rumah yang akan  dihapus
		 FS. menghapus rumah}
		var
			status,action:string;
		begin
			status:='';
			repeat
				action:=deleteHouseView(arrHouseDataView[index],status);
				if ((lower(action) <> 'y') AND (lower(action) <> 'n')) then begin
					status:='Pilih y atau n';
				end else begin
					status:='';
				end;
			until (status='');
			if (lower(action) = 'y') then begin
				deleteHouseModel(arrHouseData,arrHouseDataView[index]);
				writeln('Hapus data berhasil');
			end else begin
				writeln('Penghapusan data dibatalkan');
			end;
			readln;
		end;
				
		procedure showHousesController();
		{IS. -
		 FS. menampilkan data rumah}
		var
			showHouse,houseNum,houseLeft,action:integer;
			arrHouseData:t_arrHouseData;
			arrHouseDataView:t_arrHouseDataView;
		begin
			showHouse:=1;
			action:=0;
			houseNum:=getHouseNumberModel();
			houseLeft:=houseNum;
			while ((action <> 5) AND (houseLeft>0)) do begin
				arrHouseData:=houseToArrayModel();
				arrHouseDataView:=houseViewToArrayModel(arrHouseData);
				action:=showHouseView(arrHouseDataView[showHouse]);
				case action of
					1:updateHouseInfoController(arrHouseData,arrHouseDataView,showHouse);
					2:	begin
							deleteHouseController(arrHouseData,arrHouseDataView,showHouse);
							houseNum:=getHouseNumberModel();
							houseLeft:=houseNum;
						end;
					3:	begin
							if (showHouse<houseNum) then begin
								showHouse:=showHouse+1;
								houseLeft:=houseLeft-1;
							end;
						end;
					4:	begin
							if (showHouse>1) then begin
								showHouse:=showHouse-1;
								houseLeft:=houseLeft+1;
							end;
						end;
				end;
			end;
			if (houseLeft = 0) then begin
				noHouseView();
				readln;
			end;
		end;
			
		procedure adminController();
		{IS. -
		 FS. mengarahkan admin untuk menambah, mengubah, menghapus rumah}
		var
			status:string;
			action:integer;
		begin
			status:='';
			repeat
				action:=adminDashboardView(status);
				case action of
					1:addHouseController();
					2:showHousesController();
				end;
				if ((action < 1) OR (action > 3)) then begin
					status:='Aksi salah';
				end else begin
					status:='';
				end;
			until (action = 3);
		end;
		
		procedure seePaymentPlanController(arrHouseDataView:t_arrHouseDataView; index:integer);
		{IS. terdefinisi array yang berisi data rumah dan integer index rumah yang ingin dilihat rencana pembayarannya
		 FS. mengarahkan user untuk melihat rencana pembayaran}
		var
			payment,showPayment:t_payment;
			year,action,status:integer;
			arrHouseData:t_arrHouseData;
		begin
			arrHouseData:=houseToArrayModel();
			repeat
				status:=0;
				payment:=seePaymentPlanView(arrHouseDataView[index]);
				if ((arrHouseDataView[index].price = payment.dp) AND (payment.duration = 0)) then begin
					status:=1;
				end else if (payment.duration>0) then begin
					status:=1;
				end;
			until (status = 1);
			repeat
				showPayment:=getPaymentPlanModel(arrHouseDataView,index-1,payment);
				paymentPlanResult1(arrHouseDataView[index],showPayment);
				for year:=1 to payment.duration do begin
					paymentPlanResultContinousView(showPayment.curPay[year],year);
				end;
				action:=paymentPlanResultLast();
			until ((action = 1) OR (action = 2));
			if (action = 1) then begin
				if (deleteHouseModel(arrHouseData,arrHouseDataView[index]) = 1) then begin
					writeln('Rumah berhasil dibeli');
					readln;
				end;
			end else begin
			end;
		end;
		
		procedure seeHouseController();
		{IS. -
		 FS. menampilkan data rumah}
		var
			showHouse,houseNum,houseLeft,action:integer;
			arrHouseData:t_arrHouseData;
			arrHouseDataView:t_arrHouseDataView;
		begin
			showHouse:=1;
			action:=0;
			houseNum:=getHouseNumberModel();
			houseLeft:=houseNum;
			while ((action <> 4) AND (houseLeft>0)) do begin
				arrHouseData:=houseToArrayModel();
				arrHouseDataView:=houseViewToArrayModel(arrHouseData);
				action:=seeHouseView(arrHouseDataView[showHouse]);
				case action of
					1:seePaymentPlanController(arrHouseDataView,showHouse);
					2:	begin
							if (showHouse<houseNum) then begin
								showHouse:=showHouse+1;
								houseLeft:=houseLeft-1;
							end;
						end;
					3:	begin
							if (showHouse>1) then begin
								showHouse:=showHouse-1;
								houseLeft:=houseLeft+1;
							end;
						end;
				end;
			end;
			if (houseLeft = 0) then begin
				noHouseView();
				readln;
			end;
		end;
		
		procedure showSearchHouseController(method:integer);
		{IS. terdefinisi integer method yang melambangkan cara pengurutan data
		 FS. menampilkan data rumah berdasarkan metode yang dipilih}
		var
			showHouse,houseNum,houseLeft,action:integer;
			arrHouseDataView:t_arrHouseDataView;
		begin
			showHouse:=1;
			action:=0;
			houseNum:=getHouseNumberModel();
			houseLeft:=houseNum;
			while ((action <> 4) AND (houseLeft>0)) do begin
				//FIX DATA BELOW
				case method of
					1: arrHouseDataView:=getCheapestHouseViewModel();
					2: arrHouseDataView:=getStrategicHouseViewModel();
					3: arrHouseDataView:=getDisasterFreeHouseViewModel();
					4: arrHouseDataView:=getCrimeFreeHouseViewModel();
				end;
				action:=seeHouseView(arrHouseDataView[showHouse]);
				case action of
					1:seePaymentPlanController(arrHouseDataView,showHouse);
					2:	begin
							if (showHouse<houseNum) then begin
								showHouse:=showHouse+1;
								houseLeft:=houseLeft-1;
							end;
						end;
					3:	begin
							if (showHouse>1) then begin
								showHouse:=showHouse-1;
								houseLeft:=houseLeft+1;
							end;
						end;
				end;
			end;
			if (houseLeft = 0) then begin
				noHouseView();
				readln;
			end;
		end;
		
		procedure searchHouse();
		{IS. -
		 FS. mencari rumah berdasarkan kriteria}
		var
			action:integer;
		begin
			repeat
				clrscr;
				writeln('You are at: Dashboard > Cari Rumah > Delete house');
				writeln;
				writeln('+------------------------------------+');
				writeln('|                                    |');
				writeln('|   APLIKASI PROPERTI EMERALD CITY   |');
				writeln('|            Search house            |');
				writeln('|                                    |');
				writeln('+------------------------------------+');
				writeln;
				writeln('Pilih aksi:');
				writeln('1. Cari rumah dari yang termurah');
				writeln('2. Cari rumah dari yang paling strategis');
				writeln('3. Cari rumah dari yang paling aman dari bencana');
				writeln('4. Cari rumah dari yang paling aman dari kejahatan');
				writeln('5. Kembali');
				writeln;
				write(  'Pilih [1/2/3/4/5]: ');readln(action);
			until ((action >=1) AND (action <=5));
			case action of
				1:showSearchHouseController(1);
				2:showSearchHouseController(2);
				3:showSearchHouseController(3);
				4:showSearchHouseController(4);
			end;
		end;
		
		procedure customerController();
		{IS. -
		 FS. mengarahkan customer untuk melihat-lihat rumah, ataupun mencari rumah}
		var
			status:string;
			action:integer;
		begin
			status:='';
			repeat
				action:=customerDashboardView(status);
				case action of
					1:seeHouseController();
					2:searchHouse();
				end;
				if ((action < 1) OR (action > 3)) then begin
					status:='Aksi salah';
				end else begin
					status:='';
				end;
			until (action = 3);
		end;
		
		procedure userRouteController(userData:t_userData);
		{IS. terdefinisi userData yang berisi data user yang telah masuk
		 FS. mengarahkan user ke admin dashboard jika user adalah admin, dan customer dashboard jika user adalah customer}
		begin
			writeln(userData.accType);
			if (userData.accType = 'admin') then begin
				adminController();
			end else if (userData.accType = 'customer') then begin
				customerController();
			end;
		end;
		
		procedure main();
		{IS. -
		 FS. Membuka program}
		var
			userData:t_userData;
		begin
			welcomePageView;
			userAccoutController(userData);
			userRouteController(userData);
		end;

	begin
		main();
	end.