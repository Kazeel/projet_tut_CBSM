# Package à utiliser

#Importation
library(readxl)

#Prediction



# fonctions utiles


cherche.ext<-function(x,taille=2){
  sigma<-sd(x) # pour recalculer plusieurs fois l'écart type
  ext<-mean(x)+c(-taille*sigma,2*sigma) # 2 valeurs de l'intervalle
  result<-(x>=ext[1])&(x<=ext[2]) # TRUE si ok, FALSE si extrême
  return(result)
  
  # on y rentre un vecteur de données
  # souvent on considère que ce qui s'écarte de 2 écart-type de la moyenne n'est pas normal
  # mais on va laisser le choix de la taille de cet intervalle (2 ou 3 sigma ?)
}