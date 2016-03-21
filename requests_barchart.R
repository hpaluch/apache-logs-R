#!/usr/bin/Rscript

# Simple chart showing request count (hits) per day
# This code is heavily based on:
#   http://www.algosome.com/articles/analyze-apache-logs-r.html

# Apache Log is expected to be like this:
# 10.10.10.10 AgentDashboard login [21/Feb/2016:01:01:01 +0100] "GET /otrs/index.pl?Action=AgentDashboard HTTP/1.1" 200 163177 "Referer" "Uuser Agent" 3
# Note: last number is request duration in seconds (non-standard)

LOGS = read.table("access_log-no-hack",
                   sep=" ", header=F, allowEscapes=T,quote="\"")
colnames(LOGS)=c('IP','Action','Login','Date','Timezone',
                   'Request','Status','Bytes','Referer','UserAgent','Seconds')
# head(LOGS,1)
# str(LOGS)
# summary(LOGS$Seconds)

LOGS$DateOnly <- as.Date(LOGS$Date, "[%d/%b/%Y:%H:%M:%S")
# pocet requestu za den
reqs = table(LOGS$DateOnly)

png('requests-chart.png', width=400, height=400)
barplot(reqs,main="Requests per Date",ylab="Requests",las=2)
dev.off()

