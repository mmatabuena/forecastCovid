#!/bin/bash
nArchivoParam="ParInit_Optimos_Sig4P.txt"
c=0

# Ler pais como argumento pola linha de comando
Country=$1
if [ -z $Country ]; then
  Country="Espana"
  echo "  Ubicacion por defecto <$varPais>"
fi

if [ "$Country" == "Espana" ];
then

declare -a arr=("Andalucia" "Aragon" "Asturias" "Baleares" "Canarias" "Cantabria" "Leon" "Mancha" "Cataluna" "Valencia" "Extremadura" "Galicia" "Madrid" "Murcia" "Navarra" "Vasco" "Rioja" "Ceuta" "Melilla" "Total")
fi

if [ "$Country" == "Italia" ];
then
declare -a arr=("Abruzzo" "Basilicata" "Calabria" "Campania" "Romagna" "Friuli" "Lazio" "Liguria" "Lombardia" "Marche" "Molise" "Bolzano" "Trento" "Piemonte" "Puglia" "Sardegna" "Sicilia" "Toscana" "Umbria" "Aosta" "Veneto" "Venezia" "Total")
fi


## Se recorren todos los elementos del array de Comunidades
i=1
for varRegion in "${arr[@]}"
do
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
    c=$(($c+1));


	
    i=$(($i+1))
  
done





