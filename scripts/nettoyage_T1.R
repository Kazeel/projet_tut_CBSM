################
# Certains individus ont des valeurs extrêmes à T0, l'objectif serait de les détecter
# Ensuite, il faudra trouver une façon de les gérer (régressions ?)
################

# étape 1 : récupérons seulement les valeurs de T0
## nous n'avons pas besoin des identifiants ou dur groupe pour les valeurs de T0
## en effet, T0 se situe avant expérience, il n'y a donc pas de différence entre les individus.
## Ils proviennent tous de la même population de départ.
physio_T1<-data_physio[,c(4,22:38)]

# étape 2 : retirons les individus n'ayant aucun relevé
physio_T1<-physio_T1[apply(is.na(physio_T1),1,sum)==0,]

# étape 3 : cherchons les individus trop éloignés de la norme groupe.

## on va utiliser la fonction cherche.ext

# on applique la fonction à nos données et on va conserver un vecteur qui indique si un individu est sans problème

T1_indi_sp<-apply(apply(physio_T1[,-1],2, cherche.ext),1,sum)==17

# on peut regarder combien d'individus sont sans problème

sum(T1_indi_sp)
