program babev4;
uses crt;

const
    nmax = 10;
    nfile = 'hasput.dat';
type infbar = record
    nama,category : string;
    harga,stok : real;
end;

type barang = array[1..nmax] of infbar;

var
    arrbar : barang;
    tipdatbar : file of infbar;
    catmark,fomax : integer;
    hastate : boolean;

// Forwards ============================================================================================================

    procedure pegawai; forward;
    procedure start; forward;
    procedure libarpeg; forward;
    procedure hapbar; forward;
    

procedure writefile;
var
    i : integer;
begin
    assign(tipdatbar,nfile);
    rewrite(tipdatbar);
    for i := 1 to nmax do
        begin
            write(tipdatbar,arrbar[i]);
        end;
    writeln('Saved'); delay(1000);
    close(tipdatbar);
end;

procedure readfile;
var
    i :integer;
begin
    assign(tipdatbar,nfile);
    reset(tipdatbar);
    for i := 1 to nmax do
        begin
            read(tipdatbar,arrbar[i]);
        end;
    close(tipdatbar);
end;
 
// Procedure Misc ^ ==========================================================================================================

procedure sorld(var sorl : integer);
var
    i : integer;
begin
    sorl := 0;
    for i:=1 to nmax do
        if (arrbar[i].stok > 0) then
            sorl := sorl + 1;
    writeln(sorl); delay(1000);
end;

{procedure bubblesort;
var
    temp : infbar;
    i,pass,sorl : integer;
begin
    sorld(sorl);
    for pass := 1 to sorl-1 do
        for i := 1 to sorl-1 do
            if (arrbar[i].nama > arrbar[i+1].nama) then
            begin
                temp := arrbar[i];
                arrbar[i] := arrbar[i+1];
                arrbar[i+1] := temp;
            end;
    writefile;
end;}

procedure selectionsortnama;
var
    pass,i,min,sorl : integer;
    temp : infbar;
begin
    sorld(sorl); i := 0;
    for pass := 1 to sorl-1 do
        begin
            // writeln('Pass ',pass); 
            min := pass;
            // writeln('Min ',min);
                for i := min + 1 to sorl do
                    begin
                        // writeln('i ',i);
                        if arrbar[i].nama > arrbar[min].nama then
                            min := i;
                                temp := arrbar[pass];
                                arrbar[pass] := arrbar[min];
                                arrbar[min] := temp;
                    end;
        end;
    writefile;
end;

{procedure selectionsort;
var
    pass,i,min,sorl : integer;
    temp : infbar;
begin
    sorld(sorl); i := 0;
    for pass := 1 to sorl-1 do
        begin
            // writeln('Pass ',pass); 
            min := pass;
            // writeln('Min ',min);
                for i := min + 1 to sorl do
                    begin
                        // writeln('i ',i);
                        if arrbar[i].harga > arrbar[min].harga then
                            min := i;
                                temp := arrbar[pass];
                                arrbar[pass] := arrbar[min];
                                arrbar[min] := temp;
                    end;
        end;
    writefile;
end;}

procedure insertionsortharga;
var
    pass,i : integer;
    temp : infbar;
begin
    for pass := 1 to nmax-1 do
        begin
            i := pass + 1;
            temp := arrbar[i];
            while (i > 1) and (temp.harga > arrbar[i-1].harga) do
                begin
                    arrbar[i] := arrbar[i-1];
                    i := i-1;
                end;
            arrbar[i] := temp;
        end;
    writefile;
end;

procedure insertionsort;
var
    pass,i : integer;
    temp : infbar;
begin
    for pass := 1 to nmax-1 do
        begin
            i := pass + 1;
            temp := arrbar[i];
            while (i > 1) and (temp.stok > arrbar[i-1].stok) do
                begin
                    arrbar[i] := arrbar[i-1];
                    i := i-1;
                end;
            arrbar[i] := temp;
        end;
    writefile;
end;

// Sortings ^ =========================================================================================================

procedure hargamax();
var
    hamax,i : integer;
begin
    hastate := false;
    writeln('Masukkan harga maksimal : '); readln(hamax); i:=0;
    repeat
        writeln('ERRO'); 
        i := 1 + i;
        if (arrbar[i].harga < hamax) then
            begin 
                writeln('SLDKFJ');
                fomax := i; 
                hastate := true;
            end;
    until ((fomax > 0) or (i = nmax));
end;

procedure categorys();
var
    sorl,i,pass,pilcat,mark,j : integer;
    temp : infbar;
    cat : string;
