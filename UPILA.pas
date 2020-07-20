UNIT UPILA;
INTERFACE
	USES TYPES;
	PROCEDURE CREARPILA (var pila: T_PILA);
	PROCEDURE APILAR (var pila: T_PILA; info:T_DATO_PILA);
	PROCEDURE DESAPILAR (var pila: T_PILA; var info:T_DATO_PILA);
	PROCEDURE APILARPROD (var pila: T_PILA; arbol:T_ARBOL);
	PROCEDURE BORRARPILA (var pila:T_PILA);

IMPLEMENTATION
PROCEDURE CREARPILA (var pila: T_PILA);
	BEGIN
		pila:=nil;
	end;
PROCEDURE APILAR (var pila: T_PILA; info:T_DATO_PILA);
	VAR dir:T_PILA;
	BEGIN
		new(dir);
		dir^.info:=info;
		dir^.sig:=pila;
		pila:=dir;
	END;
PROCEDURE DESAPILAR (var pila: T_PILA; var info:T_DATO_PILA);
	VAR aux:T_PILA;
	BEGIN
		info:=pila^.Info;
		aux:=pila;
		pila:=pila^.sig;
		dispose(aux);
	END;
PROCEDURE APILARPROD (var pila: T_PILA; arbol:T_ARBOL);
	VAR Info:T_DATO_PILA;
	BEGIN
		IF arbol<>nil THEN
			BEGIN
				APILARPROD(pila,arbol^.Hermano);
				Info.Etiqueta:=arbol^.Etiqueta;
				Info.DirArbol:=arbol;
				APILAR(pila,Info);
			END;
	END;
PROCEDURE BORRARPILA (var pila:T_PILA);
	VAR aux:T_PILA;
	BEGIN
		While(pila<>nil) do
		BEGIN
			aux:=pila;
			pila:=Pila^.sig;
			dispose(aux);
		END;
	END;
END.
