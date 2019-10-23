##############################
# Ici vous avez les codes concernant le formattage des données (noms des colonnes, type des colonnes etc...)
##############################
#
#
#

# PHYSIO
##Renommage
colnames(data_physio)[5:21]<-c("T0 Mean RR (ms)","T0 STD RR (ms)","T0 Mean HR (1/min)","T0 STD HR (1/min)","T0 RMSSD (ms)",
                               "T0 VLF (ms^2)","T0 LF (ms^2)","T0 HF (ms^2)","T0 VLF (%)","T0 LF (%)","T0 HF (%)","T0 LF (n,u,)",           
                               "T0 HF (n,u,)","T0 Total power (ms^2)","T0 LF/HF ratio","T0 EDR (Hz)","T0 Frequence Respiratoire")

colnames(data_physio)[22:40]<-c("Espace_1","Espace_2","T1 Mean RR (ms)","T1 STD RR (ms)","T1 Mean HR (1/min)","T1 STD HR (1/min)","T1 RMSSD (ms)",
                                "T1 VLF (ms^2)","T1 LF (ms^2)","T1 HF (ms^2)","T1 VLF (%)","T1 LF (%)","T1 HF (%)","T1 LF (n,u,)",           
                                "T1 HF (n,u,)","T1 Total power (ms^2)","T1 LF/HF ratio","T1 EDR (Hz)","T1 Frequence Respiratoire")

colnames(data_physio)[41:57]<-c("T2 Mean RR (ms)","T2 STD RR (ms)","T2 Mean HR (1/min)","T2 STD HR (1/min)","T2 RMSSD (ms)",
                                "T2 VLF (ms^2)","T2 LF (ms^2)","T2 HF (ms^2)","T2 VLF (%)","T2 LF (%)","T2 HF (%)","T2 LF (n,u,)",           
                                "T2 HF (n,u,)","T2 Total power (ms^2)","T2 LF/HF ratio","T2 EDR (Hz)","T2 Frequence Respiratoire")

##suppression des colonnes espaces
data_physio<-data_physio[,!colnames(data_physio)%in%c("Espace_1","Espace_2")]
