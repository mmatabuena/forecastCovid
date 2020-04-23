#!/bin/bash
# Script del shell realizado por Victor Leboran
# Para mas info contacta en victor.leboran@usc.es

echo "Actualizando los datos para Madrid"
./runsimular_paral -2 0 600 "./Madrid/ParInit_Optimos_08_006_Exp4.txt" Madrid | tee ./logsSimulacion/Madrid_600R.log
echo " Actualizando los datos para el Pais Vasco"
./runsimular_paral -2 0 600 "./Vasco/ParInit_Optimos_08_006_Exp4.txt" Vasco | tee ./logsSimulacion/PaisVasco_600R.log
