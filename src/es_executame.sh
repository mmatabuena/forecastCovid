#!/bin/bash
nArchivoParam="ParInit_Optimos_Sig4P.txt"
c=0

## Declaración del array de comunidades para lanzar los scripts
declare -a arr=("Andalucia" "Aragon" "Asturias" "Baleares" "Canarias" "Cantabria" "Leon" "Mancha" "Cataluna" "Valencia" "Extremadura" "Galicia" "Madrid" "Murcia" "Navarra" "Vasco" "Rioja" "Ceuta" "Melilla" "Total") # IMPORTANTE colocalas na mesma orde que no arquivo Espana_ccaa_covid19_fallecidos.csv

## Se recorren todos los elementos del array de Comunidades
i=1
for varRegion in "${arr[@]}"
do
    	sed "s/xxx/$i/g" ../Rmds/Espana/res_Zona_Test.Rmd > ../Rmds/Espana/res_$varRegion.Rmd
	sed -i "s/Zona_Test/$varRegion/g" ../Rmds/Espana/res_$varRegion.Rmd
 if [ ! -d ../Rmds/Espana/$varRegion ];
    then
      echo " ->Creando los directorios Rmd para <$varRegion>..."
      mkdir ../Rmds/Espana/$varRegion
    fi

    FILE_PARAM[c]="../Data/Espana/$varRegion/$nArchivoParam"
    FILE_PDIR[c]="Results/Espana/$varRegion/"
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
      ./runsimular_paral 0 600 ${FILE_PARAM[c]} $varRegion Espana > ./Results/$Country/log_$varRegion.txt
      R -e "rmarkdown::render(input='../Rmds/Espana/res_$varRegion.Rmd',output_file='$varRegion/main.html',output_format='html_document')"
    fi
    c=$(($c+1));


	
    i=$(($i+1))
  
done

# Para ejecutar a mano los scripts de R que generan las gráficas
#R -e "rmarkdown::render('../Rmds/Espana/res_vasco.Rmd',output_file='../Rmds/Espana/vasco/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_madrid.Rmd',output_file='../Rmds/Espana/madrid/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_cataluna.Rmd',output_file='../Rmds/Espana/cataluna/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_leon.Rmd',output_file='../Rmds/leon/Espana/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_galicia.Rmd',output_file='../Rmds/Espana/galicia/main.html')"

#$ chmod +x executame.sh


