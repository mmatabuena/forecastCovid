#!/bin/bash
nArchivoParam="ParInit_Optimos_Exp7.txt"
c=0

## Declaración del array de comunidades para lanzar los scripts
declare -a arr=("Galicia" "Cataluna" "Leon" "Vasco" "Madrid" "Navarra" "Zona_Test")

## Se recorren todos los elementos del array de Comunidades
for varRegion in "${arr[@]}"
do
    
   	FILE_PARAM[c]="../Data/Espana/$varRegion/$nArchivoParam"
	FILE_PDIR[c]="../Data/Espana/$varRegion/"
	#echo " -> Lanzando Scripts de C++ y R en <$varRegion> con <${FILE_PARAM[c]}>"
	# Se comprueba que existen los archivos base ...
	if [ ! -f ${FILE_PARAM[c]} ];
	then
	echo " -> Se ha ignorado <$varRegion>, no está disponible el archivo <${FILE_PARAM[c]}.."
	else
	echo " -> Lanzando Scripts de C++ y R en <$varRegion>..."
	mkdir ${FILE_PDIR[c]}
	./runsimular_paral -1 0 500 ${FILE_PARAM[c]} $varRegion > ./Results/Espana/log_$varRegion.txt
	R -e "rmarkdown::render(input='../Rmds/Espana/res_$varRegion.Rmd',output_file='$varRegion/main.html',output_format='html_document')"

    fi
    c=$(($c+1));
  
done




# Se ejecutan los scripts de R que generan las gráficas
#R -e "rmarkdown::render('../Rmds/Espana/res_vasco.Rmd',output_file='../Rmds/Espana/vasco/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_madrid.Rmd',output_file='../Rmds/Espana/madrid/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_cataluna.Rmd',output_file='../Rmds/Espana/cataluna/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_leon.Rmd',output_file='../Rmds/leon/Espana/main.html')"
#R -e "rmarkdown::render('../Rmds/Espana/res_galicia.Rmd',output_file='../Rmds/Espana/galicia/main.html')"
