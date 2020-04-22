
#include "Directry.ch"
FUNCTION Main()

   LOCAL i, j 
   LOCAL aDirectory:={}//Arreglo inicial principal, este contendr  sub arreglos 
   LOCAL aDirNames:={} //En este arreglo se guardaran los nombres de archivos y carpetas (aDirectory[n][1])
   nChoice:=0
   aPosDir:={} //Este es un arreglo auxiliar para guardar la posicion de elementos que sean carpetas

   CLEAR SCREEN
   aDirectory := Directory("*.*", "D") //Obtiene un arreglo con subarreglos que tienen la estructura del directorio
   FOR j:=1 TO len(aDirectory)
      AADD(aDirNames, aDirectory[j][1])//Guarda los NOMBRES de cada carpeta o arch  ivo
   NEXT
   setPosDir(aDirectory) //ubica y asigna la posicion de cada carpeta del directorio actual
   //Qout(aPosDir[3])
   nChoice:=AChoice(5,10,25,30,aDirNames) //despliega los archivos y carpetas
   FOR i:=1 TO LEN(aPosDir) //Recorre el arreglo que tiene todas las carpetas
      //? nChoice
      IF nChoice=aPosDir[i]  //Si la opcion seleccionada es una carpeta
         showDirectories(aDirectory[nChoice])  //entra a funcion donde reasigna el dir principal para volver a desplegar
         CLS          
      EXIT   
      ENDIF
   NEXT
   
   //inkey(0)

   CLEAR SCREEN
   
RETURN NIL

FUNCTION showDirectories(aDir)//FUNCION RECURSIVA, recibe s¢lo la carpeta seleccionada (nChoice) con sus elementos
                              //array de 1x3, [nChoice][1] es el nombre
   LOCAL newDir:={}
   LOCAL j, i
   LOCAL aNewDirNames:={}
   DirChange(aDir[1])
   CLS
   newDir:= Directory("C:\"+CurDir()+"\", "D")
   ? "C:\"+CurDir()+"\"
   setPosDir(newDir)
   //Qout(Len(aPosDir))
  // newPath:=BeforAtNum("\", aDir[nChoice][1])
   FOR j:=1 TO len(newDir)
      AADD(aNewDirNames, newDir[j][1])
   NEXT
   nChoice:=AChoice(5,10,25,30,aNewDirNames)
   FOR i:=1 TO LEN(aPosDir)
      IF nChoice=aPosDir[i]
         showDirectories(newDir[nChoice])
         CLS
         EXIT
      ENDIF
   NEXT
      
RETURN NIL

FUNCTION setPosDir(aDir) //Esta funcion ubica la posicion de las carpteas
  
   LOCAL nPos
   aPosDir:={}
   FOR nPos:=1 TO LEN(aDir) //Recorre el directorio recibido en busca de subcarpetas
      IF aDir[nPos][F_ATTR]="D"
         AADD(aPosDir, nPos) //Las posiciones de las subcarpetas se guardan en el arreglo auxiliar
      ENDIF
   NEXT
   
      
RETURN NIL



