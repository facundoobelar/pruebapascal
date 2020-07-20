UNIT	DVL;
INTERFACE
	USES TYPES, UTAS, UAFNe, UARCHIVO, UPILA, UARBOL, CRT,ANALISIS_LEXICO;

	PROCEDURE ARBOLSINTACTICO(cadena:string; var control:string; TAS:T_TAS; var ARBOL:T_ARBOL);
	PROCEDURE AFNe (var ARBOL:T_ARBOL; var TT:T_AFNe);


{FINALES}
	PROCEDURE AN_SINTACTICO (var ARCH_ER:T_ARCHIVO; var ARBOL:T_ARBOL; var OK:BOOLEAN);
	PROCEDURE GENERAR_AFNe (ARBOL:T_ARBOL; var AFN:AFN);
	PROCEDURE GENERAR_AFD (AFN:AFN; VAR AFD:AFD);
	PROCEDURE GENERAR_AFDM (AFD:AFD; var AFDM:AFD);

IMPLEMENTATION

PROCEDURE ARBOLSINTACTICO(cadena:string; var control:string; TAS:T_TAS; var ARBOL:T_ARBOL);
	VAR pila:T_PILA; info:T_DATO_PILA; J:integer;
	BEGIN
		IF length(cadena)>0 THEN
		BEGIN
			cadena:= cadena + '$';
			control:='';
			J:=1;
			WHILE (J <= length(cadena)) AND COMPLEXVALIDO(cadena[J]) DO
			BEGIN
				CREARPILA(pila);
				Info.Etiqueta.CompLex:='$';
				Info.DirArbol:=nil;
				APILAR(pila,info);

				new(ARBOL);
				CREARARBOL(ARBOL);
				ARBOL^.Etiqueta.CompLex:='<ER>';
				ARBOL^.Etiqueta.Lexema:=' ';
				Info.Etiqueta:=ARBOL^.Etiqueta;
				Info.DirArbol:=ARBOL;
				APILAR(pila,Info);

				TASBNF(TAS);
				REPEAT
					BEGIN
						DESAPILAR(pila,Info);
						IF Info.Etiqueta.CompLex[1]='"' THEN	{TERMINAL}
						BEGIN
							IF Info.Etiqueta.CompLex=InvGETCOL(GETCOL(cadena[j])) THEN
								INC(j)
							ELSE
							control:='ERROR';
						END
						ELSE
						BEGIN
							IF Info.Etiqueta.CompLex[1]='<' THEN	{VARIABLE}
							BEGIN
								IF TAS[GETROW(Info.Etiqueta.CompLex),GETCOL(cadena[J])] = '' THEN
									control:='ERROR'
								ELSE
									BEGIN
										CARGARARBOL(Info.DirArbol,TAS[GETROW(Info.Etiqueta.CompLex),GETCOL(cadena[J])],cadena[J]);
										IF (Info.DirArbol^.Hijo^.Etiqueta.CompLex<>#248) THEN
											APILARPROD(pila,Info.DirArbol^.Hijo);
									END;
							END
							ELSE
							BEGIN
								IF (Info.Etiqueta.CompLex=cadena[J])AND(Info.Etiqueta.CompLex='$') THEN
									control:='EXITO'
								ELSE
									control:='ERROR';
							END;
						END;
					END;
				UNTIL (control='EXITO') OR (control='ERROR');
				IF control='ERROR' then
				BEGIN
					BORRARPILA(pila);
					ELIMINARARBOL(ARBOL);
				END;
			END;
		END
		ELSE
			control:='ERROR';
	END;
PROCEDURE AFNe (var ARBOL:T_ARBOL; var TT:T_AFNe);
	VAR TT1:T_AFNe;
	BEGIN
		IF ARBOL<>nil THEN
		BEGIN
			CASE ARBOL^.Etiqueta.CompLex OF
				'"CAR"':	BEGIN
								TT_CAR(TT,ARBOL^.Etiqueta.Lexema);
							END;
				'"EPSILON"':BEGIN
								TT_EPSILON(TT);
							END;
				'"VACIO"':	BEGIN
								TT_VACIO(TT);
							END;
				'"UNION"':	BEGIN
							END;
				'"CK"':		BEGIN
								TT_KLEENE(TT);
							END;
				'"CP"':		BEGIN
								TT_POSITIVA(TT);
							END;
				'"PA"':		BEGIN		{HACE POR HERMANO<>NIL}
							END;
				'"PC"':		BEGIN		{HACE POR HERMANO<>NIL}
							END;
				#248:		BEGIN		{NO DEBE HACER NADA POR EPSILON DE GRAMATICA}
							END;
				ELSE
					AFNe(ARBOL^.Hijo,TT);
			END;
			IF ARBOL^.Hermano<>nil THEN
			BEGIN
				IF (ARBOL^.Hermano^.Hijo<>nil) THEN
					BEGIN
						IF(ARBOL^.Hermano^.Hijo^.Etiqueta.CompLex<>#248) THEN
						BEGIN
							CASE ARBOL^.Hermano^.Etiqueta.CompLex OF
								'<SR>':	BEGIN
											AFNe(ARBOL^.Hermano,TT1);
											TT_CONCAT(TT,TT1);
										END;
								'<SER>':BEGIN
											AFNe(ARBOL^.Hermano,TT1);
											TT_UNION(TT,TT1);
										END;
		{
								'<SC>':	BEGIN
											AFNe(ARBOL^.Hermano,TT);
										END;
								'<PER>':BEGIN
											AFNe(ARBOL^.Hermano,TT);
										END;
								'<ER>':BEGIN
											AFNe(ARBOL^.Hermano,TT);
										END;
		}							ELSE
										AFNe(ARBOL^.Hermano,TT);
							END;
						END;
					END
				ELSE
					IF ARBOL^.Hermano^.Etiqueta.CompLex = '"PC"' THEN
						AFNe(ARBOL^.Hermano,TT);
			END
		END;
	END;

{FINALES}
PROCEDURE AN_SINTACTICO (var ARCH_ER:T_ARCHIVO; var ARBOL:T_ARBOL; var OK:BOOLEAN);
	VAR TAS:t_tas;	ARCH_TAS:t_a_tas;	CONTROL_SINTAXIS:string;	ER: string;
	BEGIN
		OK:=FALSE;
		LEER(ARCH_ER,ER);
		ORIGINARTAS(ARCH_TAS,TAS);
		ARBOLSINTACTICO(ER,CONTROL_SINTAXIS,TAS,ARBOL);
		IF CONTROL_SINTAXIS='EXITO' THEN
			OK:=TRUE
		ELSE
		BEGIN
			WRITE('ERROR DE SINTAXIS'); READKEY;
		END;
		CERRARTAS(ARCH_TAS);
	END;

PROCEDURE GENERAR_AFNe (ARBOL:T_ARBOL; var AFN:AFN);
	VAR aux:T_AFNe;
	BEGIN
		IF ARBOL<>nil THEN
		BEGIN
			AFNe(ARBOL,AFN.Inicial);
			aux:=AFN.inicial;
			WHILE aux^.sig<>nil DO
				aux:=aux^.sig;
			AFN.aceptacion:=aux;
		END
		ELSE
		BEGIN
			write('ERROR');readkey;
		END;
	END;
PROCEDURE GENERAR_AFD (AFN:AFN; VAR AFD:AFD);
	VAR procesado,ultimo,MUERTO:T_AFD;	U:RESULTADO;	I:SIGMA;	NUMEROS:estados;
	BEGIN
		NUEVOESTADO(AFD.inicial);						(*ESTADO INICIAL CREADO INICIO*)
		AFD.Inicial^.estado:=1;
		AFD.Inicial^.tratado:=FALSE;
		AFD.Inicial^.sig:=nil;

		new(U);
		U^.estado:=AFN.inicial;
		U^.sig:=nil;
		NUMEROS:=[];
		U:=eCLAUSURA(U,NUMEROS);
		AFD.Inicial^.equivalentes:=U;					(*ESTADO INICIAL CREADO FIN*)

		procesado:=AFD.Inicial;
		WHILE (procesado<>nil)AND(procesado^.tratado=FALSE) DO
		BEGIN
			procesado^.tratado:=TRUE;
			FOR I:=N1 TO N73 DO
			BEGIN
				NUMEROS:=[];
				U:=eCLAUSURA(MUEVE(procesado^.equivalentes,I),NUMEROS);
				IF U<>nil THEN
				BEGIN
					ultimo:=AFD.Inicial;
					IF NOT(TRATADO(AFD.Inicial,EQUIVALENTES(U))) THEN
					BEGIN
						WHILE (ultimo^.sig<>nil) DO
							ultimo:=ultimo^.sig;
						NUEVOESTADO(ultimo^.sig);
						ultimo^.sig^.estado:=ultimo^.estado + 1;
						ultimo^.sig^.tratado:=FALSE;
						ultimo^.sig^.sig:=nil;
						ultimo^.sig^.equivalentes:=U;
					END
					ELSE
					BEGIN
						WHILE (EQUIVALENTES(ultimo^.sig^.equivalentes)<>EQUIVALENTES(U)) DO
							ultimo:=ultimo^.sig;
					END;
					new(procesado^.simbolo[I]);
					procesado^.simbolo[I]^.estado:=ultimo^.sig;
				END
				ELSE
					procesado^.simbolo[I]:=nil;
			END;

			procesado:=procesado^.sig;
		END;

		BEGIN											(*FINALES*)
		ultimo:=AFD.Inicial;							(*ESTADOS FINALES AÑADIDO INICIO*)
		new(AFD.Aceptacion);
		AFD.Aceptacion^.estado:=nil;
		WHILE ultimo<>nil DO
		BEGIN
			IF (AFN.Aceptacion^.estado IN EQUIVALENTES(ultimo^.equivalentes)) THEN
			BEGIN
				IF (AFD.Aceptacion^.estado<>nil) THEN
				BEGIN
					new(U^.sig);
					U^.sig^.estado:=ultimo;
					U:=U^.sig;
				END
				ELSE
				BEGIN
					AFD.Aceptacion^.estado:=ultimo;
					U:=AFD.Aceptacion;
				END;
			END;
			ultimo:=ultimo^.sig;
		END;											(*ESTADOS FINALES AÑADIDO FIN*)
		END;

		BEGIN											(*MUERTO*)
		NUEVOESTADO(MUERTO);							(*ESTADO MUERTO CREADO INICIO*)
		MUERTO^.estado:=0;
		MUERTO^.tratado:=TRUE;
		MUERTO^.sig:=nil;								(*ESTADO MUERTO CREADO FIN*)

		ultimo:=AFD.Inicial;							(*ESTADO MUERTO AÑADIDO INICIO*)
		WHILE ultimo^.sig<>nil DO
			ultimo:=ultimo^.sig;
		ultimo^.sig:=MUERTO;							(*ESTADO MUERTO AÑADIDO FIN*)

		ultimo:=AFD.Inicial;							(*DELTA A MUERTO AÑADIDO INICIO*)
		WHILE ultimo<>nil DO
		BEGIN
			FOR I:=N1 TO N73 DO
			BEGIN
				IF ultimo^.simbolo[I]=nil THEN
				BEGIN
					new(ultimo^.simbolo[I]);
					ultimo^.simbolo[I]^.estado:=MUERTO;
				END;
			END;
			ultimo:=ultimo^.sig;
		END;											(*DELTA A MUERTO AÑADIDO FIN*)
		END;

	END;

PROCEDURE GENERAR_AFDM (AFD:AFD; var AFDM:AFD);
	VAR L,AUX:L_PARTICION;	procesado,buscador:T_AFD;	U:RESULTADO;	F,NF:PARTICION;	I:SIGMA;
	BEGIN
		F.particion:=AFD.aceptacion;
		F.numeros:=EQUIVALENTES(AFD.aceptacion);
		F.aceptacion:=TRUE;
		F.sig:=nil;

		NF.particion:=nil;
		NF.numeros:=[];
		NF.aceptacion:=FALSE;

		procesado:=AFD.inicial;
		WHILE procesado<>nil DO
		BEGIN
			IF NOT (procesado^.estado IN F.numeros) THEN
			BEGIN
				NF.numeros:=NF.numeros+[procesado^.estado];
				IF NF.particion=nil THEN
				BEGIN
					new(NF.particion);
					U:=NF.particion;
				END
				ELSE
				BEGIN
					new(U^.sig);
					U:=U^.sig;
				END;
				U^.estado:=procesado;
				U^.sig:=nil;
			END;
			procesado:=procesado^.sig;
		END;							(*SEPARADOS FINALES (F) de NO FINALES (NF)*)

		new(NF.sig);
		NF.sig^:=F;
		new(L);
		L^:=NF;							(*CREADA LISTA DE PARTICIONES F y NF*)

		PARTICIONAR(L);					(*REPARTICIONADA*)

		AUX:=L;						(*BUSCAR LA PARTICION CON ESTADO EL INICIAL*)
		WHILE AUX<>nil DO
		BEGIN
			IF (1 IN AUX^.numeros) THEN
			BEGIN
				new(AFDm.Inicial);
				AFDm.Inicial^.estado:=0;
				AFDm.Inicial^.simbolo:=AUX^.particion^.estado^.simbolo;
				AFDm.Inicial^.sig:=nil;
				AFDm.Inicial^.Particion:=AUX;
				AUX:=nil;
			END
			ELSE
				AUX:=AUX^.sig;
		END;

		AUX:=L;
		procesado:=AFDm.Inicial;
		WHILE AUX<>nil DO				(*POR CADA PARTICION (NO LA INICIAL) SE CREA UN ESTADO NUEVO*)
		BEGIN							(*CON EL PRIMER ESTADO DE CADA PARTICION COMO REPRESENTANTE*)
			IF NOT(1 IN AUX^.numeros) THEN
			BEGIN
				new(procesado^.sig);
				procesado^.sig^.estado:=procesado^.estado + 1;
				procesado^.sig^.simbolo:=AUX^.particion^.estado^.simbolo;
				procesado^.sig^.sig:=nil;
				procesado^.sig^.Particion:=AUX;
				procesado:=procesado^.sig;
			END;
			AUX:=AUX^.sig;
		END;

		FOR I:=N1 TO N73 DO				(*PARA CADA SIMBOLO REEMPLAZAR, EN CADA TRANSICION, EL ESTADO AL QUE APUNTA*)
		BEGIN									(*POR EL REPRESENTANTE DE SU PARTICIÓN*)
			procesado:=AFDm.Inicial;
			WHILE procesado<>nil DO
			BEGIN
				AUX:=L;
				WHILE AUX<>nil DO
				BEGIN
					IF procesado^.simbolo[I]^.estado^.estado IN AUX^.numeros THEN
					BEGIN
						buscador:=AFDm.Inicial;
						WHILE buscador<>nil DO
						BEGIN
							IF buscador^.Particion = AUX THEN
							BEGIN
								procesado^.simbolo[I]^.estado:=buscador;
								procesado^.simbolo[I]^.sig:=nil;
								buscador:=nil;
							END
							ELSE
								buscador:=buscador^.sig;
						END;
						AUX:=nil;
					END
					ELSE
						AUX:=AUX^.sig;
				END;
				procesado:=procesado^.sig;
			END;
		END;

		BEGIN							(*ENLISTAR ESTADOS FINALES:	INICIO*)
		procesado:=AFDm.inicial;
		AFDm.aceptacion:=nil;
		WHILE procesado<>nil DO
		BEGIN
			IF procesado^.particion^.aceptacion THEN
			BEGIN
				IF AFDm.aceptacion <> nil THEN
					ADDTOEND(AFDm.aceptacion,procesado)
				ELSE
				BEGIN
					new(AFDm.aceptacion);
					AFDm.aceptacion^.estado:=procesado;
					AFDm.aceptacion^.sig:=nil;
				END;
			END;
			procesado:=procesado^.sig;
		END;
		END;							(*ENLISTAR ESTADOS FINALES:	FIN*)
	END;


END.
