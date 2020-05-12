varRegion=Cataluna
i=188
sed "s/xxx/$i/g" ../Rmds/Espana/res_Zona_Test.Rmd > ../Rmds/Espana/res_$varRegion.Rmd
sed -i "s/Zona_Test/$varRegion/g" ../Rmds/Espana/res_$varRegion.Rmd
