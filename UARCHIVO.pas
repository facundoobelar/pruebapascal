UNIT UARCHIVO;
INTERFACE
	USES TYPES,CRT;
	{EXPRESION REGULAR}
	PROCEDURE CREAR (var archivo: T_Archivo);
	PROCEDURE ABRIR (var archivo: T_Archivo);
	PROCEDURE CERRAR (var archivo: T_Archivo);
	PROCEDURE LEER (var archivo: T_Archivo; var cadena:string);
	PROCEDURE LEER1 (var archivo: T_Archivo; var cadena:string);
	PROCEDURE EDITAR_ER(VAR CAD:STRING;FILA,COLUMNA:INTEGER);
	PROCEDURE MODIFICAR(VAR CADENA:STRING;F,C:INTEGER);
	PROCEDURE ESCRIBIR (var archivo: T_Archivo; var cadena:string);
	{TAS}
	PROCEDURE CREARTAS (var archivo: T_A_TAS);
	PROCEDURE CERRARTAS (var archivo: T_A_TAS);
	PROCEDURE LEERTAS (var archivo: T_A_TAS; var TAS:T_TAS);
	PROCEDURE GRABARTAS (var archivo: T_A_TAS; var TAS:T_TAS);
	{AFD mínimo}
	PROCEDURE GRABARAFD (var AFD:AFD);
	PROCEDURE GRABARAFN (var AFN:AFN);
	PROCEDURE GRABARAFDMin (var AFD:AFD);

IMPLEMENTATION
{EXPRESION REGULAR}
PROCEDURE CREAR (var archivo: T_Archivo);
	BEGIN
		assign(archivo, 'RECURSOS\ER.txt');
		rewrite(archivo);
	END;
PROCEDURE ABRIR (var archivo: T_Archivo);
	BEGIN
		assign(archivo, 'RECURSOS\ER.txt');
		{$i-}
		reset(archivo);
		{$i+}
		If IOresult<>0 then
			WRITE('PROBLEMAS PARA ABRIR EL ARCHIVO. ¿EXISTE?.');
	END;
PROCEDURE CERRAR (var archivo: T_Archivo);
	BEGIN
		close(archivo);
	END;
PROCEDURE LEER (var archivo: T_Archivo; var cadena:string);
	VAR cad:string;
	BEGIN
		ABRIR(archivo);
		cadena:='';
		reset(archivo);
		while not EOF(archivo) do
			readln(archivo,cad);
		cadena:= cadena + cad;
	END;
PROCEDURE LEER1 (var archivo: T_Archivo; var cadena:string);
	VAR cad:string;
	BEGIN
		ABRIR(archivo);
		cadena:='';
		reset(archivo);
		while not EOF(archivo) do
			readln(archivo,cad);
		cadena:= cadena + cad;
		CLOSE(ARCHIVO);
	END;


PROCEDURE ESCRIBIR (var archivo: T_Archivo; var cadena:string);
BEGIN
ABRIR(archivo);
rewrite(archivo);
write(archivo,cadena);
CLOSE(ARCHIVO);
END;

