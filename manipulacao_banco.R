#========================================#
# VIOLENCIA E OPINIAO PUBLICA            #    
#========================================#
# Recife - Pernambuco - Brasil           #
# Janeiro 2018                           #    
#----------------------------------------#
# Claudio A. Monteiro                    #
# Gabriella Fidelis                      #
# Leticia Machado                        #
#----------------------------------------#
# Any question contact the developers    #
# #UseFreeSoftware                       #
#----------------------------------------#

# instalar pacotes necessarios
# install.packages(c("readxl"))

# carregar pacote
library(readxl)

# ler bancos de dados
LapopBrazil_2006 <- read_excel("Dados/LapopBrazil_2006.xlsx")
LapopBrazil_2008 <- read_excel("Dados/LapopBrazil_2008.xlsx")
LapopBrazil_2010 <- read_excel("Dados/LapopBrazil_2010.xlsx")
LapopBrazil_2012 <- read_excel("Dados/LapopBrazil_2012.xlsx")
LapopBrazil_2014 <- read_excel("Dados/LapopBrazil_2014.xlsx")

# Renomear colunas
colnames(LapopBrazil_2006) <- c("Urbanização",  "Gênero" ,  "Saliência_Violência", "Economia1", "Economia2",       
                                "Economia3", "Avaliação_Governo", "Voto", "VB10", "Idade",         
                                "Escolaridade", "Renda_Individual", "Renda_Familiar",  "Raça")

colnames(LapopBrazil_2008)<- c("Urbanização",  "Gênero" ,  "Saliência_Violência", "Economia1", "Economia2",       
                               "Economia3", "Avaliação_Governo", "Voto", "Idade",         
                               "Escolaridade", "Renda_Familiar",  "Raça" )

colnames(LapopBrazil_2010) <- c("Urbanização",  "Gênero" ,  "Saliência_Violência", "Economia1", "Economia2",       
                                "Economia3", "Engajamento_Político", "Vítima_Violência", "Avaliação_Governo", "Voto",
                                "Escolaridade", "Idade", "Renda_Familiar", "Raça")

colnames(LapopBrazil_2012) <- c("Urbanização",  "Gênero" , "q2", "Saliência_Violência", "Economia1", "Economia2",       
                                "Economia3", "Engajamento_Político", "Vítima_Violência", "Avaliação_Governo", "Voto",
                                "VB10", "Escolaridade", "Renda_Familiar", "Renda_Individual","Raça" ,"Idade", "Recorrência")

colnames(LapopBrazil_2014) <- c("Urbanização",  "Gênero" , "Idade", "Saliência_Violência", "Economia2",       
                                "Engajamento_Político", "Vítima_Violência", "Recorrência", "Avaliação_Governo", "Voto",
                                "Escolaridade", "Renda_Familiar", "Renda_Individual","Raça")

# criar coluna de ano
LapopBrazil_2006$Ano <- 2006
LapopBrazil_2008$Ano <- 2008
LapopBrazil_2010$Ano <- 2010
LapopBrazil_2012$Ano <- 2012
LapopBrazil_2014$Ano <- 2014
  
#-----------------------------#
# Mergir bancos

data_saliencia <- rbind(LapopBrazil_2006[,c(1:3, 7:8, 10, 11, 13:15)], LapopBrazil_2008[], LapopBrazil_2010,
                        LapopBrazil_2012, LapopBrazil_2014)





