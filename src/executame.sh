#!/bin/bash
nArchivoParam="ParInit_Optimos_Sig4P.txt"
c=0

# Ler pais como argumento pola linha de comando
Country=$1
if [ -z $Country ]; then
  Country="Espana"
  echo "  Ubicacion por defecto <$Country>"
fi

# PARA A VERSION TERRITORIO A TERRITORIO 
#Escribir en lista_$Country os territorios nos que queremos lanzar
#e comentar a seguinte linha
#ls -d ../Data/$Country/*/ | cut -d'/' -f 4 > lista_$Country.dat 
##########

declare -a arr
mapfile -t arr < lista_$Country.dat

tr '[:upper:]' '[:lower:]' < ../Data/$Country/${Country}_Poblacion.csv > dep1.csv
iconv -f utf8 -t ascii//TRANSLIT dep1.csv -o dep2.csv


## Se recorren todos los elementos del array de Comunidades

for varRegion in "${arr[@]}"
do
i=`grep -i $varRegion dep2.csv | head -1 | cut -d',' -f 1`

    sed "s/xxx/$i/g" ../Rmds/$Country/res_Zona_Test.Rmd > ../Rmds/$Country/res_$varRegion.Rmd
    sed -i "s/Zona_Test/$varRegion/g" ../Rmds/$Country/res_$varRegion.Rmd

    if [ ! -d ../Rmds/$Country/$varRegion ];
    then
      echo " ->Creando los directorios Rmd para <$varRegion>..."
      mkdir ../Rmds/$Country/$varRegion
    fi

    FILE_PARAM[c]="../Data/$Country/$varRegion/$nArchivoParam"
    FILE_PDIR[c]="Results/$Country/$varRegion/"
    #echo " -> Lanzando Scripts de C++ y R en <$varRegion> con <${FILE_PARAM[c]}>"
    # Se comprueba que existen los directorios base ...
    if [ ! -d ${FILE_PDIR[c]} ];
    then
      echo " ->Creando los directorios para <$varRegion>..."
      mkdir ${FILE_PDIR[c]}
    fi
    # Se comprueba que existen los archivos base ...
    if [ ! -f ${FILE_PARAM[c]} ];
    then
      echo "."
      #echo " -> Se ha ignorado <$varRegion>, no está disponible el archivo <${FILE_PARAM[c]}.."
    else
      echo "$(tput setaf 3)-> Lanzando Scripts de C++ y R en <$varRegion> con indice <$i> ...$(tput sgr 0)"
       ./runsimular_paral 0 600 ${FILE_PARAM[c]} $varRegion $Country > ./Results/$Country/log_$varRegion.txt
      R -e "rmarkdown::render(input='../Rmds/$Country/res_$varRegion.Rmd',output_file='$varRegion/main.html',output_format='html_document')"
    fi
    c=$(($c+1))



done

rm dep1.csv
rm dep2.csv
   



