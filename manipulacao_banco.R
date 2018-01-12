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

# Criar variavel de voto
LapopBrazil_2006 <- mutate(LapopBrazil_2006, Voto_Incumbente = ifelse(Voto == 1 , 1, 0))
LapopBrazil_2008 <- mutate(LapopBrazil_2008, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))
LapopBrazil_2010 <- mutate(LapopBrazil_2010, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))
LapopBrazil_2012 <- mutate(LapopBrazil_2010, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))
LapopBrazil_2014 <- mutate(LapopBrazil_2010, Voto_Incumbente = ifelse(Voto == 1501 , 1, 0))

  
## Mergir bancos, selecionando  as variaveis de interesse ##

# definir variaveis
vars <- c("Urbanização",  "Gênero" ,  "Saliência_Violência", 
          "Avaliação_Governo", "Voto", "Idade","Escolaridade",
          "Renda_Familiar",  "Raça", "Ano", "Voto_Incumbente")

# mergir bancos
data_saliencia <- rbind(LapopBrazil_2006[,vars],
                        LapopBrazil_2008[,vars], 
                        LapopBrazil_2010[,vars],
                        LapopBrazil_2012[,vars],
                        LapopBrazil_2014[,vars])


# Recodificar NAs em Avaliacao do Governo
data_saliencia$Avaliação_Governo <- str_replace(data_saliencia$Avaliação_Governo, "8", "")
data_saliencia$Avaliação_Governo <- str_replace(data_saliencia$Avaliação_Governo, "9", "")
data_saliencia$Avaliação_Governo <- as.numeric(data_saliencia$Avaliação_Governo)

# Recodificar Urbanizazao
data_saliencia$Urbanização <- str_replace(data_saliencia$Urbanização, "2", "0")
data_saliencia$Urbanização <- factor(data_saliencia$Urbanização, levels = c("1", "0"), labels = c("Urbano", "Rural"))


#================================#
# MODELOS DE REGRESSAO LOGISTICA #
#================================#

#---------------------------------#
# Funcao para executar modelos
#---------------------------------#

model.reglog <- function(x, VD){
  glm(  VD ~  
        Urbanização +
        Gênero +
        Saliência_Violência +
        Idade +
        Escolaridade +
        Renda_Familiar +
        Raça, 
      data = x, family = "binomial")
}


#----- MODELO1 -----#
model1 <- model.reglog(data_saliencia, data_saliencia$Voto)

