PROCEDURE EDITAR_ER(VAR CAD:STRING;FILA,COLUMNA:INTEGER);
VAR F,I,C:INTEGER;TECLA:CHAR;CADENA:STRING;
BEGIN
I:=0;
CADENA:='';
F:=8;
C:=99;
	repeat
		IF (TECLA='M') THEN
		BEGIN
		I:=I+1;
		CADENA:=CADENA+CAD[I];
		GOTOXY(I+C,F+2);
		WRITE(CAD[I]);
		END;

		IF (TECLA='K') THEN
		BEGIN
		DELETE(CADENA,I,LENGTH(CAD)-I);
		GOTOXY(I+C,F+2);
		WRITE(' ');
			IF I>=1 THEN
			I:=I-1;
		GOTOXY(I+C+1,F+2);
		END;

		IF (I=LENGTH(CAD)+1)THEN
		BEGIN
		CADENA:='';
		I:=0;
		END;

		IF (I=0) THEN
		BEGIN
			FOR I:=1 TO LENGTH(CAD) DO
			BEGIN
			GOTOXY(I+C,F+2);
			WRITE(' ');
			END;
		I:=0;
		GOTOXY(I+C+1,F+2);
		END;
	TECLA:=readkey;
	until (tecla=#27);
CAD:=CADENA;
END;


PROCEDURE MODIFICAR(VAR CADENA:STRING;F,C:INTEGER);
VAR AUX:STRING;
BEGIN
GOTOXY(C,F);
writeln(CADENA);
	
EDITAR_ER(CADENA,F,C);
READ(AUX);
CADENA:=CADENA+AUX;
END;

{TAS}
PROCEDURE CREARTAS (var archivo: T_A_TAS);
	BEGIN
		assign(archivo, 'RECURSOS\TAS.DAT');
		{$i-}
		rewrite(archivo);
		{$i+}
		If IOresult<>0 then
			WRITE('PROBLEMAS PARA CREAR EL ARCHIVO');
	END;
PROCEDURE CERRARTAS (var archivo: T_A_TAS);
	BEGIN
		close(archivo);
	END;
PROCEDURE LEERTAS (var archivo: T_A_TAS; var TAS:T_TAS);
	BEGIN
		assign(archivo, 'RECURSOS\TAS.DAT');
		{$i-}
		reset(archivo);
		{$i+}
		If IOresult<>0 then
			CREARTAS(archivo);
		read(archivo,TAS);
	END;
PROCEDURE GRABARTAS (var archivo: T_A_TAS; var TAS:T_TAS);
	BEGIN
		WRITE(archivo,TAS);
	END;
{AFD mínimo}
PROCEDURE GRABARAFD (var AFD:AFD);
	VAR archivo: T_A_AFD;	cadena,aux,aux2:string;	F:RESULTADO;	k,n:integer;	procesado:T_AFD;	I:SIGMA;
	BEGIN
		assign(archivo, 'RECURSOS\AFD.txt');
		{$i-}
		rewrite(archivo);
		{$i-}
		str(AFD.Inicial^.estado,aux);
		cadena:='Estado Inicial: '+ aux;
		WRITELN(archivo,cadena);
		WRITELN(archivo);

		cadena:='Estado(s) Final(es): ';
		IF AFD.Aceptacion^.estado<>nil THEN
		BEGIN
			F:=AFD.Aceptacion;
			str(F^.estado^.estado,aux);
			cadena:=cadena + aux;
			WHILE F^.sig<>nil DO
			BEGIN
				str(F^.sig^.estado^.estado,aux);
				cadena:=cadena+', '+ aux;
				F:=F^.sig;
			END;
		END;
		WRITELN(archivo,cadena);
		WRITELN(archivo);

		BEGIN			{PARTE 1}
			WRITELN(archivo,'PARTE 1: ');
			cadena:='      ';
			BEGIN
			FOR I:=N1 TO N19 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N1 TO N19 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 2}
			WRITELN(archivo,'PARTE 2: ');
			cadena:='      ';
			BEGIN
			FOR I:=N20 TO N38 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N20 TO N38 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 3}
			WRITELN(archivo,'PARTE 3: ');
			cadena:='      ';
			BEGIN
			FOR I:=N39 TO N57 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N39 TO N57 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 4}
			WRITELN(archivo,'PARTE 4: ');
			cadena:='      ';
			BEGIN
			FOR I:=N58 TO N73 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N58 TO N73 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		close(archivo);
	END;
