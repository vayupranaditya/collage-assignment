program testPrice;
uses crt,sysutils;

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

begin
	clrscr;
	write('Location: ');readln(houseData.location);
	write('Disaster: ');readln(houseData.disaster);
	write('Crime: ');readln(houseData.crime);
	writeln('Price: ',getHousePrice(houseData));
	readln;
end.