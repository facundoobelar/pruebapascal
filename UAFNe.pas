UNIT UAFNe;
INTERFACE
	USES TYPES, UTAS,crt;
	FUNCTION CARDINALIDAD (NUMEROS:estados):integer;
	PROCEDURE NUEVOESTADO (var TT:T_AFNe);
	FUNCTION EQUIVALENTES (U:RESULTADO):estados;
	PROCEDURE TT_CAR (var TT:T_AFNe; Lexema:char);	{Tabla de Transición Para un Símbolo CAR de SIGMA}
	PROCEDURE TT_EPSILON (var TT:T_AFNe);	{Tabla de Transición Para EPSILON}
	PROCEDURE TT_VACIO (var TT:T_AFNe);	{Tabla de Transición Para un VACIO}
	PROCEDURE TT_CONCAT (var TT:T_AFNe; var TT1:T_AFNe);
	PROCEDURE TT_UNION (var TT:T_AFNe; var TT1:T_AFNe);
	PROCEDURE TT_KLEENE (var TT:T_AFNe);
	PROCEDURE TT_POSITIVA (var TT:T_AFNe);
	FUNCTION MUEVE (T:RESULTADO;SIMBOLO:SIGMA):RESULTADO;
	FUNCTION eCLAUSURA (T:RESULTADO;var NUMEROS:estados):RESULTADO;
	FUNCTION TRATADO (AFD:T_AFD; NUMEROS:estados):BOOLEAN;
	PROCEDURE ADDTOEND(var P:RESULTADO;estado:T_AFD);
	PROCEDURE PARTICIONAR (var L:L_PARTICION);

IMPLEMENTATION
FUNCTION CARDINALIDAD (NUMEROS:estados):integer;
	VAR x:integer;
	BEGIN
		CARDINALIDAD:=0;
		FOR x:=0 TO 255 DO
		BEGIN
			IF x IN NUMEROS THEN
				INC(CARDINALIDAD);
		END;
	END;
PROCEDURE NUEVOESTADO (var TT:T_AFNe);
	VAR I:SIGMA;
	BEGIN
		new(TT);
		FOR I:=N1 TO EPS DO
			TT^.SIMBOLO[I]:=nil;
	END;
FUNCTION EQUIVALENTES (U:RESULTADO):estados;
	BEGIN
		EQUIVALENTES:=[];
		WHILE U<>nil DO
		BEGIN
			EQUIVALENTES:= EQUIVALENTES+[U^.estado^.estado];
			U:=U^.sig;
		END;
	END;
PROCEDURE TT_CAR (var TT:T_AFNe; Lexema:char);
	BEGIN
		NUEVOESTADO(TT);
		TT^.estado:=0;

		NUEVOESTADO(TT^.sig);
		TT^.sig^.estado:=1;
		TT^.sig^.sig:=nil;

		NEW(TT^.simbolo[COLAFN(Lexema)]);
		TT^.simbolo[COLAFN(Lexema)]^.estado:=TT^.sig;
		TT^.simbolo[COLAFN(Lexema)]^.sig:=nil;
	END;
PROCEDURE TT_EPSILON (var TT:T_AFNe);	{Tabla de Transición Para EPSILON}
	BEGIN
		NUEVOESTADO(TT);
		TT^.estado:=0;

		NUEVOESTADO(TT^.sig);
		TT^.sig^.estado:=1;
		TT^.sig^.sig:=nil;

		NEW(TT^.simbolo[EPS]);
		TT^.simbolo[EPS]^.estado:=TT^.sig;
		TT^.simbolo[EPS]^.sig:=nil;
	END;
PROCEDURE TT_VACIO (var TT:T_AFNe);	{Tabla de Transición Para un VACIO}
	BEGIN
		NUEVOESTADO(TT);
		TT^.estado:=0;

		NUEVOESTADO(TT^.sig);
		TT^.sig^.estado:=1;
		TT^.sig^.sig:=nil;
	END;
PROCEDURE TT_CONCAT (var TT:T_AFNe; var TT1:T_AFNe);
	VAR aux:T_AFNe;
	BEGIN
		IF TT<>nil THEN
		BEGIN
			aux:=TT;
			WHILE aux^.sig<>nil DO
				aux:=aux^.sig;
			aux^.sig:=TT1;
			new(aux^.simbolo[EPS]);
			aux^.simbolo[EPS]^.estado:=TT1;
			new(aux^.simbolo[EPS]^.sig);
			aux^.simbolo[EPS]^.sig:=nil;
			WHILE aux^.sig<>nil DO
			BEGIN
				aux^.sig^.estado:=aux^.estado+1;
				aux:=aux^.sig;
			END;
		END
		ELSE
			IF TT1<>nil THEN
				TT:=TT1;
	END;
