library(rsconnect)

rsconnect::setAccountInfo(name='3r3ehm-robert-craig', 
                          token='4E18B008BAD8C2ADFA02F6146BBADEF7', 
                          secret='TsH9G/oIqQ9yRLDXhobcvpL5TFWsxlYM8bMyj20u'
                          )

setwd("~/Desktop/STAT_418/STAT418_FinalProject/Shiny_application/Shiny-App")
deployApp()