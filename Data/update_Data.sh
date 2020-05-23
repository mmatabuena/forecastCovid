#!/bin/bash
#PBS -l nodes=1:ppn=8:amd,walltime=30:00:00
#PBS -N TestsSobreCPP

# Se accede al directorio con el script de Matlab ...
cd ./Espana
mv Espana_Fallecidos.csv Espana_Fallecidos_TMP.csv

echo ""
echo " Descargando y actualizando el archivo de muertes de la WEB ..."
wget https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_fallecidos.csv
mv ccaa_covid19_fallecidos.csv Espana_Fallecidos.csv



