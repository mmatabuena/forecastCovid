#!/bin/bash
'Executando o código de simulación para as autonomías'
./runsimular_paral -2 0 1000 "../cluster_data/Galicia/ParInit_Optimos_Exp6.txt" "Galicia" | tee Ejemplo_Galicia.txt
./runsimular_paral -2 0 1000 "../cluster_data/Cataluna/ParInit_Optimos_Exp6.txt" "Cataluna" | tee Ejemplo_Cataluna.txt
./runsimular_paral -2 0 1000 "../cluster_data/Leon/ParInit_Optimos_Exp6.txt "Leon" | tee Ejemplo_Leon.txt
./runsimular_paral -2 0 1000 "../cluster_data/Vasco/ParInit_Optimos_Exp6.txt" "Vasco" | tee Ejemplo_Vasco.txt
./runsimular_paral -2 0 1000 "../cluster_data/Madrid/ParInit_Optimos_Exp6.txt" "Madrid" | tee Ejemplo_Madrid.txt


R -e "rmarkdown::render('../Rmds/res_vasco.Rmd',output_file='../Rmds/vasco/main.html')"
R -e "rmarkdown::render('../Rmds/res_madrid.Rmd',output_file='../Rmds/madrid/main.html')"
R -e "rmarkdown::render('../Rmds/res_cataluna.Rmd',output_file='../Rmds/cataluna/main.html')"
R -e "rmarkdown::render('../Rmds/res_leon.Rmd',output_file='../Rmds/leon/main.html')"
R -e "rmarkdown::render('../Rmds/res_galicia.Rmd',output_file='../Rmds/galicia/main.html')"







