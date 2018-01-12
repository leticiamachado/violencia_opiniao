

library(dplyr)

serie_morte_agressao_brasil <- mutate(serie_morte_agressao_brasil, 
                                      morteagressao_10000hab = (morte_agressao / populacao)*10000)


# carregar pacotes
library(readxl); library(ggmap); library(ggplot2)

# tema para grafico
theme_arretado<- function (base_size = 12, base_family = "") {
  theme_minimal(base_size = base_size, base_family = base_family) %+replace% 
    theme(axis.text.x = element_text(colour= "black",size=11,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=11,angle=0,hjust=1,vjust=0,face="plain"), 
          axis.title.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
          axis.title.y = element_text(colour="black",size=12,angle=90,hjust=0.5,vjust=0.6,face="plain"),
          title = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          panel.grid.major = element_line(colour = grey(0.85)), 
          panel.grid.minor = element_line(colour = grey(1)),
          legend.key.size = unit(9, "mm"),
          legend.text = element_text(size = 9, hjust = 3, vjust = 3),
          legend.title = element_text(size = 9),
          axis.line = element_line(size = 1, colour = "grey70"))
}



# produxir grafico em ggplot
serie_morte_agressao_brasil$morteagressao_10000hab<- round(serie_morte_agressao_brasil$morteagressao_10000hab, 3)

plot1 <- ggplot(data = serie_morte_agressao_brasil)+
  geom_line(aes(x = ano, y = morteagressao_10000hab, group =1), size = 1, colour = "darkred")+
  geom_text(aes(x = ano, y = morteagressao_10000hab, angle = 20 , vjust = -0.9, hjust = 0.3, fontface = "bold"),
            label = serie_morte_agressao_brasil$morteagressao_10000hab ,   size = 3.25)+
              
  labs(x = "", y = "Mortes Violentas por 10.000 hab")+
  scale_x_discrete(limits = c(2005, 2006, 2007, 2008, 2009, 
                           2010, 2011, 2012, 2013, 2014, 2015)) +
  theme_arretado() 
plot1

ggsave("plot1.png",  width = 9, height = 5)


getwd()