PROCEDURE GRABARAFN (var AFN:AFN);
	VAR archivo: T_A_AFD;	cadena,aux,aux2:string;	I:SIGMA;	k,n:integer;	procesado:T_AFNe;
	BEGIN
		assign(archivo, 'RECURSOS\AFN.txt');
		{$i-}
		rewrite(archivo);
		{$i-}
		str(AFN.Inicial^.estado,aux);
		cadena:='Estado Inicial: '+ aux;
		WRITELN(archivo,cadena);
		WRITELN(archivo);

		str(AFN.Aceptacion^.estado,aux);
		cadena:='Estado Final: '+ aux;
		WRITELN(archivo,cadena);
		WRITELN(archivo);

		BEGIN			{PARTE 1}
			WRITELN(archivo,'PARTE 1: ');
			cadena:='      ';
			BEGIN
			FOR I:=N1 TO N19 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFN.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N1 TO N19 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 2}
			WRITELN(archivo,'PARTE 2: ');
			cadena:='      ';
			BEGIN
			FOR I:=N20 TO N38 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFN.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N20 TO N38 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 3}
			WRITELN(archivo,'PARTE 3: ');
			cadena:='      ';
			BEGIN
			FOR I:=N39 TO N57 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFN.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N39 TO N57 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 4}
			WRITELN(archivo,'PARTE 4: ');
			cadena:='      ';
			BEGIN
			FOR I:=N58 TO EPS DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFN.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N58 TO N73 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;

				IF (procesado^.simbolo[EPS]<>nil) THEN
				BEGIN
					str(procesado^.simbolo[EPS]^.estado^.estado,aux);
					delete(aux2,3,length(aux));
					cadena:=cadena + aux2 + aux +' ';
					IF procesado^.simbolo[EPS]^.sig<> nil THEN
					BEGIN
						str(procesado^.simbolo[EPS]^.sig^.estado^.estado,aux);
						cadena:=cadena + '  ;  ' + aux ;
					END;
				END
				ELSE
					cadena:=cadena + aux2 + ' ';

				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		close(archivo);
	END;
PROCEDURE GRABARAFDMin (var AFD:AFD);
	VAR archivo: T_A_AFD;	cadena,aux,aux2:string;	F:RESULTADO;	k,n:integer;	procesado:T_AFD;	I:SIGMA;
	BEGIN
		assign(archivo, 'RECURSOS\AFDMin.txt');
		{$i-}
		rewrite(archivo);
		{$i-}
		str(AFD.Inicial^.estado,aux);
		cadena:='Estado Inicial: '+ aux;
		WRITELN(archivo,cadena);
		WRITELN(archivo);

		cadena:='Estado(s) Final(es): ';
		IF AFD.Aceptacion^.estado<>nil THEN
		BEGIN
			F:=AFD.Aceptacion;
			str(F^.estado^.estado,aux);
			cadena:=cadena + aux;
			WHILE F^.sig<>nil DO
			BEGIN
				str(F^.sig^.estado^.estado,aux);
				cadena:=cadena+', '+ aux;
				F:=F^.sig;
			END;
		END;
		WRITELN(archivo,cadena);
		WRITELN(archivo);

		BEGIN			{PARTE 1}
			WRITELN(archivo,'PARTE 1: ');
			cadena:='      ';
			BEGIN
			FOR I:=N1 TO N19 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N1 TO N19 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 2}
			WRITELN(archivo,'PARTE 2: ');
			cadena:='      ';
			BEGIN
			FOR I:=N20 TO N38 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N20 TO N38 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 3}
			WRITELN(archivo,'PARTE 3: ');
			cadena:='      ';
			BEGIN
			FOR I:=N39 TO N57 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N39 TO N57 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		BEGIN			{PARTE 4}
			WRITELN(archivo,'PARTE 4: ');
			cadena:='      ';
			BEGIN
			FOR I:=N58 TO N73 DO
			BEGIN
			aux2:='   ';
			delete(aux2,1,length(InvCOLAFN(I)));
			cadena:=cadena+'|'+aux2+InvCOLAFN(I)+aux2;
			END;
			cadena:=cadena+'|';

			WRITELN(archivo,cadena);											{CABECERAS COLUMNAS}

			k:=length(cadena);
			cadena:='';

			FOR n:= 1 TO k DO
				cadena:=cadena+'-';
			END;
			WRITELN(archivo,cadena);											{GUIONES SEPARADORES}

			procesado:= AFD.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				cadena:='     ';
				str(procesado^.estado,aux);
				delete(cadena,1,length(aux));
				cadena:=cadena + aux+' |';

				FOR I:= N58 TO N73 DO
				BEGIN
					aux2:='    ';
					IF procesado^.simbolo[I]<>nil THEN
						BEGIN
							str(procesado^.simbolo[I]^.estado^.estado,aux);
							delete(aux2,1,length(aux));
							cadena:=cadena + aux2 + aux +' |';
						END
					ELSE
						cadena:=cadena + aux2 + ' |';
				END;
				WRITELN(archivo,cadena);
				procesado:=procesado^.sig;
			END;
		END;
		WRITELN(archivo);

		close(archivo);
	END;

END.
