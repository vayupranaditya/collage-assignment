program sorting;
uses crt;

type
	t_arrInt = array[1..5] of integer;

var
	i,j:integer;
	arrInt:t_arrInt;

function bubbleSort(arrInt:t_arrInt):t_arrInt;
{is. terdefinisi arrint
 fs. mengurutkan berdasarkan bubble}
var
	i,j,tmpInt:integer;
begin
	for i:=1 to 4 do begin
		for j:=i+1 to 5 do begin
			if (arrInt[j]<arrInt[j-1]) then begin	
				tmpInt:=arrInt[j-1];
				arrInt[j-1]:=arrInt[j];
				arrInt[j]:=tmpInt;
		end;
	end;
	bubbleSort:=arrInt;
end;
	
begin
	clrscr;
	write('arrInt: ');
	for i:=1 to 5 do begin
		arrInt[i]:=random(98);
		write(arrInt[i],',');
	end;
	readln;
	writeln('bubble sort: ',bubbleSort(arrInt));
	//writeln('selection sort: ',selectionSort(arrInt));
	//writeln('insertion sort: ',insertionSort(arrInt));
	readln;
end.