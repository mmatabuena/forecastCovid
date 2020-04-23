#!/bin/bash
'Executando o código de simulación para as autonomías'
nArchivoParam="../Data/Galicia/ParInit_Optimos_Exp6.txt"

# Se ejecutan todas las autonomías con esos parámetros ...
./runsimular_paral -2 0 1000 $nArchivoParam "Galicia" | tee ./Results/Ejemplo_Galicia.txt
./runsimular_paral -2 0 1000 $nArchivoParam "Cataluna" | tee ./Results/Ejemplo_Cataluna.txt
./runsimular_paral -2 0 1000 $nArchivoParam "Leon" | tee ./Results/Ejemplo_Leon.txt
./runsimular_paral -2 0 1000 $nArchivoParam "Vasco" | tee ./Results/Ejemplo_Vasco.txt
./runsimular_paral -2 0 1000 $nArchivoParam "Madrid" | tee ./Results/Ejemplo_Madrid.txt

# Se ejecutan los scripts de R que generan las gráficas
R -e "rmarkdown::render('../Rmds/res_vasco.Rmd',output_file='../Rmds/vasco/main.html')"
R -e "rmarkdown::render('../Rmds/res_madrid.Rmd',output_file='../Rmds/madrid/main.html')"
R -e "rmarkdown::render('../Rmds/res_cataluna.Rmd',output_file='../Rmds/cataluna/main.html')"
R -e "rmarkdown::render('../Rmds/res_leon.Rmd',output_file='../Rmds/leon/main.html')"
R -e "rmarkdown::render('../Rmds/res_galicia.Rmd',output_file='../Rmds/galicia/main.html')"