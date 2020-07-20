unit ENTORNO;

INTERFACE

USES CRT,TYPES;

PROCEDURE BIENVENIDA;
PROCEDURE LOGO2(VAR F,C:INTEGER);
PROCEDURE ACERCADE;
PROCEDURE PRINCIPAL;
PROCEDURE DIBUJAR_TAS(F,C:INTEGER);
PROCEDURE DIBUJAR_GRAMATICA(F,C:INTEGER);

IMPLEMENTATION

PROCEDURE BIENVENIDA;
var i,COLUMNA,C,FILA,F:integer;
BEGIN
TEXTBACKGROUND(3);
CLRSCR;
TEXTCOLOR(14);
COLUMNA:=75;
FILA:=14;
C:=45;
F:=5;
textcolor(10);
GOTOXY(C,F);INC(F);
WRITELN(' ______  _____ ________ ____  _____ ____   ____ ________ ____  _____ _____ ______    _______ ');
GOTOXY(C,F);INC(F);
WRITELN('|_   _ \|_   _|_   __  |_   \|_   _|_  _| |_  _|_   __  |_   \|_   _|_   _|_   _ `. (  ___  )');
GOTOXY(C,F);INC(F);
WRITELN('  | |_)/  | |   | |_ \_| |   \ | |   \ \   / /   | |_ \_| |   \ | |   | |   | | `. \| (   ) |');
GOTOXY(C,F);INC(F);
WRITELN('  |  __ \ | |   |  _| _  | |\ \| |    \ \ / /    |  _| _  | |\ \| |   | |   | |  | || |   | |');
GOTOXY(C,F);INC(F);
WRITELN(' _| |__) || |_ _| |__/ |_| |_\   |_    \   /    _| |__/ |_| |_\   |_ _| |_ _| |__/ /| (___) |');
GOTOXY(C,F);INC(F);
WRITELN('|_______/_____|________|_____|\____|    \_/    |________|_____|\____|_____|______./ (_______)');
TEXTCOLOR(14);

LOGO2(FILA,COLUMNA);

