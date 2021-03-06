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
library(readxl); library(stringr); library(dplyr); library(stargazer)

# ler bancos de dados
LapopBrazil_2006 <- read_excel("Dados/LapopBrazil_2006.xlsx")
LapopBrazil_2008 <- read_excel("Dados/LapopBrazil_2008.xlsx")
LapopBrazil_2010 <- read_excel("Dados/LapopBrazil_2010.xlsx")
LapopBrazil_2012 <- read_excel("Dados/LapopBrazil_2012.xlsx")
LapopBrazil_2014 <- read_excel("Dados/LapopBrazil_2014.xlsx")

# Renomear colunas
colnames(LapopBrazil_2006) <- c("Urbaniza��o",  "G�nero" ,  "Sali�ncia_Viol�ncia", "Economia1", "Economia2",       
                                "Economia3", "Avalia��o_Governo", "Voto", "VB10", "Idade",         
                                "Escolaridade", "Renda_Individual", "Renda_Familiar",  "Ra�a")

colnames(LapopBrazil_2008)<- c("Urbaniza��o",  "G�nero" ,  "Sali�ncia_Viol�ncia", "Economia1", "Economia2",       
                               "Economia3", "Avalia��o_Governo", "Voto", "Idade",         
                               "Escolaridade", "Renda_Familiar",  "Ra�a" )

colnames(LapopBrazil_2010) <- c("Urbaniza��o",  "G�nero" ,  "Sali�ncia_Viol�ncia", "Economia1", "Economia2",       
                                "Economia3", "Engajamento_Pol�tico", "V�tima_Viol�ncia", "Avalia��o_Governo", "Voto",
                                "Escolaridade", "Idade", "Renda_Familiar", "Ra�a")

colnames(LapopBrazil_2012) <- c("Urbaniza��o",  "G�nero" , "q2", "Sali�ncia_Viol�ncia", "Economia1", "Economia2",       
                                "Economia3", "Engajamento_Pol�tico", "V�tima_Viol�ncia", "Avalia��o_Governo", "Voto",
                                "VB10", "Escolaridade", "Renda_Familiar", "Renda_Individual","Ra�a" ,"Idade", "Recorr�ncia")

colnames(LapopBrazil_2014) <- c("Urbaniza��o",  "G�nero" , "Idade", "Sali�ncia_Viol�ncia", "Economia2",       
                                "Engajamento_Pol�tico", "V�tima_Viol�ncia", "Recorr�ncia", "Avalia��o_Governo", "Voto",
                                "Escolaridade", "Renda_Familiar", "Renda_Individual","Ra�a")

# criar coluna de ano
LapopBrazil_2006$Ano <- 2006
LapopBrazil_2008$Ano <- 2008
LapopBrazil_2010$Ano <- 2010
LapopBrazil_2012$Ano <- 2012
LapopBrazil_2014$Ano <- 2014

# Criar variavel de voto
LapopBrazil_2006 <- mutate(LapopBrazil_2006, Voto_Incumbente = ifelse(Voto == 1 , 1, 0))
LapopBrazil_2008 <- mutate(LapopBrazil_2008, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))
LapopBrazil_2010 <- mutate(LapopBrazil_2010, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))
LapopBrazil_2012 <- mutate(LapopBrazil_2010, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))
LapopBrazil_2014 <- mutate(LapopBrazil_2010, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))

  
## Mergir bancos, selecionando  as variaveis de interesse ##

# definir variaveis
vars <- c("Urbaniza��o",  "G�nero" ,  "Sali�ncia_Viol�ncia", 
          "Avalia��o_Governo", "Voto", "Idade","Escolaridade",
          "Renda_Familiar",  "Ra�a", "Ano", "Voto_Incumbente")

# mergir bancos
data_saliencia <- rbind(LapopBrazil_2006[,vars],
                        LapopBrazil_2008[,vars], 
                        LapopBrazil_2010[,vars],
                        LapopBrazil_2012[,vars],
                        LapopBrazil_2014[,vars])


# Recodificar NAs em Avaliacao do Governo
data_saliencia$Avalia��o_Governo <- str_replace(data_saliencia$Avalia��o_Governo, "8", "")
data_saliencia$Avalia��o_Governo <- str_replace(data_saliencia$Avalia��o_Governo, "9", "")
data_saliencia$Avalia��o_Governo <- as.numeric(data_saliencia$Avalia��o_Governo)

# Recodificar Urbanizazao
data_saliencia$Urbaniza��o <- str_replace(data_saliencia$Urbaniza��o, "2", "0")
data_saliencia$Urbaniza��o <- factor(data_saliencia$Urbaniza��o, levels = c("1", "0"), labels = c("Urbano", "Rural"))


#================================#
# MODELOS DE REGRESSAO LOGISTICA #
#================================#

#---------------------------------#
# Funcao para executar modelos
#---------------------------------#

model.reglog <- function(x, VD){
  glm(  VD ~  
        Urbaniza��o +
        G�nero +
        Sali�ncia_Viol�ncia +
        Idade +
        Escolaridade +
        Renda_Familiar +
        Ra�a, 
      data = x, family = "binomial")
}


#----- MODELO1 -----#
model1 <- model.reglog(data_saliencia, data_saliencia$Voto)

















