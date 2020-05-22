#!/bin/bash

cd $HOME/Github_Pages/forecastCovid
#git pull

nRegion=Aosta
## declare an array variable
#declare -a arr=("Abruzzo" "Basilicata" "Calabria" "Campania" "Romagna" "Venezia" "Lazio" "Liguria" "Lombardia" "Marche" "Molise" "Bolzano" "Trento" "Piemonte" "Puglia" "Sardegna" "Sicilia" "Toscana" "Umbria" "Aosta" "Veneto")

## Se recorren todos los elementos del array de Comunidades
i=1
c=0
for varRegion in "${arr[@]}"
do
    FILE_ORGDIR[c]=$HOME/Test_CPP/Ejemplo_012/Results/Italia/"$varRegion"/
    FILE_DESTDIR[c]=$HOME/Github_Pages/forecastCovid/Data/Italia/"$varRegion"/
    # Se comprueba que existen los directorios base ...
    if [ ! -d ${FILE_PDIR[c]} ];
    then
      echo " ->Creando los directorios para <$varRegion>..."
      mkdir ${FILE_DESTDIR[c]}
    fi

   cp ${FILE_PDIR[c]}/ParInit_Optimos_"$varRegion"_N01.txt ${FILE_DESTDIR[c]}/ParInit_Optimos_Sig4P.txt
   i=$(($i+1))
   c=$(($c+1));
done


