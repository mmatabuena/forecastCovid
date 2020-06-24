import pandas as pd
import numpy as np

if __name__ == "__main__":
	# Se lee el archivo que contiene la info de fallecidos de todos los lugares
	df_data = pd.read_csv('./Data/World/World_Fallecidos_All.csv')
	df_data = df_data.drop(['Lat', 'Long'], axis=1)
	# Se exportan solo aquellos que NO tienen código de provincia
	df_selection = df_data[df_data['Province/State'].isna()]
	# Ahora se elimina la primera columna, que está vacía para los elegidos
	df_selection = df_selection.drop(['Province/State'], axis=1)
	# Y se renombra con el codigo <name>
	df_selection = df_selection.rename(columns={'Country/Region': 'name'})
	#df_selection.to_csv('./Data/World/World_Fallecidos_Filter.csv',index_label='Indice')

	# Se lee el archivo que contiene la info de codigos Iso de los lugares
	df_iso_codes = pd.read_csv('./Data/World/World_IsoCodes_All.csv')
	df_iso_codes = df_iso_codes[['name', 'alpha-3', 'alpha-2']]
	
	# Correccion de las dos regiones que no coinciden los códigos ISO y los nombres
	df_iso_codes.loc[(df_iso_codes['alpha-3']=='BOL'),'name']='Bolivia'
	df_iso_codes.loc[(df_iso_codes['alpha-3']=='VEN'),'name']='Venezuela'
	#df_iso_codes.to_csv('./Data/World/Iso_Filter.csv',index_label='Indice')

	# Combinación de ambas tablas ...
	df_dataset = df_iso_codes.set_index('name').join(df_selection.set_index('name')).rename(columns={'alpha-2': 'iso2', 'alpha-3': 'iso3'}).dropna()
	df_dataset = df_dataset.reset_index().set_index(['name', 'iso2', 'iso3'])
	df_dataset.columns = pd.DatetimeIndex(df_dataset.columns, freq='D').floor('D').date
	df_dataset = df_dataset.reset_index().drop(['iso2', 'iso3'], axis=1)
	df_dataset.to_csv('./Data/World/World_Fallecidos.csv',index_label='Indice',float_format='%.0f')

	# Se lee el archivo que contiene la info de población de todos los lugares y se generan los datos de los sitios elegidos
	df_population = pd.read_csv('./Data/World/World_Poblacion_All.csv')
	df_population = df_population.groupby('Country Code').last().reset_index()[['Country Name', 'Value']].rename(columns={'Country Name': 'Comunidad', 'Value': 'Poblacion'})

	# Correccion de las regiones que no coinciden los nombres con los del archivo de Isos
	df_population.loc[(df_population['Comunidad']=='Venezuela, RB'),'Comunidad']='Venezuela'
	df_population.to_csv('./Data/World/World_Poblacion.csv',index_label='Indice')
