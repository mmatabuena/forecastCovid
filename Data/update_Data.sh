#!/bin/bash

# Se accede al directorio con el script de Matlab ...
mv Espana_ccaa_covid19_fallecidos.csv Espana_ccaa_covid19_fallecidos_TMP.csv

echo ""
echo " Descargando y actualizando el archivo de muertes de la WEB ..."
wget https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_fallecidos.csv
mv ccaa_covid19_fallecidos.csv Espana_ccaa_covid19_fallecidos.csv



