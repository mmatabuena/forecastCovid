#!/bin/bash

nArchivoParam="ParInit_Optimos_Exp6.txt"

# Se ejecutan todas las autonomías con esos parámetros ...
./runsimular_paral 25 0 200 ../Data/Galicia/$nArchivoParam "Galicia" | tee ./Results/Ejemplo_Galicia.txt
./runsimular_paral 25 0 200 ../Data/Cataluna/$nArchivoParam "Cataluna" | tee ./Results/Ejemplo_Cataluna.txt
./runsimular_paral 25 0 200 ../Data/Leon/$nArchivoParam "Leon" | tee ./Results/Ejemplo_Leon.txt
./runsimular_paral 25 0 200 ../Data/Vasco/$nArchivoParam "Vasco" | tee ./Results/Ejemplo_Vasco.txt
./runsimular_paral 25 0 200 ../Data/Madrid/$nArchivoParam "Madrid" | tee ./Results/Ejemplo_Madrid.txt


# Se ejecutan los scripts de R que generan las gráficas
R -e "rmarkdown::render('../Rmds/res_vasco.Rmd',output_file='../Rmds/vasco/main.html')"
R -e "rmarkdown::render('../Rmds/res_madrid.Rmd',output_file='../Rmds/madrid/main.html')"
R -e "rmarkdown::render('../Rmds/res_cataluna.Rmd',output_file='../Rmds/cataluna/main.html')"
R -e "rmarkdown::render('../Rmds/res_leon.Rmd',output_file='../Rmds/leon/main.html')"
R -e "rmarkdown::render('../Rmds/res_galicia.Rmd',output_file='../Rmds/galicia/main.html')"
