# Winsorize and log transform data (only for good subjects)
require(ggplot2)

# read in data
dat = read.delim("Block2Reorganized.txt", stringsAsFactors=F)

# read in badSub and discard accordingly
badSubs = read.delim("badSubs.txt")
dat = dat[!(dat$Subno %in% badSubs$Subno),]       # returns T or F for every element in first array (F for NA)
# take out RTs < 50 ms
dat = dat[dat$RT > 50,]
# histogram of RTs
qplot(RT, data = dat, geom = "histogram", binwidth = 15)

# Log transform
#add column for logRT
dat$logRT = NULL

for (i in 1:length(row.names(dat))) {
  dat$logRT[i] = log(dat$RT[i])
}

# histogram of RTs
qplot(logRT, data = dat, geom = "histogram")

# add winsorized values too (log transformed)
dat$logRT.winz = dat$logRT

for (i in unique(dat$Subno)) {
  subdat = dat[dat$Subno == i,]
  #create cut off
  cutoff = mean(subdat$logRT) + 3*(sd(subdat$logRT))
  dat$logRT.winz[dat$Subno == i & dat$logRT > cutoff] = cutoff
}

# histogram of RTs
qplot(logRT.winz, data = dat, geom = "histogram")

# add winsorized values too (not log transformed)
dat$RT.winz = dat$RT

for (i in unique(dat$Subno)) {
  subdat = dat[dat$Subno == i,]
  #create cut off
  cutoff = mean(subdat$RT) + 3*(sd(subdat$RT))
  dat$RT.winz[dat$Subno == i & dat$RT > cutoff] = cutoff
}

# histogram of RTs
qplot(RT.winz, data = dat, geom = "histogram")
# still really skewed


# add columns so they match up with spring data
dat$ParRace = NA
dat$ParGender = NA


write.table(dat, "Fall_Block2Reorganized_log_winz.txt", sep = "\t", row.names=F)





# Look for outliers according to subject
highCount = data.frame(NULL)
for (i in unique(dat$Subno)) {
  subdat = dat[dat$Subno == i,]
  #create cut off
  cutoff = mean(subdat$RT) + 3*(sd(subdat$RT))
  # count up number above cutoff
  NumHigh = sum(subdat$RT > cutoff)
  highCount = rbind(highCount, data.frame("Subno" = subdat$Subno[1],
                                          "Mean" = mean(subdat$RT),
                                          "Cutoff" = cutoff,
                                          "NumHigh" = NumHigh))
}
# check
checkHigh = data.frame(NULL)
for (i in unique(dat$Subno)) {
  subdat = dat[dat$Subno == i,]
  NumHigh = sum(subdat$logRT > highCount$cutoff[i])
  checkHigh = rbind(checkHigh, data.frame("Subno" = i,
                                          "Mean" = highCount$Mean[i],
                                          "Cutoff" = highCount$Cutoff[i],
                                          "NumHigh" = NumHigh))
}
