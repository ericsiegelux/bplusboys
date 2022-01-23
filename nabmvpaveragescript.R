nbamvp <- read_html("https://www.basketball-reference.com/awards/mvp.html")


table <- nbamvp %>% 
  html_nodes("#mvp_NBA") %>% 
  html_table()

statsonly <- mvptable[,7:18]

statsonly2000s<- statsonly[12:21,] 

statsonly2000snonames <- statsonly2000s[-1,]
numericstats2000s <- lapply(statsonly2000snoname,as.numeric)
sapply(numericstats2000s, mean,na.rm = TRUE)
averages2000s <- sapply(numericstats2000s, mean,na.rm = TRUE)
averages2000s

#colnames(finalDF) <- statnames