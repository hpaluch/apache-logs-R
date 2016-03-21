#!/usr/bin/Rscript

# makes simple bar chart of Counts by Apache Status Code
# This code is heavily based on 
# https://www.usenix.org/system/files/1403_11-15_tsoukalos.pdf 


# Apache Log is expected to be like this:
# 10.10.10.10 AgentDashboard login [21/Feb/2016:01:01:01 +0100] "GET /otrs/index.pl?Action=AgentDashboard HTTP/1.1" 200 163177 "Referer" "Uuser Agent" 3
# Note: last number is request duration in seconds (non-standard)

LOGS = read.table("access_log-2016-03-16-no-hack",
                   sep=" ", header=F, allowEscapes=T,quote="\"")
colnames(LOGS)=c('IP','Action','Login','Date','Timezone',
                   'Request','Status','Bytes','Referer','UserAgent','Seconds')

# summary(LOGS$Seconds)
# jak pouzit symbolicke jmeno misto indexu???
#table(LOGS[,7])

png('status-chart.png', width=400, height=400)
barplot(table(LOGS[,"Status"]),main="Status Code Count",xlab="Status Code",ylab="Requests")
dev.off()