PROCEDURE TT_UNION (var TT:T_AFNe; var TT1:T_AFNe);
	VAR pri,aux,fin:T_AFNe;
	BEGIN
		NUEVOESTADO(pri);
		pri^.estado:=0;

		NUEVOESTADO(fin);
		fin^.sig:=nil;
		new(pri^.simbolo[EPS]);
		pri^.simbolo[EPS]^.estado:=TT;
		new(pri^.simbolo[EPS]^.sig);
		pri^.simbolo[EPS]^.sig^.estado:=TT1;
		pri^.simbolo[EPS]^.sig^.sig:=nil;
		pri^.sig:=TT;

		aux:=pri;
		WHILE aux^.sig<>nil DO
		BEGIN
			aux^.sig^.estado:=aux^.estado+1;
			aux:=aux^.sig;
		END;
		new(aux^.simbolo[EPS]);
		aux^.simbolo[EPS]^.estado:=fin;

		aux^.sig:=TT1;
		WHILE aux^.sig<>nil DO
		BEGIN
			aux^.sig^.estado:=aux^.estado+1;
			aux:=aux^.sig;
		END;
		new(aux^.simbolo[EPS]);
		aux^.simbolo[EPS]^.estado:=fin;
		aux^.sig:=fin;
		fin^.estado:=aux^.estado+1;
		TT:=pri;
	END;
PROCEDURE TT_KLEENE (var TT:T_AFNe);
	VAR pri,aux,fin:T_AFNe;
	BEGIN
		NUEVOESTADO(pri);
		pri^.estado:=0;

		NUEVOESTADO(fin);
		fin^.sig:=nil;

		new(pri^.simbolo[EPS]);
		pri^.simbolo[EPS]^.estado:=TT;
		new(pri^.simbolo[EPS]^.sig);
		pri^.simbolo[EPS]^.sig^.estado:=fin;
		pri^.simbolo[EPS]^.sig^.sig:=nil;
		pri^.sig:=TT;

		aux:=pri;
		WHILE aux^.sig<>nil DO
		BEGIN
			aux^.sig^.estado:=aux^.estado+1;
			aux:=aux^.sig;
		END;
		new(aux^.simbolo[EPS]);
		aux^.simbolo[EPS]^.estado:=TT;
		new(aux^.simbolo[EPS]^.sig);
		aux^.simbolo[EPS]^.sig^.estado:=fin;
		aux^.simbolo[EPS]^.sig^.sig:=nil;
		aux^.sig:=fin;
		fin^.estado:=aux^.estado+1;
		TT:=pri;
	END;
PROCEDURE TT_POSITIVA (var TT:T_AFNe);
	VAR pri,aux,fin:T_AFNe;
	BEGIN
		NUEVOESTADO(pri);
		pri^.estado:=0;

		NUEVOESTADO(fin);
		fin^.sig:=nil;

		new(pri^.simbolo[EPS]);
		pri^.simbolo[EPS]^.estado:=TT;
		pri^.simbolo[EPS]^.sig:=nil;
		pri^.sig:=TT;

		aux:=pri;
		WHILE aux^.sig<>nil DO
		BEGIN
			aux^.sig^.estado:=aux^.estado+1;
			aux:=aux^.sig;
		END;

		new(aux^.simbolo[EPS]);
		aux^.simbolo[EPS]^.estado:=TT;
		new(aux^.simbolo[EPS]^.sig);
		aux^.simbolo[EPS]^.sig^.estado:=fin;
		aux^.simbolo[EPS]^.sig^.sig:=nil;
		aux^.sig:=fin;
		fin^.estado:=aux^.estado+1;
		TT:=pri;
	END;
FUNCTION MUEVE (T:RESULTADO;SIMBOLO:SIGMA):RESULTADO;
	BEGIN
		IF T<>nil THEN
		BEGIN
			IF T^.estado^.simbolo[SIMBOLO]<>nil THEN
			BEGIN
				new(MUEVE);
				MUEVE^.estado:=T^.estado^.simbolo[SIMBOLO]^.estado;
				MUEVE^.sig:=MUEVE(T^.sig,SIMBOLO);
			END
			ELSE
				MUEVE:=MUEVE(T^.sig,SIMBOLO)
		END
		ELSE
			MUEVE:=nil;
	END;
FUNCTION eCLAUSURA (T:RESULTADO;var NUMEROS:estados):RESULTADO;
	VAR aux1,aux2:RESULTADO;
	BEGIN
		IF (T<>nil)AND(T^.estado<>nil) THEN
		BEGIN
			new(eCLAUSURA);
			aux1:=eCLAUSURA;
			aux2:=T;
			aux1^.estado:=aux2^.estado;
			aux1^.sig:=nil;
			WHILE aux2^.sig<>nil DO
			BEGIN
				aux2:=aux2^.sig;
				new(aux1^.sig);
				aux1:=aux1^.sig;
				aux1^.estado:=aux2^.estado;
			END;
			WHILE T<>nil DO
			BEGIN
				IF (T^.estado^.simbolo[EPS]<>nil)AND(NOT(T^.estado^.simbolo[EPS]^.estado^.estado IN NUMEROS)) THEN
					aux1^.sig:=eCLAUSURA(T^.estado^.simbolo[EPS],NUMEROS);
				NUMEROS:=NUMEROS + [T^.estado^.estado];
				WHILE aux1^.sig<>nil DO
					aux1:=aux1^.sig;
				T:=T^.sig;
			END;
		END
		ELSE
			eCLAUSURA:=nil;
	END;
