#include "Directry.ch"


function TestDir()  

	local cRuta:="C:\hb30\tests" 					// inicio de busqueda desde esta ruta
	//LOCAL aFFList := HB_DirScan(cRuta,,"D")		//otra manera de explorar carpetas
	
	setmode (25,80)
	clear screen
	
	despliegaContenido(cRuta)


RETURN NIL




function despliegaContenido(ruta)  			//muestra en pantalla el contenido de una carpeta
	
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
		seleccion(aFFList[nChoice],ruta) 
	endif
	
return nil 
 
 
 
 
function seleccion(sel,ruta) // sel: es el subarreglo con la informacion de cada archivo o carpeta

	local lastRoute

	if sel[1]==".." 	//Regresa a la carpeta anterior
	
		lastRoute:=BeforAtNum( "\", ruta )	
		despliegaContenido(lastRoute)		//muestra el contenido de la carpeta anterior
	
	elseif sel[1]=="." 	//
		despliegaContenido(ruta)

	elseif sel[5]="A" //Seleccion de archivo, se termina el proceso cuando se cumple esta condicion
	
		HB_Alert( "La ruta es: "+ruta+"\"+sel[1],,"W+/B",)
		clear screen
		quit
		
	elseif sel[5]="D" //Abrir carpeta
	
		Qout( "Seleccionaste la carpeta" ,sel[1])
		qout(ruta)
		despliegaContenido(ruta+"\"+sel[1])
	end if
	
return nil

 