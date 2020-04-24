#!/bin/bash
nArchivoParam="ParInit_Optimos_Exp7.txt"
c=0

## Declaración del array de comunidades para lanzar los scripts
declare -a arr=("Galicia" "Cataluna" "Leon" "Vasco" "Madrid" "Navarra")

## Se recorren todos los elementos del array de Comunidades
for varRegion in "${arr[@]}"
do
    
    FILE_PARAM[c]="../Data/$varRegion/$nArchivoParam"
    #echo "  -> Lanzando Scripts de C++ y R en <$varRegion> con <${FILE_PARAM[c]}>"
    # Se comprueba que existen los archivos base ...
    if [ ! -f ${FILE_PARAM[c]} ];
    then
        echo "  -> Se ha ignorado <$varRegion>, no está disponible el archivo <$FILE_PARAM>.."
    else
        echo "  -> Lanzando Scripts de C++ y R en <$varRegion>..."
        ./runsimular_paral 30 0 1000 ${FILE_PARAM[c]} $varRegion > ./Results/Ejemplo_$varRegion.txt 
        #R -e rmarkdown::render("../Rmds/res_$varRegion.Rmd",output_file="../Rmds/$varRegion/main.html")

    fi
    c=$(($c+1));
  
done




# Se ejecutan los scripts de R que generan las gráficas
#R -e "rmarkdown::render('../Rmds/res_vasco.Rmd',output_file='../Rmds/vasco/main.html')"
R -e "rmarkdown::render('../Rmds/res_madrid.Rmd',output_file='../Rmds/madrid/main.html')"
#R -e "rmarkdown::render('../Rmds/res_cataluna.Rmd',output_file='../Rmds/cataluna/main.html')"
#R -e "rmarkdown::render('../Rmds/res_leon.Rmd',output_file='../Rmds/leon/main.html')"
R -e "rmarkdown::render('../Rmds/res_galicia.Rmd',output_file='../Rmds/galicia/main.html')"
