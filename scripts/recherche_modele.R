##############################
# Script concernant la recherche de meilleur modèle
##############################

modeleSTEP<-function(data,pmin=0.05){
  
  liste_formules<-list()
  #recherche le meilleur modele de regression lineaire pour chaque variable quantitative de data
  #le nom des variables peut changer à des formules
  #Correction des noms
  colnames(data)<-gsub(" ","_",colnames(data))
  colnames(data)<-gsub("[(]","_",colnames(data))
  colnames(data)<-gsub("[)]","",colnames(data))
  colnames(data)<-gsub("/","_",colnames(data))
  colnames(data)<-gsub("\\^","_",colnames(data))
  colnames(data)<-gsub("\\%","_",colnames(data))
  colnames(data)<-gsub("\\,","_",colnames(data))
  colnames(data)<-sub("_","",colnames(data))
  
  # Determiner les variables quantitaves
  is_quanti<-sapply(X=physio_T1_sp,is.numeric)
  
  for (i in (1:length(is_quanti))[is_quanti]) {
    #variable a predire
    var_a_predire<-colnames(data)[i]
    #variables explicatives
    var_explicative<-colnames(data)[-i]
    #formules
    formules<-paste(var_a_predire,"~",var_explicative)
    #regression lineaire simple
    pval<-c()
    for (formule in formules) {
      #print(formule)
      reg <- lm(as.formula(formule),data=data)
      pval = tryCatch({
        c(pval,summary(reg)$coefficients[2,4])
      }, 
      error = function(e) {
        c(pval,NA)
      })
    }
    names(pval)<-var_explicative
    # On retire les pval "NA"
    pvalfinal<-pval[!is.na(pval)]
    # Combien sont significatives à pmin
    sum(pvalfinal<=0.05)
    pvalfinal<-pvalfinal[pvalfinal<=pmin]
    reg <- lm(as.formula(paste0(var_a_predire,"~",paste0(names(pvalfinal),collapse="+"))),data=data)
    aic<-step(reg,direction = "both")
    # Le modele selectionné est :
    summary_aic<-summary(aic)
     #C'est une formule
    liste_formules<-append(liste_formules,summary_aic$terms)
    
  }
  
  
  return(liste_formules)
}

