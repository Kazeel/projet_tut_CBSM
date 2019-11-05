################
# Certains individus ont des valeurs extrêmes à T0, l'objectif serait de les détecter
# Ensuite, il faudra trouver une façon de les gérer (régressions ?)
################

# etape 1 : récupérons seulement les valeurs de T0
## nous n'avons pas besoin des identifiants ou dur groupe pour les valeurs de T0
## en effet, T0 se situe avant expérience, il n'y a donc pas de différence entre les individus.
## Ils proviennent tous de la même population de départ.
physio_T0<-data_physio[,5:21]

# etape 2 : retirons les individus n'ayant aucun relevé
physio_T0<-physio_T0[apply(is.na(physio_T0),1,sum)==0,]

# etape 3 : cherchons les individus trop éloignés de la norme groupe.

## on va utiliser la fonction cherche.ext presente dans packages.R


# on applique la fonction a nos donnees et on va conserver un vecteur qui indique si un individu est sans problème

T0_indi_sp<-apply(apply(physio_T0,2, cherche.ext),1,sum)==17
TO_ind<-apply(physio_T0,2, cherche.ext)
temp<-apply(TO_ind,2,sum)
# on peut regarder combien d'individus sont sans problème

sum(T0_indi_sp)

# Maintenant on peut chercher une solution pour predire les valeurs des personnes avec des problèmes !