UNIT UTAS;
INTERFACE
	USES TYPES, UARCHIVO;

	PROCEDURE INICIALIZARTAS(var TAS:T_TAS);
	PROCEDURE ORIGINARTAS(var archivo:T_A_TAS; var TAS:T_TAS);
	PROCEDURE TASBNF (VAR TAS:T_TAS);

IMPLEMENTATION
PROCEDURE INICIALIZARTAS(var TAS:T_TAS);
	VAR	J:COLUMNA;	I:FILA;
	BEGIN
		FOR I:=ER TO SIM DO
			FOR J:=CAR TO PESOS DO
				TAS[I,J]:='';
	END;
PROCEDURE ORIGINARTAS(var archivo:T_A_TAS; var TAS:T_TAS);
	VAR CO:COLUMNA;
	BEGIN
			CREARTAS(archivo);
			INICIALIZARTAS(TAS);
	{ER}	FOR CO:=CAR TO PA DO
				TAS[ER,CO]:='PER SER';
			TAS[ER,EPSILON]:='PER SER';

	{SER}	TAS[SER,UNION]:='UNION PER SER';
			TAS[SER,PC]:=#248; {ø}
			TAS[SER,PESOS]:=#248; {ø}

	{PER}	FOR CO:=CAR TO PA DO
				TAS[PER,CO]:='RE SR';
			TAS[PER,EPSILON]:='RE SR';

	{SR}	FOR CO:=CAR TO PA DO
				TAS[SR,CO]:='RE SR';
			TAS[SR,EPSILON]:='RE SR';
			TAS[SR,UNION]:=#248; {ø}
			TAS[SR,PC]:=#248; {ø}
			TAS[SR,PESOS]:=#248; {ø}

	{RE}	FOR CO:=CAR TO VACIO DO
				TAS[RE,CO]:='SIM SC';
			TAS[RE,EPSILON]:='SIM SC';
			TAS[RE,PA]:='PA ER PC SC';

	{SC}	FOR CO:=CAR TO PC DO
				TAS[SC,CO]:=#248; {ø}
			TAS[SC,CK]:='CK SC';
			TAS[SC,CP]:='CP SC';
			FOR CO:=UNION TO PESOS DO
				TAS[SC,CO]:=#248; {ø}

	{SIM}	TAS[SIM,CAR]:='CAR';
			TAS[SIM,VACIO]:='VACIO';
			TAS[SIM,EPSILON]:='EPSILON';

		GRABARTAS(archivo,TAS);
	END;
PROCEDURE TASBNF (VAR TAS:T_TAS);
	VAR	FIL:FILA; COL:COLUMNA;
	BEGIN
		for FIL:=ER TO SIM  DO
			begin
				for COL:=CAR TO PESOS DO
					case tas[FIL,COL] of
						'PER SER': tas[FIL,COL]:= '<PER><SER>';
						'RE SR': tas[FIL,COL]:= '<RE><SR>';
						'SIM SC': tas[FIL,COL]:= '<SIM><SC>';
						'CK SC': tas[FIL,COL]:= '"CK"<SC>';
						'CP SC': tas[FIL,COL]:= '"CP"<SC>';
						'UNION PER SER': tas[FIL,COL]:= '"UNION"<PER><SER>';
						'PA ER PC SC': tas[FIL,COL]:= '"PA"<ER>"PC"<SC>';
						'CAR': tas[FIL,COL]:='"CAR"';
						'VACIO': tas[FIL,COL]:='"VACIO"';
						'EPSILON': tas[FIL,COL]:='"EPSILON"';		{^}
						#248: tas[FIL,COL]:=#248; {ø}
					end;
			end;
	END;

END.
