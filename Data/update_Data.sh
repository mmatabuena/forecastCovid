#!/bin/bash
#PBS -l nodes=1:ppn=8:amd,walltime=30:00:00
#PBS -N TestsSobreCPP


# Se accede al directorio con los datos de España...
cd $HOME/Test_CPP/Data/Espana
mv Espana_Fallecidos.csv Espana_Fallecidos_TMP.csv

echo ""
echo " Descargando y actualizando el archivo de muertes de España de la WEB ..."
wget -q https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_fallecidos.csv >>logDownload.txt
mv ccaa_covid19_fallecidos.csv Espana_Fallecidos.csv

# Se informa de las fechas de los ultimos datos
fechaUlt=$( sed 's/.*,//g' $HOME/Test_CPP/Data/Espana/Espana_Fallecidos.csv | head -n 1 )
echo "   -> La fecha de la ultima actualización es <$fechaUlt>"

# Se accede al directorio con los datos del mundo...
cd $HOME/Test_CPP/Data/World
mv World_Fallecidos.csv World_Fallecidos_TMP.csv

echo ""
echo " Descargando y actualizando el archivo de muertes del Mundo de la WEB ..."
wget -q https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv >>logDownload.txt
mv time_series_covid19_deaths_global.csv World_Fallecidos_All.csv

wget -q https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv >>logDownload.txt
mv all.csv World_IsoCodes_All.csv

wget -q https://raw.githubusercontent.com/datasets/population/master/data/population.csv >>logDownload.txt
mv population.csv World_Poblacion_All.csv

# Se carga el modulo de python y se ejecuta el script de Pablo
echo "   -> Generando archivo de Población con Python"
cd $HOME/Test_CPP/
module load python/3.8.2
python ./dataset_update.py

# Se borran los temporales usados para crear los archivos locales
rm $HOME/Test_CPP/Data/World/World_Poblacion_All.csv
rm $HOME/Test_CPP/Data/World/World_Fallecidos_All.csv
rm $HOME/Test_CPP/Data/World/World_IsoCodes_All.csv

# Se informa de las fechas de los ultimos datos
fechaUlt=$( sed 's/.*,//g' $HOME/Test_CPP/Data/World/World_Fallecidos.csv | head -n 1 )
echo "   -> La fecha de la ultima actualización es <$fechaUlt>"

echo ""
echo " Actualizando el Github"

# Ahora se actualiza el archivo de Github 
cd $HOME/Github_Pages/forecastCovid
git pull

cp $HOME/Test_CPP/Data/Espana/Espana_Fallecidos.csv $HOME/Github_Pages/forecastCovid/Data/Espana/Espana_Fallecidos.csv
cp $HOME/Test_CPP/Data/Espana/Espana_Poblacion.csv $HOME/Github_Pages/forecastCovid/Data/Espana/Espana_Poblacion.csv
cp $HOME/Test_CPP/Data/World/World_Fallecidos.csv $HOME/Github_Pages/forecastCovid/Data/World/World_Fallecidos.csv
cp $HOME/Test_CPP/Data/World/World_Poblacion.csv $HOME/Github_Pages/forecastCovid/Data/World/World_Poblacion.csv

# Se actualiza el repositorio 
git add .

echo ""