begin
    writeln('Pilih Category 1. Baju 2. Barang 3.Elektronik');
    readln(pilcat);
    case pilcat of
        1 : cat := 'Baju';
        2 : cat := 'Barang';
        3 : cat := 'Elektronik';
    end;

    sorld(sorl);
    for pass := 1 to sorl-1 do
        for i := 1 to sorl-1 do
            if (arrbar[i].category > arrbar[i+1].category) then
            begin
                temp := arrbar[i];
                arrbar[i] := arrbar[i+1];
                arrbar[i+1] := temp;
            end;
        mark := 0; j := 0;
    repeat
        mark := mark+1;
        if (arrbar[mark].category = cat) then
            j := j + 1;    
            // writeln('Repeat 1');
    until(mark = nmax); j := j+1;
        // writeln(j,' 1J MARK1 ',mark);
        mark := 0;
    repeat
        mark := mark + 1;  
        if (arrbar[j].category = cat) then
            begin
                temp := arrbar[j];
                arrbar[j] := arrbar[mark];
                arrbar[mark] := temp;
            end;
        {writeln('Repeat 2 ');} j := j+1;
    until (arrbar[j].category <> cat);
        // writeln(j,' 2J MARK2 ',mark);
    mark := 0;
    repeat
        mark := 1 + mark;
    until (arrbar[mark].category <> cat);
        // writeln(mark,' MARK3');
    writefile;
    catmark := mark;
end;


//Searching ^ ============================================================================================================

procedure cari;
var
    pilihan : integer;
begin
clrscr;
    writeln('Pilih tipe search 1. Category, 2. Max harga : '); readln(pilihan);
    case pilihan of 
        1 : categorys();
        2 : hargamax();
    end;
end;

procedure pilsort;
var
    pilihan : integer;
begin
clrscr;
        writeln('Tipe asscending sorting 1. Nama, 2. Harga, 3. Stok'); readln(pilihan);
            case pilihan of
                1 : selectionsortnama;
                2 : insertionsortharga;
                3 : insertionsort;
            end;
end;

procedure pembeli;
var
    pilihan,i,id : integer;
    namacs : string;
begin
    if (arrbar[1].stok < 1) then
        begin
            clrscr;
            gotoxy(40,15); writeln('Tidak ada barang yang bisa di beli.'); delay(2000);
            start;
        end;

    pilihan := 0;
    clrscr;
        gotoxy(46,10); writeln('Selamat datang');
        gotoxy(52,11); readln(namacs);
        writeln('Apakah anda ingin melakukan pencarian? : '); readln(pilihan);
        if (pilihan = 1) then
            cari
        else
            pilsort;
            
    clrscr;
        pilihan := 0;
        writeln('=======================================================================');
        writeln('| ID | Nama                         | Harga         | Stok | Category |');
        writeln('=======================================================================');
        if (hastate) then
            i := fomax
        else
            i := 1;
        repeat
        // for i := 1 to (nmax) or (i = catmark) do
                if arrbar[i].stok > 0 then
                    begin
                        gotoxy(3,i+3); write('  ',i,'  ');
                        gotoxy(8,i+3); write(arrbar[i].nama);
                        gotoxy(39,i+3); write(arrbar[i].harga:0:0);
                        gotoxy(55,i+3); write(arrbar[i].stok:0:0);
                        gotoxy(62,i+3); write(arrbar[i].category);
                        writeln;
                    end;
                i := i + 1;
        until ((i = nmax) or (i = catmark));

        writeln('=======================================================================');
            pilihan := -1;
            writeln('Pilih ID barang yang anda ingin beli.'); readln(id);
                case id of
                    1   :   writeln('Anda membeli barang nomor ',id); 
                    2   :   writeln('Anda membeli barang nomor ',id); 
                    3   :   writeln('Anda membeli barang nomor ',id);
                    4   :   writeln('Anda membeli barang nomor ',id);
                    5   :   writeln('Anda membeli barang nomor ',id);
                    6   :   writeln('Anda membeli barang nomor ',id);
                    7   :   writeln('Anda membeli barang nomor ',id);
                    8   :   writeln('Anda membeli barang nomor ',id);
                    9   :   writeln('Anda membeli barang nomor ',id);
                    10  :   writeln('Anda membeli barang nomor ',id);
                    0   :   begin writeln('ID tidak ada!'); start; end;
                end;    
                    if (id <> 0) then
                        begin    
                            writeln('Anda telah berhasil membeli ',arrbar[id].nama,'.'); delay(1000);
                            writeln('Barang anda bisa di ambil di Gudang Central Embrald City dengan ID ',id,' atas nama ',namacs,'.'); delay(1000);
                                    if (arrbar[id].stok > 0) then
                                        arrbar[id].stok := arrbar[id].stok - 1
                                    else
                                        begin
                                            i := -1;
                                            for i := id to nmax+1 do
                                                begin
                                                    arrbar[i].nama :=  arrbar[i+1].nama;
                                                    // writeln(arrbar[i].nama); //Visualisasi
                                                    arrbar[i].harga := arrbar[i+1].harga;
                                                    // writeln(arrbar[i].harga); //Visualisasi
                                                    arrbar[i].stok := arrbar[i+1].stok;
                                                    // writeln(arrbar[i].stok); //Visualisasi
                                                end;
                                        end;
                            writefile;
                        end;
