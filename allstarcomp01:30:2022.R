library(rvest)
library(dplyr) # for functions

nbaPerGamePlayers <- read_html("https://www.basketball-reference.com/leagues/NBA_2022_per_game.html")

playersTable <- nbaPerGamePlayers %>% 
  html_nodes("#per_game_stats") %>% 
  html_table()

playersTabledf <- as.data.frame(playersTable)

allStarStartersList <- c("Kevin Durant","Giannis Antetokounmpo","Joel Embiid", "Trae Young", "DeMar DeRozan", "LeBron James", "Nikola Jokić",
"Andrew Wiggins", "Stephen Curry", "Ja Morant") 

allStarStartersListWOWiggins <- c("Kevin Durant","Giannis Antetokounmpo","Joel Embiid", "Trae Young", "DeMar DeRozan", "LeBron James", "Nikola Jokić",
"Stephen Curry", "Ja Morant") 

andrewWiggins <- filter(playersTabledf,  Player %in% "Andrew Wiggins" )
andrewWiggins <- andrewWiggins[,-c(1:3,5)]
andrewWiggins <- t(andrewWiggins)

desmondBane <- filter(playersTabledf,  Player %in% "Desmond Bane" )
desmondBane <- desmondBane[,-c(1:3,5)]
desmondBane <- t(desmondBane)

KAT <- filter(playersTabledf,  Player %in% "Karl-Anthony Towns")
KAT <- KAT[,-c(1:3,5)]
KAT <- t(KAT)

rudyGobert <- filter(playersTabledf,  Player %in% "Rudy Gobert" )
rudyGobert <- rudyGobert[,-c(1:3,5)]
rudyGobert <- t(rudyGobert)

bojanBogdanović<- filter(playersTabledf,  Player %in% "Bojan Bogdanović" )
bojanBogdanović<- bojanBogdanović[,-c(1:3,5)]
bojanBogdanović<- t(bojanBogdanović)

allStarStarters2022 <- filter(playersTabledf,  Player %in% allStarStartersList )
allStarStarters2022StatsOnly <- allStarStarters2022[,-c(1:3,5)]
allStarStarters2022StatsOnly  <- lapply(allStarStarters2022StatsOnly ,as.numeric)
allStarStarters2022Averages <- sapply(allStarStarters2022StatsOnly , mean,na.rm = TRUE)
allStarStarters2022Averages <- round(allStarStarters2022Averages,3)

allStarStarters2022WOWiggins  <- filter(playersTabledf,  Player %in% allStarStartersListWOWiggins )
allStarStarters2022WOWigginsStatsOnly <- allStarStarters2022WOWiggins[,-c(1:3,5)]
allStarStarters2022WOWigginsStatsOnly  <- lapply(allStarStarters2022WOWigginsStatsOnly ,as.numeric)
allStarStarters2022AveragesWOWiggins <- sapply(allStarStarters2022WOWigginsStatsOnly , mean,na.rm = TRUE)
allStarStarters2022AveragesWOWiggins <- round(allStarStarters2022AveragesWOWiggins,3)

wigginsComp<- data.frame(andrewWiggins,allStarStarters2022AveragesWOWiggins,allStarStarters2022Averages)

wigginsVSOthers <- data.frame(allStarStarters2022AveragesWOWiggins,andrewWiggins,desmondBane,KAT,rudyGobert,bojanBogdanović)

rownames(wigginsComp) <- c("Age","G","GS","MP","FG","FGA","FG%","3P","3PA","3P%","2P","2PA","2P%","eFG%","FT","FTA","FT%","ORB","DRB","TRB","AST","STL","BLK","TOV","PF","PTS")
rownames(wigginsVSOthers) <- c("Age","G","GS","MP","FG","FGA","FG%","3P","3PA","3P%","2P","2PA","2P%","eFG%","FT","FTA","FT%","ORB","DRB","TRB","AST","STL","BLK","TOV","PF","PTS")