FUNCTION TRATADO (AFD:T_AFD; NUMEROS:estados):BOOLEAN;
VAR AUX:T_AFD;
BEGIN
	AUX:=AFD;
	TRATADO:=FALSE;
	WHILE (AUX<>nil)AND(TRATADO=FALSE) DO
	BEGIN
		IF (EQUIVALENTES(AUX^.equivalentes) = NUMEROS) THEN
			TRATADO:=TRUE
		ELSE
			AUX:= AUX^.sig;
	END;
END;
PROCEDURE ADDTOEND(var P:RESULTADO; estado:T_AFD);
	VAR aux:RESULTADO;
	BEGIN
		aux:=P;
		WHILE aux^.sig<>nil DO
			aux:=aux^.sig;
		new(aux^.sig);
		aux^.sig^.estado:=estado;
		aux^.sig^.sig:=nil;
	END;
PROCEDURE PARTICIONAR (var L:L_PARTICION);
	VAR	NUEVAi,NUEVAd,PRIMERO,AUX:L_PARTICION;	procesada:RESULTADO;	I:SIGMA;	ENCONTRADO,PARTICIONADO:BOOLEAN;
	BEGIN
		AUX:=L;
		WHILE AUX<>nil DO
		BEGIN
			IF CARDINALIDAD(AUX^.numeros)>1 THEN
			BEGIN
				I:=N1;
				PARTICIONADO:=FALSE;
				WHILE (I<EPS)AND(NOT(PARTICIONADO)) DO																(*PARTICIONAR EN IGUALES Y DESIGUALES: INICIO*)
				BEGIN
					new(NUEVAi);				(*CREAR PARTICION POR IGUALES*)
					NUEVAi^.numeros:=[];
					NUEVAi^.aceptacion:=AUX^.aceptacion;
					NUEVAi^.particion:=nil;
					NUEVAi^.sig:=nil;

					new(NUEVAd);				(*CREAR PARTICION POR DISTINTOS*)
					NUEVAd^.numeros:=[];
					NUEVAd^.aceptacion:=AUX^.aceptacion;
					NUEVAd^.particion:=nil;
					NUEVAd^.sig:=nil;

					procesada:=AUX^.PARTICION;				(*PARTICION PROCESADA PARA PARTICIONAR*)

					PRIMERO:=L;											(*HALLAR A QUE PARTICION APUNTA EL PRIMERO POR I: INICIO*)
					ENCONTRADO:=FALSE;
					WHILE NOT(ENCONTRADO) DO
					BEGIN
						IF procesada^.estado^.simbolo[I]^.estado^.estado IN PRIMERO^.NUMEROS THEN
							ENCONTRADO:=TRUE
						ELSE
							PRIMERO:=PRIMERO^.sig;
					END;													(*HALLAR A QUE PARTICION APUNTA EL PRIMERO POR I: FIN*)

					WHILE procesada<>nil DO										(*SEPARAR LOS QUE APUNTAN A LA MISMA PARTICION POR I DE LOS QUE NO: INICIO*)
					BEGIN
						IF procesada^.estado^.simbolo[I]^.estado^.estado IN PRIMERO^.NUMEROS THEN
						BEGIN
							IF NUEVAi^.PARTICION<>nil THEN
								ADDTOEND(NUEVAi^.PARTICION,procesada^.estado)
							ELSE
							BEGIN
								new(NUEVAi^.PARTICION);
								NUEVAi^.PARTICION^.estado:=procesada^.estado;
								NUEVAi^.PARTICION^.sig:=nil;
							END;
							NUEVAi^.numeros:=NUEVAi^.numeros + [procesada^.estado^.estado];
						END
						ELSE
						BEGIN
							IF NUEVAd^.PARTICION<>nil THEN
								ADDTOEND(NUEVAd^.PARTICION,procesada^.estado)
							ELSE
							BEGIN
								new(NUEVAd^.PARTICION);
								NUEVAd^.PARTICION^.estado:=procesada^.estado;
								NUEVAd^.PARTICION^.sig:=nil;
								PARTICIONADO:=TRUE;
							END;
							NUEVAd^.numeros:=NUEVAd^.numeros + [procesada^.estado^.estado];
						END;
						procesada:=procesada^.sig;
					END;															(*SEPARAR LOS QUE APUNTAN A LA MISMA PARTICION POR I DE LOS QUE NO: FIN*)
					INC(I);
				END;																							(*PARTICIONAR EN IGUALES Y DESIGUALES: FIN*)
				IF NOT(PARTICIONADO) THEN
				BEGIN
					AUX:=AUX^.sig;
					DISPOSE(NUEVAd);
					DISPOSE(NUEVAi^.particion);
					DISPOSE(NUEVAi);
				END
				ELSE
				BEGIN
					NUEVAd^.sig:=AUX^.sig;
					NUEVAi^.sig:=NUEVAd;
					AUX^:=NUEVAi^;
					DISPOSE(NUEVAi);
				END;
			END
			ELSE
				AUX:=AUX^.sig;
		END;
	END;
END.