end;

// Procedure Pembeli^ =====================================================================================================


procedure editbar;
var
    id : integer;
begin
    writeln('Masukkan ID barang yang ingin anda edit : '); readln(id);
    if (arrbar[id].nama > '') then
        begin
            writeln('Input Nama, Harga, Stok, Category : ');
            readln(arrbar[id].nama);
            readln(arrbar[id].harga);
            readln(arrbar[id].stok);
            readln(arrbar[id].category); 
            writefile;
            libarpeg;
        end
    else
        writeln('Barang tidak ada');
end;

procedure hapbar;
var
    id,i: integer;
begin
    writeln('Masukkan ID barang yang ingin anda hapus : '); readln(id);
        for i := id to nmax+1 do
            begin
                arrbar[i].nama :=  arrbar[i+1].nama;
                // writeln(arrbar[i].nama); //Visualisasi
                arrbar[i].harga := arrbar[i+1].harga;
                // writeln(arrbar[i].harga); //Visualisasi
                arrbar[i].stok := arrbar[i+1].stok;
                // writeln(arrbar[i].stok); //Visualisasi
                arrbar[i].category := arrbar[i+1].category;
            end;
        writefile;
        libarpeg;

    
end;

procedure libarpeg; {Lihat barang pegawai} 
var
    i,pilihan : integer;
begin
    clrscr;
        writeln('=======================================================================');
        writeln('| ID | Nama                         | Harga         | Stok | Category |');
        writeln('=======================================================================');

        for i := 1 to nmax do
            begin
                if arrbar[i].stok > 0 then
                    begin
                        write('  ',i,'  ');
                        gotoxy(8,i+3); write(arrbar[i].nama);
                        gotoxy(39,i+3); write(arrbar[i].harga:0:0);
                        gotoxy(55,i+3); write(arrbar[i].stok:0:0);
                        gotoxy(62,i+3); write(arrbar[i].category);
                        writeln;
                    end
            end;
        writeln('=======================================================================');

        gotoxy(2,16); writeln('1. Hapus'); gotoxy(12,16); writeln('2. Edit'); gotoxy(21,16); writeln('0. Kembali');
        read(pilihan);

        case pilihan of
            1 : hapbar;
            2 : editbar;
            0 : pegawai;
        end;    
end;

procedure inputbarang;
var
    pilihan,i,trys,mark,sorl : integer;
    state   : boolean;
begin
    clrscr;
    // state := false; i := 1;
    // while (state <> true) do
    writeln('masukkan jumlah barang yang ingin di input : '); readln(trys);
    sorld(sorl); i := sorl;
    for mark := 1 to trys do
        begin
            
                begin
                    writeln('MASUK');
                    writeln(i);
                    write('Masukkan nama, harga, stok barang, Cateogry : ');

                    readln(arrbar[i].nama);
                    readln(arrbar[i].harga);
                    arrbar[i].harga := (arrbar[i].harga*10) /100;
                    readln(arrbar[i].stok);
                    readln(arrbar[i].category);
                    i := i + 1;

                    {writeln('Apakah anda ingin menginput lagi? (1/0) '); 
                    readln(pilihan);
                        if (pilihan = 0) then
                            begin
                                state := true;
                            end
                        else if (pilihan = 1) then
                            state := false;}
                end
        end;
    writefile;
    libarpeg;
end;

procedure pegawai;
var
    pilihan : integer;
begin
    clrscr;
    gotoxy(46,10); writeln('Selamat datang'); 
    writeln;
    gotoxy(45,13); writeln('1. Input barang');
    gotoxy(45,14); writeln('2. Lihat barang');
    gotoxy(45,15); writeln('0. Kembali'); readln(pilihan);
        case pilihan of
            1 : inputbarang;
            2 : libarpeg;
            0 : start;
        end;
end;

// Procedure Pegawai ^ ====================================================================================================

procedure start;
var
    pilihan : integer;
begin
    clrscr;
    gotoxy(43,10); writeln('Applikasi BABE');
    gotoxy(44,11); writeln('Barang Bekas');
    writeln;
    gotoxy(48,13); writeln('login');
    gotoxy(45,14); writeln('1. Pembeli');
    gotoxy(45,15); writeln('2. Pegawai');

    readln(pilihan);
    case pilihan of
        1 : pembeli;
        2 : pegawai;
    else
        writeln('Exit');
    end;
end;
// Program utama ============================================================
begin
    readfile;
    start;
end.