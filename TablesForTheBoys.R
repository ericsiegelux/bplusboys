library(rvest)
library(dplyr) # for functions

nbaSummary <- read_html("https://www.basketball-reference.com/leagues/NBA_2022.html")


perGameTeam<- nbaSummary %>% 
  html_nodes("#per_game-team") %>% 
  html_table()



perGameTeamOpp <- nbaSummary %>% 
  html_nodes("#per_game-opponent") %>% 
  html_table()

advancedTeam <- nbaSummary %>% 
  html_nodes("#advanced-team") %>% 
  html_table()

shootingStats <- nbaSummary %>% 
  html_nodes("#shooting-team") %>% 
  html_table()

shootingStatsOpp <- nbaSummary %>% 
  html_nodes("#shooting-opponent") %>% 
  html_table()

leagueLeaders <- nbaSummary %>% 
  html_nodes("#div_leaders") %>% 
  html_table()

write.csv(perGameTeam,paste0('data/',Sys.Date(),'perGameTeam','.csv'))

