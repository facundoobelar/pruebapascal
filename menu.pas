UNIT MENU;

INTERFACE

USES CRT,TYPES,ENTORNO,UAFNe,UARBOL,UARCHIVO,UPILA,UTAS,DVL,DOS;


PROCEDURE OPCION (var n,puntero:integer;var tecla:char);
PROCEDURE MENU_PRINCIPAL(VAR N,Y:INTEGER; VAR OP:CHAR);
PROCEDURE MENU_INFORME;

IMPLEMENTATION

PROCEDURE OPCION (var n,puntero:integer;var tecla:char);
BEGIN
tecla:=readkey;
	If Not(tecla = #13) then
	tecla:=readkey;

		Case tecla of
			'P':Begin
					if puntero<>n then
					inc(puntero)

					else
					puntero:=1;
				End;

			'H':Begin
					if puntero<>1 then
					dec(puntero)

					else
					puntero:=n;
				End;
		end;
END;



PROCEDURE MENU_PRINCIPAL(VAR N,Y:INTEGER; VAR OP:CHAR);
VAR COLUMNA,RESALTE,FILA:INTEGER;
BEGIN
RESALTE:=0;
TEXTBACKGROUND(3);
		FILA:=33;
	COLUMNA:=34;
	GOTOXY(COLUMNA,FILA); INC(FILA);
	textcolor(RESALTE);
		Writeln('INGRESAR OPCION DESEADA ');
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('');
		textcolor(14);
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('1 - Ingresar nueva ER');
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('2 - Modificar ER existente');
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('3 - Gramatica y TAS');
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('4 - Generar AFD min(detallado)');
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('5 - Generar AFD min(rapido)');
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('6 - Acerca de');
	GOTOXY(COLUMNA,FILA); INC(FILA);
		Writeln('7 - Salir de Programa');
		FILA:=31;

		gotoxy(COLUMNA-3,FILA+4); Write('  ');
		gotoxy(COLUMNA-3,FILA+5); Write('  ');
		gotoxy(COLUMNA-3,FILA+6); Write('  ');
		gotoxy(COLUMNA-3,FILA+(7)); Write('  ');
		gotoxy(COLUMNA-3,FILA+(8)); Write('  ');
		gotoxy(COLUMNA-3,FILA+(9)); Write('  ');
		gotoxy(COLUMNA-3,FILA+(10)); Write('  ');
		textcolor(RESALTE);
		gotoxy(COLUMNA-3,FILA+(y+3)); Write('>>');
		textcolor(14);
opcion(N,Y,OP);
END;

PROCEDURE MENU_INFORME;
VAR DIR:STRING;
BEGIN
ACERCADE;
DIR:='Users\Fenomenoide\Desktop\RESPALDO\LEFP.JPG';
	dir := '/c Start C:\' + dir;
	Exec('\Windows\System32\cmd.exe', dir);
END;
END.
