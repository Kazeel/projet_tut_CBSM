
# Nous allons regarder les éléments qui semblent corréler avec les neufs premières variables

# Pour cela, nous allons réaliser des regressions linéaires simples et conserver celles avec des tests de student 
# validant le lien entre les dites variables et la variable à prédire.

# Pour commencer, nous allons réaliser les étapes une à une puis nous réaliserons une fonction quand tout sera claire
# Afin de réutiliser cette méthode sur plusieurs variables.



# Etape 1
#On récupère les individus sans problème pour T1
physio_T1_sp<-physio_T1[T1_indi_sp,]
# Puis on va réaliser une regression univariée et récupérer celles dont la pvaleur est significative

# Etape 1.5
# Comme on va utiliser le nom des variables pour faire la regression, 
# mais que R n'aime pas trop les espaces dans les formules, on va les remplacer par "_"
colnames(physio_T1_sp)<-gsub(" ","_",colnames(physio_T1_sp))
# Les formules n'aimes pas les "()" parce que elle confondent ça avec des fonctions
# Donc pareil, ça dégage !
colnames(physio_T1_sp)<-gsub("[(]","_",colnames(physio_T1_sp))
colnames(physio_T1_sp)<-gsub("[)]","",colnames(physio_T1_sp))
# Les formules n'aimes pas les "/" ou "^" et "%" ou "," parce que elle confondent ça avec des operations
# Donc pareil, ça dégage !
colnames(physio_T1_sp)<-gsub("/","_",colnames(physio_T1_sp))
colnames(physio_T1_sp)<-gsub("\\^","_",colnames(physio_T1_sp))
colnames(physio_T1_sp)<-gsub("\\%","_",colnames(physio_T1_sp))
colnames(physio_T1_sp)<-gsub("\\,","_",colnames(physio_T1_sp))
# Et enfin, il semble y avoir un problème car il y a des "_" au debut, et que R n'aime pas ça.
colnames(physio_T1_sp)<-sub("_","",colnames(physio_T1_sp))
#Maintenant, on peut reprendre le travail

# Etape 2
# On suppose qu'on veut predire la 2eme variable
var_a_predire<-colnames(physio_T1_sp)[2]
#On strock les variables explicatives, on va pour le moment se passer de la variable groupe
var_explicative<-colnames(physio_T1_sp)
#On crée les formules de regression
formules<-paste(var_a_predire,"~",var_explicative)
# On va faire les regressions et calculer les pvaleurs

pval<-c()
for (formule in formules) {
  #print(formule)
  reg <- lm(as.formula(formule),data=physio_T1_sp)
  
  pval = tryCatch({
    c(pval,summary(reg)$coefficients[2,4])
  }, 
  error = function(e) {
    c(pval,NA)
  })
}
names(pval)<-var_explicative

# Etape 3
# On a nos pval, faisons un petit tour dessus :
# On retire les pval "NA"
pvalfinal<-pval[!is.na(pval)]
# Combien sont significatives à 5%
sum(pvalfinal<=0.05)
pvalfinal<-pvalfinal[pvalfinal<=0.05]
# On va conserver celles-ci

#On realise une aic

reg <- lm(as.formula(paste0(var_a_predire,"~",paste0(names(pvalfinal),collapse="+"))),data=physio_T1_sp)
aic<-step(reg,direction = "both")

# Le modele selectionné est :
summary_aic<-summary(aic)
summary_aic$terms #C'est une formule

