# include "hbclass.ch"
# include "directry.ch"

PROCEDURE Main()

	LOCAL oExplr := Explorer():New()	//objeto de tipo Explorer
	//LOCAL oExplr1 := Explorer():New()
	
	SetMode (25,80)
	CLEAR SCREEN
	
	oExplr:cRuta :="C:\hb30\tests"	//la busqueda se inicia en este directorio
	
	oExplr:despliegaContenido(oExplr:cRuta)
	//oExplr1:despliegaContenido("C:")
	
RETURN

//-------------------------    C L A S E    --------

CLASS Explorer

	DATA cRuta
	
	METHOD despliegaContenido(ruta)
	METHOD seleccion(sel,ruta)
	
END CLASS
//-------------------------    M E T O D O S   D E   C L A S E    --------

METHOD despliegaContenido (ruta) CLASS  Explorer
	
	local aItems:={} // arreglo de cadenas que solo tendrá los nombres de los archivos y carpetas
	local x1Row
	local nChoice
	LOCAL aFFList := Directory(ruta+"\*.*", "D")	//crea una matriz bidimensional con la informacion de los archivos y carpetas de la ruta recibida	
	clear screen
	? ruta
	
	FOR EACH x1Row IN aFFList
		AAdd( aItems,x1Row[1] ) //guarda en aItems todos los nombres de los archivos y carpetas
	NEXT x1Row
	
	nChoice := AChoice( 5, 5, 40, 25,aItems)	// despliega en pantalla el nombre de todos los archivos y carpetas contenidos en la ruta
	
	IF nChoice==0 		//nChoice=0 cuando presiona esc
		clear screen
		quit  			//termina el programa si se presiona esc
	ELSE
		::seleccion(aFFList[nChoice],ruta) 
	endif

RETURN NIL


METHOD seleccion(sel,ruta) CLASS Explorer

	local lastRoute

	if sel[1]==".." 	//Regresa a la carpeta anterior
	
		lastRoute:=BeforAtNum( "\", ruta )	
		::despliegaContenido(lastRoute)		//muestra el contenido de la carpeta anterior
	
	elseif sel[1]=="." 	//Se queda en la misma carpeta
		::despliegaContenido(ruta)

	elseif sel[5]="A" //Seleccion de archivo, se termina el proceso cuando se cumple esta condicion
	
		HB_Alert( "La ruta es: "+ruta+"\"+sel[1],,"W+/B",)
		clear screen
		
	elseif sel[5]="D" //Abrir carpeta
		::despliegaContenido(ruta+"\"+sel[1])
	end if

RETURN NIL

