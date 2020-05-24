#!/bin/bash
cd $HOME/Github_Pages/forecastCovid
git pull

dataUPD="20200523"

## Se declara el array de variables para Italia ...
#varPais=Italia
#declare -a arr=("Abruzzo" "Basilicata" "Calabria" "Campania" "Romagna" "Venezia" "Lazio" "Liguria" "Lombardia" "Marche" "Molise" "Bolzano" "Trento" "Piemonte" "Puglia" "Sardegna" "Sicilia" "Toscana" "Umbria" "Aosta" "Veneto")


## Se declara el array de variables para España ...
varPais=Espana
declare -a arr=("Andalucia" "Aragon" "Asturias" "Baleares" "Canarias" "Cantabria" "Leon" "Mancha" "Cataluna" "Valencia" "Extremadura" "Madrid" "Murcia" "Vasco" "Rioja")


## Se recorren todos los elementos del array de Comunidades del pais elegido
i=1
c=0
for varRegion in "${arr[@]}"
do

    FILE_ORGDIR[c]="$HOME/Test_CPP/Ejemplo_012/Results/$varPais/$varRegion"
    FILE_DESTGITHUB[c]="$HOME/Github_Pages/forecastCovid/Data/$varPais/$varRegion"
    FILE_DESTDATA[c]="$HOME/Test_CPP/Data/$varPais/$varRegion"

    # Se comprueba que existen los archivos originales ...
    if [ -f ${FILE_ORGDIR[c]}/ParInit_Optimos_"$varRegion"_N01.txt ];
    then

       echo "Actualizando archivo de parametros de <$varRegion> "

       # Se comprueba que existen los directorios base en el repositorio ...
       if [ ! -d ${FILE_DESTGITHUB[c]} ];
       then
         echo "   -> Creando los directorios para <$varRegion> en Github_Pages..."
         mkdir ${FILE_DESTGITHUB[c]}
       fi

       # Se comprueba que existen los directorios base en la carpeta local del cluster ...
       if [ ! -d ${FILE_DESTDATA[c]} ];
       then
         echo "   -> Creando los directorios para <$varRegion> en Data ..."
         mkdir ${FILE_DESTDATA[c]}
       fi

       echo "   -> Pegando los archivos de parámetros en el directorio de Github y en Data con fecha <$dataUPD>"
       cp ${FILE_ORGDIR[c]}/ParInit_Optimos_"$varRegion"_N01.txt ${FILE_DESTGITHUB[c]}/ParInit_Optimos_Sig4P.txt
       cp ${FILE_ORGDIR[c]}/ParInit_Optimos_"$varRegion"_N01.txt ${FILE_DESTGITHUB[c]}/ParInit_Optimos_Sig4P_"$dataUPD".txt
       cp ${FILE_ORGDIR[c]}/ParInit_Optimos_"$varRegion"_N01.txt ${FILE_DESTDATA[c]}/ParInit_Optimos_Sig4P.txt
    fi
    i=$(($i+1))
    c=$(($c+1));
done








# CODIGO no usado ...
# declare -a arr=("Abruzzo" "Aosta" "Basilicata" "Bolzano" "Calabria" "Campania" "Lazio" "Liguria" "Marche" "Piemonte" "Puglia" "Sardegna" "Sicilia" "Toscana" "Trento" "Umbria" "Venezia" )

