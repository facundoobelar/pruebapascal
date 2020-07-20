UNIT TYPES;
INTERFACE
CONST
	CARACTER=[#40..#59,#64..'Z','a'..'z'];

TYPE
	estados=set of 0..255;
	T_ETIQUETA=RECORD
						CompLex:string;
						Lexema:char;
					END;

{TAS}
	COLUMNA= (CAR,EPSILON,VACIO,PA,PC,CK,CP,UNION,PESOS);
	SIGMA=(N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,N13,N14,N15,N16,N17,N18,N19,N20,N21,N22,N23,N24,N25,N26,N27,N28,N29,N30,N31,N32,N33,N34,N35,N36,N37,N38,N39,N40,N41,N42,N43,N44,N45,N46,N47,N48,N49,N50,N51,N52,N53,N54,N55,N56,N57,N58,N59,N60,N61,N62,N63,N64,N65,N66,N67,N68,N69,N70,N71,N72,N73,EPS);
	FILA= (ER,SER,PER,SR,RE,SC,SIM);
   T_TAS= array [FILA,COLUMNA] of STRING;

{ARBOL}
   T_ARBOL=^T_N_ARBOL;
   T_N_ARBOL= record
				Etiqueta:T_ETIQUETA;
				Hijo:T_ARBOL;
				Hermano:T_ARBOL;
			   end;

{PILA}
   T_DATO_PILA= record
					DirArbol:T_ARBOL;
					Etiqueta:T_ETIQUETA;
				 end;
   T_PILA= ^T_N_PILA;
   T_N_PILA= record
				Info: T_DATO_PILA;
				sig: T_Pila;
			  end;

{ARCHIVOS}
	T_ARCHIVO= TEXT;
	T_A_TAS= FILE OF T_TAS;
	T_A_AFD= TEXT;

{AF}
	L_PARTICION=^PARTICION;
	RESULTADO= ^T_RESULTADO;
	T_AFNe=	^T_ESTADO;
	T_RESULTADO= 	record
						estado:T_AFNe;
						sig:RESULTADO;
					end;
	T_ESTADO= 	record
					estado:integer;	{AFNe AFD y AFDm}
					tratado:boolean;	{AFD}
					equivalentes: RESULTADO;	{AFD}
					simbolo:array [SIGMA] of RESULTADO;	{AFNe AFD y AFDm}
					sig: T_AFNe;	{AFNe AFD y AFDm}
					particion: L_PARTICION;	{AFDm}
				end;
	AFN=	record
				inicial:T_AFNe;
				aceptacion:T_AFNe;
			end;
	T_AFD= 	T_AFNe;
	AFD=	record
				inicial:T_AFD;
				aceptacion:RESULTADO;
			end;
	PARTICION= 	record
					particion: RESULTADO;	{ESTADOS DE LA PARTICION}
					numeros: estados;	{ESTADOS DE LA PARTICION}
					aceptacion:boolean;
					sig: L_PARTICION;	{SIGUIENTE PARTICION}
				end;

	FUNCTION GETCOL (CARA:string):COLUMNA;	{equivalente a conseguir TOKENS}
	FUNCTION InvGETCOL (CARA:COLUMNA):string;
	FUNCTION COLAFN (CAR:char):SIGMA;
	FUNCTION InvCOLAFN (LEXEMA:SIGMA):string;
	FUNCTION GETROW (PROD:string):FILA;

IMPLEMENTATION
FUNCTION GETCOL (CARA:string):COLUMNA;
	VAR I:char;
	BEGIN
		FOR I:=#0 TO #255 DO
		BEGIN
		IF (I IN CARACTER)AND(CARA=I)THEN
			GETCOL:=CAR
		ELSE
		BEGIN
			case CARA of
				'&':GETCOL:=EPSILON;
				#248:GETCOL:=EPSILON;
				'~':GETCOL:=VACIO;
				'|':GETCOL:=UNION;
				'^':GETCOL:=CK;
				'!':GETCOL:=CP;
				'<':GETCOL:=PA;
				'>':GETCOL:=PC;
				'$':GETCOL:=PESOS;
			end;
		END;
		END;
	END;
FUNCTION InvGETCOL (CARA:COLUMNA):string;
	BEGIN
		case CARA of
			CAR:InvGETCOL:='"CAR"';
			EPSILON:InvGETCOL:='"EPSILON"';
			VACIO:InvGETCOL:='"VACIO"';
			UNION:InvGETCOL:='"UNION"';
			CK:InvGETCOL:='"CK"';
			CP:InvGETCOL:='"CP"';
			PA:InvGETCOL:='"PA"';
			PC:InvGETCOL:='"PC"';
			PESOS:InvGETCOL:=#248;
		END;
	END;
FUNCTION COLAFN (CAR:char):SIGMA;
	BEGIN
		case CAR of
			'a':COLAFN:=N1;
			'b':COLAFN:=N2;
			'c':COLAFN:=N3;
			'd':COLAFN:=N4;
			'e':COLAFN:=N5;
			'f':COLAFN:=N6;
			'g':COLAFN:=N7;
			'h':COLAFN:=N8;
			'i':COLAFN:=N9;
			'j':COLAFN:=N10;
			'k':COLAFN:=N11;
			'l':COLAFN:=N12;
			'm':COLAFN:=N13;
			'n':COLAFN:=N14;
			'o':COLAFN:=N15;
			'p':COLAFN:=N16;
			'q':COLAFN:=N17;
			'r':COLAFN:=N18;
			's':COLAFN:=N19;
			't':COLAFN:=N20;
			'u':COLAFN:=N21;
			'v':COLAFN:=N22;
			'w':COLAFN:=N23;
			'x':COLAFN:=N24;
			'y':COLAFN:=N25;
			'z':COLAFN:=N26;
			'A':COLAFN:=N27;
			'B':COLAFN:=N28;
			'C':COLAFN:=N29;
			'D':COLAFN:=N30;
			'E':COLAFN:=N31;
			'F':COLAFN:=N32;
			'G':COLAFN:=N33;
			'H':COLAFN:=N34;
			'I':COLAFN:=N35;
			'J':COLAFN:=N36;
			'K':COLAFN:=N37;
			'L':COLAFN:=N38;
			'M':COLAFN:=N39;
			'N':COLAFN:=N40;
			'O':COLAFN:=N41;
			'P':COLAFN:=N42;
			'Q':COLAFN:=N43;
			'R':COLAFN:=N44;
			'S':COLAFN:=N45;
			'T':COLAFN:=N46;
			'U':COLAFN:=N47;
			'V':COLAFN:=N48;
			'W':COLAFN:=N49;
			'X':COLAFN:=N50;
			'Y':COLAFN:=N51;
			'Z':COLAFN:=N52;
			'0':COLAFN:=N53;
			'1':COLAFN:=N54;
			'2':COLAFN:=N55;
			'3':COLAFN:=N56;
			'4':COLAFN:=N57;
			'5':COLAFN:=N58;
			'6':COLAFN:=N59;
			'7':COLAFN:=N60;
			'8':COLAFN:=N61;
			'9':COLAFN:=N62;
			#64:COLAFN:=N63;
			#40:COLAFN:=N64;
			#41:COLAFN:=N65;
			#42:COLAFN:=N66;
			#43:COLAFN:=N67;
			#44:COLAFN:=N68;
			#45:COLAFN:=N69;
			#46:COLAFN:=N70;
			#47:COLAFN:=N71;
			#58:COLAFN:=N72;
			#59:COLAFN:=N73;
			'&':COLAFN:=EPS;
		END;
	END;
FUNCTION InvCOLAFN (LEXEMA:SIGMA):string;
	BEGIN
		case LEXEMA of
			N1:InvCOLAFN:='a';
			N2:InvCOLAFN:='b';
			N3:InvCOLAFN:='c';
			N4:InvCOLAFN:='d';
			N5:InvCOLAFN:='e';
			N6:InvCOLAFN:='f';
			N7:InvCOLAFN:='g';
			N8:InvCOLAFN:='h';
			N9:InvCOLAFN:='i';
			N10:InvCOLAFN:='j';
			N11:InvCOLAFN:='k';
			N12:InvCOLAFN:='l';
			N13:InvCOLAFN:='m';
			N14:InvCOLAFN:='n';
			N15:InvCOLAFN:='o';
			N16:InvCOLAFN:='p';
			N17:InvCOLAFN:='q';
			N18:InvCOLAFN:='r';
			N19:InvCOLAFN:='s';
			N20:InvCOLAFN:='t';
			N21:InvCOLAFN:='u';
			N22:InvCOLAFN:='v';
			N23:InvCOLAFN:='w';
			N24:InvCOLAFN:='x';
			N25:InvCOLAFN:='y';
			N26:InvCOLAFN:='z';
			N27:InvCOLAFN:='A';
			N28:InvCOLAFN:='B';
			N29:InvCOLAFN:='C';
			N30:InvCOLAFN:='D';
			N31:InvCOLAFN:='E';
			N32:InvCOLAFN:='F';
			N33:InvCOLAFN:='G';
			N34:InvCOLAFN:='H';
			N35:InvCOLAFN:='I';
			N36:InvCOLAFN:='J';
			N37:InvCOLAFN:='K';
			N38:InvCOLAFN:='L';
			N39:InvCOLAFN:='M';
			N40:InvCOLAFN:='N';
			N41:InvCOLAFN:='O';
			N42:InvCOLAFN:='P';
			N43:InvCOLAFN:='Q';
			N44:InvCOLAFN:='R';
			N45:InvCOLAFN:='S';
			N46:InvCOLAFN:='T';
			N47:InvCOLAFN:='U';
			N48:InvCOLAFN:='V';
			N49:InvCOLAFN:='W';
			N50:InvCOLAFN:='X';
			N51:InvCOLAFN:='Y';
			N52:InvCOLAFN:='Z';
			N53:InvCOLAFN:='0';
			N54:InvCOLAFN:='1';
			N55:InvCOLAFN:='2';
			N56:InvCOLAFN:='3';
			N57:InvCOLAFN:='4';
			N58:InvCOLAFN:='5';
			N59:InvCOLAFN:='6';
			N60:InvCOLAFN:='7';
			N61:InvCOLAFN:='8';
			N62:InvCOLAFN:='9';
			N63:InvCOLAFN:=#64;
			N64:InvCOLAFN:=#40;
			N65:InvCOLAFN:=#41;
			N66:InvCOLAFN:=#42;
			N67:InvCOLAFN:=#43;
			N68:InvCOLAFN:=#44;
			N69:InvCOLAFN:=#45;
			N70:InvCOLAFN:=#46;
			N71:InvCOLAFN:=#47;
			N72:InvCOLAFN:=#58;
			N73:InvCOLAFN:=#59;
			EPS:INVCOLAFN:='&';
		END;
	END;
FUNCTION GETROW (PROD:string):FILA;
	BEGIN
		case PROD of
			'<ER>':GETROW:=ER;
			'<SER>':GETROW:=SER;
			'<PER>':GETROW:=PER;
			'<SR>':GETROW:=SR;
			'<RE>':GETROW:=RE;
			'<SC>':GETROW:=SC;
			'<SIM>':GETROW:=SIM;
		end;
	END;


END.