{LINEA DE ARRIBA Y ABAJO}
	FOR I:=4 TO 188 DO
	BEGIN
		GOTOXY(I,2);WRITELN(#205);
		GOTOXY(I,47);WRITELN(#205);
	END;

{LINEA LATERAL IZQUIERDA Y DERECHA}
	FOR I:=3 TO 46 DO
	BEGIN
		GOTOXY(3,I);WRITELN(#186);
		GOTOXY(189,I);WRITELN(#186);
	END;
	
{ESQUINAS}
GOTOXY(3,2);WRITELN(#201);
GOTOXY(3,47);WRITELN(#200);
GOTOXY(189,47);WRITELN(#188);
GOTOXY(189,2);WRITELN(#187);


{RECUADRO PROGRESO}

{LINEA DE ARRIBA Y ABAJO}
	FOR I:=33 TO 153 DO
	BEGIN
		GOTOXY(I,37);WRITELN(#205);
		GOTOXY(I,42);WRITELN(#205);
	END;

{LINEA LATERAL IZQUIERDA Y DERECHA}
	FOR I:=38 TO 41 DO
	BEGIN
		GOTOXY(33,I);WRITELN(#186);
		GOTOXY(153,I);WRITELN(#186);
	END;

	
{ESQUINAS}
GOTOXY(33,37);WRITELN(#201);
GOTOXY(33,42);WRITELN(#200);
GOTOXY(153,37);WRITELN(#187);
GOTOXY(153,42);WRITELN(#188);


	For i:=1 to 100 do
	begin
		delay(40);
		gotoxy(i+43,40);
		textcolor(10);
		writeln(#178);
		GOTOXY(83,37);
		writeln('[ Cargando ',i,'%  listo ]');
		textcolor(14);
	end;
END;



PROCEDURE LOGO2(VAR F,C:INTEGER);
var FILA,COLUMNA:integer;
BEGIN
TEXTCOLOR(15);
{HACIENDO LA L} 
FILA:=4+F;
COLUMNA:=2+C;
	For FILA:=FILA to (FILA+9) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=4+F;
COLUMNA:=3+C;
	For FILA:=FILA to (FILA+9) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;
FILA:=13+F;
COLUMNA:=3+C;
	For COLUMNA:=COLUMNA to (COLUMNA+15) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

{HACIENDO LA F}
FILA:=1+F;
COLUMNA:=14+C;
	For FILA:=FILA to (FILA+10) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=1+F;
COLUMNA:=15+C;
	For FILA:=FILA to (FILA+10) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=1+F;
COLUMNA:=16+C;
	For COLUMNA:=COLUMNA to (COLUMNA+16) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

{HACIENDO LA E}
FILA:=7+F;
COLUMNA:=8+C;
	For FILA:=FILA to (FILA+9) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=7+F;
COLUMNA:=9+C;
	For FILA:=FILA to (FILA+9) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=7+F;
COLUMNA:=9+C;
	For COLUMNA:=COLUMNA to (COLUMNA+15) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=16+F;
COLUMNA:=10+C;
	For COLUMNA:=COLUMNA to (COLUMNA+15) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

{HACIENDO LA P}
FILA:=4+F;
COLUMNA:=21+C;
	For FILA:=FILA to (FILA+10) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=4+F;
COLUMNA:=22+C;
	For FILA:=FILA to (FILA+10) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=4+F;
COLUMNA:=23+C;
	For COLUMNA:=COLUMNA to (COLUMNA+12) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=10+F;
COLUMNA:=23+C;
	For COLUMNA:=COLUMNA to (COLUMNA+12) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=4+F;
COLUMNA:=34+C;
	For FILA:=FILA to (FILA+5) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;

FILA:=4+F;
COLUMNA:=35+C;
	For FILA:=FILA to (FILA+5) do
	begin
		gotoxy(COLUMNA,FILA);
		write(#178);
	end;
gotoxy(27+C,17+F);	
writeln('Company');
TEXTCOLOR(14);
end;


PROCEDURE ACERCADE;
VAR COLOR,RESALTE,FILA,COLUMNA:INTEGER;
BEGIN
COLOR:=14;
RESALTE:=10;
FILA:=14;
COLUMNA:=110;
GOTOXY(COLUMNA-5,FILA+3);
	textcolor(RESALTE);
	Write('LEFP COMPANY');
	FILA:=FILA+6;
	textcolor(RESALTE);
	GOTOXY(COLUMNA-2,FILA);
	Writeln('*');
	textcolor(COLOR);
	GOTOXY(COLUMNA,FILA);
	Writeln('MISION: Experimentar la alegria del progreso y aplicar');
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	Writeln('       la tecnologia en beneficio de las personas.');

	FILA:=FILA+4;
	textcolor(RESALTE);
	GOTOXY(COLUMNA-2,FILA);
	Writeln('*');
	textcolor(COLOR);
	GOTOXY(COLUMNA,FILA);
	Writeln('VISION: Seguiremos construyendo nuestro futuro, siendo una ');
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	Writeln('       compania competitiva que ofrece servicios de TI de calidad.');

	FILA:=FILA+4;
	textcolor(RESALTE);
	GOTOXY(COLUMNA-2,FILA);
	Writeln('*');
	textcolor(COLOR);
	GOTOXY(COLUMNA,FILA);
	Writeln('LOGO: Este representa las iniciales de los integrantes del equipo ');
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	Writeln('       de trabajo que llevaron a cabo este trabajo practico.');


	FILA:=FILA+6;
	textcolor(RESALTE);
	GOTOXY(COLUMNA-2,FILA);
	Writeln('*');
	textcolor(COLOR);
	GOTOXY(COLUMNA,FILA);
	Writeln(' Este software fue desarollado por los alumnos: ');
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	 Writeln('                                                David Lazabal');
	 INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	 Writeln('                                                Enzo Da Silva');
	 INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	 Writeln('                                                Facundo Obelar');
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	 Writeln('                                                Pablo Ravera');
	 INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	 Writeln('                                                Fernando Rodriguez');
	INC(FILA);
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	Writeln(' El leguaje de programacion utilizado en este proyecto fue Pascal.');
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	Writeln(' El objetivo del mismo es cumplir con el trabajo practico final ');
	INC(FILA);
	 GOTOXY(COLUMNA,FILA);
	Writeln('de la materia SINTAXIS Y SEMANTICA DE LOS LEGUAJES.');
	READKEY;
END;

PROCEDURE PRINCIPAL;
VAR I,F,C:INTEGER;
BEGIN
TEXTBACKGROUND(3);
CLRSCR;
TEXTCOLOR(9);

{LINEA DE ARRIBA Y ABAJO}
	FOR I:=4 TO 188 DO
	BEGIN
		GOTOXY(I,2);WRITELN(#205);
		GOTOXY(I,47);WRITELN(#205);
	END;

{LINEA LATERAL IZQUIERDA Y DERECHA}
	FOR I:=3 TO 46 DO
	BEGIN
		GOTOXY(3,I);WRITELN(#186);
		GOTOXY(189,I);WRITELN(#186);
	END;
	
{MEDIO HORIZONTAL}
	FOR I:=4 TO 92 DO
	BEGIN
		GOTOXY(I,30);WRITELN(#205);
	END;

{MEDIO HORIZONTAL}
	FOR I:=93 TO 189 DO
	BEGIN
		GOTOXY(I,16);WRITELN(#205);
	END;

{MEDIO VERTICAL}
	FOR I:=3 TO 46 DO
	BEGIN
		GOTOXY(92,I);WRITELN(#186);
	END;

{ESQUINAS}
GOTOXY(3,2);WRITELN(#201);
GOTOXY(3,47);WRITELN(#200);
GOTOXY(189,47);WRITELN(#188);
GOTOXY(189,2);WRITELN(#187);

{MEDIO}
GOTOXY(92,2);WRITELN(#203);
GOTOXY(92,47);WRITELN(#202);
GOTOXY(92,30);WRITELN(#185);
GOTOXY(3,30);WRITELN(#204);
GOTOXY(92,16);WRITELN(#204);
GOTOXY(189,16);WRITELN(#185);

F:=7;
C:=25;
LOGO2(F,C);
END;



PROCEDURE DIBUJAR_TAS(F,C:INTEGER);
BEGIN
gotoxy(C,F);TEXTCOLOR(15);
writeln(' TAS |  CAR   | EPSILON |  VACIO |    PA     |   PC   |  CK  |    CP  |    UNION    |  PESOS |');
GOTOXY(C,F);TEXTCOLOR(5);
WRITE(' TAS');INC(F);TEXTCOLOR(14);
gotoxy(C,F);INC(F);
writeln('<ER> |PER SER |  PER SER| PER SER|  PER SER  |        |      |        |             |        |');
GOTOXY(C,F-1);TEXTCOLOR(15);
WRITE('<ER>');TEXTCOLOR(14);
gotoxy(C,F);INC(F);
writeln('<SER>|        |         |        |           |   ',#248,'    |      |        |UNION PER SER|    ',#248,'   |');
GOTOXY(C,F-1);TEXTCOLOR(15);
WRITE('<SER>');TEXTCOLOR(14);
gotoxy(C,F);INC(F);
writeln('<PER>|  RE SR |  RE SR  |  RE SR |   RE SR   |        |      |        |             |        |');
GOTOXY(C,F-1);TEXTCOLOR(15);
WRITE('<PER>');TEXTCOLOR(14);
gotoxy(C,F);INC(F);
writeln('<SR> |  RE SR |  RE SR  |  RE SR |     ',#248,'     |        |      |        |      ',#248,'      |    ',#248,'   |');
GOTOXY(C,F-1);TEXTCOLOR(15);
WRITE('<SR>');TEXTCOLOR(14);
gotoxy(C,F);INC(F);
writeln('<RE> |  SIM SC|  SIM SC | SIM SC |PA ER PC SC|        |      |        |             |        |');
GOTOXY(C,F-1);TEXTCOLOR(15);
WRITE('<RE>');TEXTCOLOR(14);
gotoxy(C,F);INC(F);
writeln('<SC> |    ',#248,'   |    ',#248,'    |   ',#248,'    |     ',#248,'     |   ',#248,'    | CK SC| CP SC  |      ',#248,'      |    ',#248,'   |');
GOTOXY(C,F-1);TEXTCOLOR(15);
WRITE('<SC>');TEXTCOLOR(14);
gotoxy(C,F);INC(F);
writeln('<SIM>|  CAR   | EPSILON |  VACIO |           |        |      |        |             |        |');
GOTOXY(C,F-1);TEXTCOLOR(15);
WRITE('<SIM>');TEXTCOLOR(14);
END;


PROCEDURE DIBUJAR_GRAMATICA(F,C:INTEGER);
BEGIN
GOTOXY(C,F);INC(F);INC(F);
TEXTCOLOR(0);
WRITELN('GRAMATICA EN BNF');
TEXTCOLOR(14);
GOTOXY(C,F);INC(F);
write(' <ER> ::= <PER><SER>');
GOTOXY(C,F);INC(F);
write(' <SER> ::= "UNION"<PER><SER>',#221 ,#248);
GOTOXY(C,F);INC(F);
write(' <PER> ::= <RE><SR>');
GOTOXY(C,F);INC(F);
write(' <SR> ::= <RE><SR>',#221,#248);
GOTOXY(C,F);INC(F);
write(' <RE> ::= <SIM><SC>',#221,'"PA"<ER>"PC"<SC>');
GOTOXY(C,F);INC(F);
write(' <SIM> ::= "CAR"',#221,'"EPSILON"',#221,'"VACIO"');
GOTOXY(C,F);INC(F);
write(' <SC> ::= "CK"<SC>',#221,'"CP"<SC>',#221,#248);
END;

END.

