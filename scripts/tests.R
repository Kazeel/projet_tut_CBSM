# Test des scripts

# récupération des packages
source(file = "scripts/packages.R")

# importation des données physio
data_physio <- read_excel("data/datas_physio_cbsm.xlsx",sheet=2)

# formattage
source(file = "scripts/formattage_data.R")
