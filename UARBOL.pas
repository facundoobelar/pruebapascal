UNIT UARBOL;
INTERFACE
	USES TYPES;
	PROCEDURE CREARARBOL (var arbol: T_ARBOL);
	PROCEDURE PARTBACKUS (var backcomp:string; var uni:string);
	PROCEDURE HERMANOS (var arbol: T_ARBOL; etiqueta:string; Lexema:char);
	PROCEDURE CARGARARBOL (var arbol: T_ARBOL; backprod:string; Lexema:char);
	PROCEDURE ELIMINARARBOL (var arbol: T_ARBOL);
	PROCEDURE RECORRER_ARBOL (var arbol:T_ARBOL);

IMPLEMENTATION
PROCEDURE CREARARBOL (var arbol: T_ARBOL);
	BEGIN
		new(arbol);
		arbol^.Hijo:=nil;
		arbol^.Hermano:=nil;
	END;
PROCEDURE PARTBACKUS (var backcomp:string; var uni:string);
	VAR aux:char; I:integer;
	BEGIN
		I:=1;
		IF backcomp<>#248 then
			BEGIN
			IF backcomp[1]='"' then
				aux:='"'
			ELSE
				IF backcomp[1]='<' then
					aux:='>';
			INC(I);
			WHILE backcomp[I]<>aux do
				INC(I);
			uni:=copy(backcomp,1,I);
			delete(backcomp,1,I);
		END
		ELSE
		BEGIN
			uni:=backcomp;
			backcomp:='';
		END;

	END;
PROCEDURE HERMANOS (var arbol: T_ARBOL; etiqueta:string; Lexema:char);
	BEGIN
		CREARARBOL(arbol^.Hermano);
		arbol^.Hermano^.Etiqueta.CompLex:=Etiqueta;
		arbol^.Hermano^.Etiqueta.Lexema:=Lexema;
	END;
PROCEDURE CARGARARBOL (var arbol: T_ARBOL; backprod:string; Lexema:char);
	VAR comp:string; aux:T_ARBOL;
	BEGIN
		PARTBACKUS(backprod,comp);
		CREARARBOL(arbol^.Hijo);
		arbol^.Hijo^.Etiqueta.CompLex:=comp;
		arbol^.Hijo^.Etiqueta.Lexema:=Lexema;
		aux:=arbol^.Hijo;
		WHILE backprod<>'' DO
			BEGIN
				PARTBACKUS(backprod,comp);
				HERMANOS(aux,comp,Lexema);
				aux:=aux^.Hermano;
			END;
	END;
PROCEDURE ELIMINARARBOL (var arbol: T_ARBOL);
BEGIN
	IF arbol<>nil THEN
	BEGIN
		ELIMINARARBOL(arbol^.Hijo);
		ELIMINARARBOL(arbol^.Hermano);
		dispose(arbol);
	END;
END;
PROCEDURE RECORRER_ARBOL (var arbol:T_ARBOL);
	BEGIN
		IF arbol<>nil THEN
		BEGIN
			RECORRER_ARBOL(arbol^.Hijo);
			RECORRER_ARBOL(arbol^.Hermano);
			Write(arbol^.etiqueta.CompLex,'(',arbol^.etiqueta.Lexema,')',' | ');
		END;
	END;
END.
