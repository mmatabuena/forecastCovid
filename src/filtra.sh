tr '[:upper:]' '[:lower:]' < ../Data/Espana/Espana_Poblacion.csv > dep1.csv
iconv -f utf8 -t ascii//TRANSLIT dep1.csv -o dep2.csv
i=`grep -i $varRegion dep2.csv | cut -d',' -f 1`
echo $i



