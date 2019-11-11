#CBSM

pairs(physio_T1[T1_indi_sp,][physio_T1[T1_indi_sp,]$Groupe=="CBSM",-c(1)])

pairs(physio_T1[T1_indi_sp,][physio_T1[T1_indi_sp,]$Groupe=="CBSM",-c(1,3,4,5,8,9,12,13,14,15,16,17)])

# Nous allons regarder les éléments qui semblent corréler avec les neufs premières variables

# Les variables que nous allons conserver pour la prédiction des 9 premières variables

stock<-list()
restock<-list()
destock<-list()
for (ind in 1:9) {
  stock[[ind]]<-abs(round(cor(physio_T1[T1_indi_sp,][physio_T1[T1_indi_sp,]$Groupe=="CBSM",-c(1)]),2)[,ind])>= 0.4
  
  stock[[ind]][ind]<-FALSE
  
  restock[[ind]]<-abs(round(cor(physio_T1[T1_indi_sp,][physio_T1[T1_indi_sp,]$Groupe=="CBSM",-c(1)]),2)[stock[[ind]],stock[[ind]]])>=0.80
}
stock[[1]]
restock[[1]]
apply(restock[[1]],1,sum)<=1

mod<-lm(physio_T1[T1_indi_sp,][physio_T1[T1_indi_sp,]$Groupe=="CBSM",-c(1)])
step(mod)
