library(rvest)
library(dplyr) # for functions
library(stringr)
library(tidyr)

nbaMonths <- c("october","november","december","january","february","march","april")
allGames <- data_frame()

for (month in nbaMonths)
{
  nbaMonth <- read_html(paste0('https://www.basketball-reference.com/leagues/NBA_2022_games-',month,'.html'))
  
  nbaMonth <- nbaMonth %>% 
    html_nodes("#schedule") %>% 
    html_table()
  
  nbaMonth <- as.data.frame(nbaMonth)
  
  allGames <- rbind(allGames,nbaMonth)
}

allGames <- allGames %>% 
  separate(Date, c("Day of The Week", "Day","Year"), sep = ",")

allGames$Day <- paste(allGames$Day,allGames$Year)

drops <- c("Year")
allGames <- allGames[ , !(names(allGames) %in% drops)]

nbaAbbrev <-read_html("https://en.wikipedia.org/wiki/Wikipedia:WikiProject_National_Basketball_Association/National_Basketball_Association_team_abbreviations")

nbaAbbrevTable <- nbaAbbrev %>% 
  html_nodes(".wikitable") %>% 
  html_table()

nbaAbbrevTable <- as.data.frame(nbaAbbrevTable)

for (row in 1:nrow(allGames)) {
   fullNameRowVisitor <- which(grepl(allGames[row,"Visitor.Neutral"], nbaAbbrevTable$X2))
   fullNameRowHome <- which(grepl(allGames[row,"Home.Neutral"], nbaAbbrevTable$X2))
   allGames[row, "Visitor.Neutral"] <- nbaAbbrevTable[fullNameRowVisitor,"X1"]
   allGames[row, "Home.Neutral"] <- nbaAbbrevTable[fullNameRowHome,"X1"]
}

for (row in 1:nrow(allGames)) {
  if(allGames[row,"Var.8"] == " "){
    allGames[row,"Var.8"] <- "0"
  }
  else{
    otValue <- strsplit(allGames[row,"Var.8"], "")[[1]][1]
    allGames[row,"Var.8"] <- otValue
  }
}

allGames$marginofVictory <- allGames$PTS.1 - allGames$PTS

allGames$totalPoints <- allGames$PTS.1 + allGames$PTS

drops <- c("Var.7")
allGames <- allGames[ , !(names(allGames) %in% drops)]

colnames(allGames) <- c("Day of The Week","Day","Start Time (ET)", "Visitor/Neutral","Visitor Points",  "Home/Neutral" , 
 "Home Points" , "OT", "Attendance", "Notes","Margin of Victory", "Total Points" )


