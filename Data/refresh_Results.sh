#!/bin/bash
cd $HOME/Github_Pages/forecastCovid
git pull

# Se le añade la fecha a los archivos subidos
dataUPD=$1
if [ -z $dataUPD ]; then
  dataUPD=`date +"%Y%m%d"`
  echo "  Fecha actual por defecto <$dataUPD>"
fi

module load gcc/6.5.0


## Se declara el array de variables para Italia ...
#varPais=Italia
#declare -a arr=("Abruzzo" "Basilicata" "Calabria" "Campania" "Romagna" "Venezia" "Lazio" "Liguria" "Lombardia" "Marche" "Molise" "Bolzano" "Trento" "Piemonte" "Puglia" "Sardegna" "Sicilia" "Toscana" "Umbria" "Aosta" "Veneto")


## Se declara el array de variables para España ...
#varPais=Espana
#declare -a arr=("Andalucia" "Aragon" "Asturias" "Baleares" "Canarias" "Cantabria" "Leon" "Mancha" "Cataluna" "Valencia" "Extremadura" "Madrid" "Murcia" "Vasco" "Rioja" "Galicia" "Navarra")


## Se declara el array de variables para America Latina ...
varPais=World
#declare -a arr=( "Argentina" "Brazil" "Bolivia" "Chile" "Colombia" "Costa" "Cuba" "Ecuador" "Honduras" "Guatemala" "Mexico" "Nicaragua" "Paraguay" "Peru" "Dominican" "Salvador" "Uruguay" "Venezuela" )


## Se declara el array de variables para Otros Paises ...
#varPais=World
#declare -a arr=("Spain" "Italy") 


## Se declara el array de variables para Otros Paises ...
#varPais=World
declare -a arr=( "Algeria" "Egypt" "Libya" "Morocco" "Sudan" "Tunisia" )


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
       cp ${FILE_ORGDIR[c]}/ParInit_Optimos_"$varRegion"_N01.txt ${FILE_DESTDATA[c]}/ParInit_Optimos_Sig4P_"$dataUPD".txt
       # Para evitar que se sobreescriban una y otra vez los mismos ...
       mv ${FILE_ORGDIR[c]}/ParInit_Optimos_"$varRegion"_N01.txt ${FILE_ORGDIR[c]}/ParInit_Optimos_"$varRegion"_N01_UPDATED.txt

       # Y se actualizan los resultados usando esos parametros
       cd $HOME/Test_CPP/Ejemplo_003
       echo "   -> Simulando 300 repeticiones usando esos parámetros"
       ./runsimular_paral 0 300 ../Data/"$varPais"/"$varRegion"/ParInit_Optimos_Sig4P.txt "$varRegion" "$varPais" > res_"$varRegion"_"$varPais".txt
       i=$(($i+1))
    fi
    c=$(($c+1))
done


# Si no se ha actualizado ningún archivo se avisa
if [ $i -eq 1 ];
then
  echo "Ya están actualizados los $c archivos de $varPais"
else
  echo "Se han subido los $c archivos de $varPais al Github"
  echo "."
  cd $HOME/Github_Pages/forecastCovid
  git add .
  git commit -m"upd $dataUPD"
  git push
fi




# CODIGO no usado ...
# declare -a arr=("Abruzzo" "Aosta" "Basilicata" "Bolzano" "Calabria" "Campania" "Lazio" "Liguria" "Marche" "Piemonte" "Puglia" "Sardegna" "Sicilia" "Toscana" "Trento" "Umbria" "Venezia" )


