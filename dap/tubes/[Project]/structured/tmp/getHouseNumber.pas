program emeraldProperty;
uses crt,sysutils;

const
	fName_userData = 'users.dat';
	fName_houseData = 'houses.dat';
	fName_userAct = 'actions.dat';
	maxData = 1000;
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
		houseId:integer;
		address,location,disaster,crime:string;
		price:longint;
		//ORDER:
		//1. houseId
		//2. address
		//3. price
		//4. location
		//5. disaster
		//6. crime
	end;
	t_searchFilter = record
		tt_houseData:t_houseData;
		lowPrice,highPrice:longint;
		sort:integer;
	end;
	t_arrHouseData = array [1..maxData] of t_houseData;
	t_arrHouseDataView = array [1..maxData] of t_houseDataView;
	
var
	f_userData:textfile;
	f_houseData:textfile;
	f_userAct:textfile;
	userData:t_userData;
	houseData:t_houseData;
	searchFilter:t_searchFilter;
	tb_houseData:t_arrHouseData;	


function getHouseNumberModel():integer;
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
			readln(f_houseData);
			readln(f_houseData);
			readln(f_houseData);
			readln(f_houseData);
			readln(f_houseData);
			rows:=rows+1;
		end;
		close(f_houseData);
		getHouseNumberModel:=rows;
	end;

begin
	writeln('num = ',getHouseNumberModel());
	readln;
end.