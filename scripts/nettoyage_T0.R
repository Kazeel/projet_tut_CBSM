################
# Certains individus ont des valeurs extrêmes à T0, l'objectif serait de les détecter
# Ensuite, il faudra trouver une façon de les gérer (régressions ?)
################

# étape 1 : récupérons seulement les valeurs de T0
## nous n'avons pas besoin des identifiants ou dur groupe pour les valeurs de T0
## en effet, T0 se situe avant expérience, il n'y a donc pas de différence entre les individus.
## Ils proviennent tous de la même population de départ.
physio_T0<-data_physio[,5:21]

# étape 2 : retirons les individus n'ayant aucun relevé
physio_T0<-physio_T0[apply(is.na(physio_T0),1,sum)==0,]

# étape 3 : cherchons les individus trop éloignés de la norme groupe.

## on va créer une fonction
# on y rentre un vecteur de données
# souvent on considère que ce qui s'écarte de 2 écart-type de la moyenne n'est pas normal
# mais on va laisser le choix de la taille de cet intervalle (2 ou 3 sigma ?)
cherche.ext<-function(x,taille=2){
  sigma<-sd(x) # pour recalculer plusieurs fois l'écart type
  ext<-mean(x)+c(-taille*sigma,taille*sigma) # 2 valeurs de l'intervalle
  result<-(x>=ext[1])&(x<=ext[2]) # TRUE si ok, FALSE si extrême
  return(result)
}

# on applique la fonction à nos données et on va conserver un vecteur qui indique si un individu est sans problème

T0_indi_sp<-apply(apply(physio_T0,2, cherche.ext),1,sum)==17
TO_ind<-apply(physio_T0,2, cherche.ext)
temp<-apply(TO_ind,2,sum)
# on peut regarder combien d'individus sont sans problème

sum(T0_indi_sp)

# Maintenant on peut chercher une solution pour prédire les valeurs des personnes avec des problèmes !